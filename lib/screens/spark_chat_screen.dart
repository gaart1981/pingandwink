// lib/screens/spark_chat_screen.dart
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/spark_session.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';
import '../services/storage_service.dart';
import '../config/theme.dart';
import '../services/moderation_service.dart';
import '../widgets/moderation_menu.dart';
import '../services/vibe_state_manager.dart';
import '../l10n/app_localizations.dart';

/// Professional spark chat screen with working typing indicator
class SparkChatScreen extends StatefulWidget {
  final SparkSession session;

  const SparkChatScreen({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  State<SparkChatScreen> createState() => _SparkChatScreenState();
}

class _SparkChatScreenState extends State<SparkChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  RealtimeChannel? _sessionChannel;

  final List<ChatMessage> _messages = [];

  // FIX: Make fields nullable and check initialization
  String? _myDeviceId;
  String? _myAlias;
  String? _partnerAlias;
  DateTime? _expiresAt;
  bool _isInitialized = false; // Added initialization flag

  bool _canSendMessage = true;
  bool _isLoading = false;
  int _extendCount = 0;
  bool _partnerWantsExtend = false;
  bool _sessionExpired = false;

  // Typing indicator
  bool _isPartnerTyping = false;
  Timer? _typingDebounce;
  Timer? _typingHideTimer;
  Timer? _countdownTimer;
  bool _iAmTyping = false;

  // Moderation variables
  Timer? _banButtonTimer;
  bool _canBan = false;
  String? _lastMessageSender;
  DateTime? _lastTypingCheck;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      _myDeviceId = await StorageService.getDeviceId();
      _myAlias = widget.session.getMyAlias(_myDeviceId!);
      _partnerAlias = widget.session.getPartnerAlias(_myDeviceId!);

      // Connect to Realtime
      ChatService.enterChat(
        widget.session.id,
        _myDeviceId!,
        (newMessage) {
          HapticFeedback.mediumImpact();

          setState(() {
            _messages.add(newMessage);
            _canSendMessage = true;

            // Activate ban button for 35 seconds on new message
            _lastMessageSender = newMessage.senderDevice;
            if (_lastMessageSender != _myDeviceId) {
              _canBan = true;
              _banButtonTimer?.cancel();
              _banButtonTimer = Timer(const Duration(seconds: 35), () {
                if (mounted) {
                  setState(() => _canBan = false);
                }
              });
            }
          });

          _scrollToBottom();
        },
      );

      // Subscribe to session status changes
      final supabase = Supabase.instance.client;
      _sessionChannel = supabase
          .channel('session_${widget.session.id}')
          .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: 'spark_sessions',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'id',
              value: widget.session.id,
            ),
            callback: (payload) {
              final isActive = payload.newRecord['is_active'] as bool;
              final endedReason = payload.newRecord['ended_reason'] as String?;

              if (!isActive && mounted) {
                // Session ended - close chat immediately
                debugPrint('Session ended: $endedReason');

                if (endedReason == 'user_banned') {
                  // Save ban asynchronously, but don't wait for completion
                  final bannedUntil =
                      DateTime.now().add(const Duration(minutes: 7));
                  StorageService.saveBanStatus(true, bannedUntil).then((_) {
                    debugPrint('Ban status saved to cache');
                  });

                  // Show ban notification before closing
                  final l10n = AppLocalizations.of(context)!;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.sparkBehaviorRestriction),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );

                  // Delay to let user see the message
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  });
                } else {
                  // Normal session end
                  _endChat(endedReason ?? 'session_ended');
                }
              }
            },
          )
          .subscribe();

      // Listen for typing indicator
      if (ChatService.presenceChannel != null) {
        ChatService.presenceChannel!.onPresenceSync((_) {
          _checkTypingStatus();
        }).onPresenceJoin((_) {
          _checkTypingStatus();
        }).onPresenceLeave((_) {
          _checkTypingStatus();
        });
      }

      setState(() {
        _expiresAt = widget.session.expiresAt;
        _extendCount = widget.session.extendedCount;
        _isInitialized = true; // Mark that initialization is complete
      });

      if (_messages.isEmpty) {
        _canSendMessage = widget.session.device1 == _myDeviceId;
      }

      _loadMessages();
      _startCountdownTimer();

      if (_canSendMessage) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && _focusNode.canRequestFocus) {
            _focusNode.requestFocus();
          }
        });
      }

      HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Error initializing chat: $e');
      // Show error to user
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.sparkErrorInitializing(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  void _checkTypingStatus() {
    final states = ChatService.presenceChannel?.presenceState();
    if (states == null) return;

    final statesStr = states.toString();
    final typingMatches = 'typing: true'.allMatches(statesStr);
    final typingCount = typingMatches.length;

    bool partnerTyping = false;

    if (typingCount == 2) {
      partnerTyping = true;
      debugPrint('✅ Both typing - show indicator');
    } else if (typingCount == 1) {
      if (_iAmTyping) {
        partnerTyping = false;
        debugPrint('❌ Only me typing - hide indicator');
      } else {
        partnerTyping = true;
        debugPrint('✅ Partner typing - show indicator');
      }
    }

    if (mounted && partnerTyping != _isPartnerTyping) {
      setState(() {
        _isPartnerTyping = partnerTyping;
      });

      if (partnerTyping) {
        _scrollToBottom();
        _typingHideTimer?.cancel();
        _typingHideTimer = Timer(Duration(seconds: 5), () {
          if (mounted) {
            setState(() => _isPartnerTyping = false);
          }
        });
      }
    }
  }

  void _loadMessages() async {
    final messages = await ChatService.loadMessages(widget.session.id);
    if (!mounted) return;

    setState(() {
      _messages.clear();
      _messages.addAll(messages);

      if (_messages.isNotEmpty) {
        final lastMessage = _messages.last;
        _canSendMessage = lastMessage.senderDevice != _myDeviceId;
      } else {
        _canSendMessage = widget.session.device1 == _myDeviceId;
      }
    });

    _scrollToBottom();

    // Check last message for ban button
    if (_messages.isNotEmpty) {
      final lastMessage = _messages.last;
      _lastMessageSender = lastMessage.senderDevice;

      if (_lastMessageSender != _myDeviceId) {
        setState(() => _canBan = true);
        _banButtonTimer?.cancel();
        _banButtonTimer = Timer(const Duration(seconds: 35), () {
          if (mounted) {
            setState(() => _canBan = false);
          }
        });
      } else {
        setState(() => _canBan = false);
      }
    }
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final remaining = _expiresAt?.difference(DateTime.now()).inSeconds ?? 0;

      if (remaining <= 0 && !_sessionExpired) {
        setState(() {
          _sessionExpired = true;
        });
        timer.cancel();
        _endChat('timeout');
      }

      if (timer.tick % 10 == 0) {
        _checkSessionStatus();
      }

      if (mounted && (remaining % 10 == 0 || remaining <= 5)) {
        setState(() {});
      }
    });
  }

  void _checkSessionStatus() async {
    final session = await ChatService.getSession(widget.session.id);
    if (session != null && mounted) {
      setState(() {
        _expiresAt = session.expiresAt;
        _extendCount = session.extendedCount;
        _partnerWantsExtend = session
            .hasRequestedExtend(widget.session.getPartnerDevice(_myDeviceId!));
      });

      if (!session.isActive && !_sessionExpired) {
        _endChat(session.endedReason ?? 'timeout');
      }
    }
  }

  void _showEndChatConfirmation() {
    HapticFeedback.mediumImpact();
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C28),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '👋',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.sparkLeaveChat,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.sparkChatEndForBoth,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      l10n.sparkStay,
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _endChat('user_ended');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0066).withOpacity(0.2),
                      foregroundColor: const Color(0xFFFF0066),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: const Color(0xFFFF0066).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      l10n.sparkLeave,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Moderation methods
  void _showModerationMenu() {
    ModerationMenu.show(
      context: context,
      canBan: _canBan,
      onBan: _handleBan,
      onReport: (String reason) => _handleReport(reason),
      onEndChat: () => _endChat('user_ended'),
    );
  }

  Future<void> _handleBan() async {
    final partnerDevice = widget.session.getPartnerDevice(_myDeviceId!);
    final l10n = AppLocalizations.of(context)!;

    final result = await ModerationService.banUser(
      bannerDevice: _myDeviceId!,
      bannedDevice: partnerDevice,
      sessionId: widget.session.id,
    );

    if (result['success']) {
      // clear userss state
      VibeStateManager().removeBannedUserStates(partnerDevice);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.sparkUserBanned),
            backgroundColor: Colors.orange,
          ),
        );
        Navigator.of(context).pop();
      }
    } else if (result['autoban'] == true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.sparkRestrictedForBanning),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _handleReport(String reason) async {
    final partnerDevice = widget.session.getPartnerDevice(_myDeviceId!);
    final l10n = AppLocalizations.of(context)!;

    final result = await ModerationService.reportUser(
      reporterDevice: _myDeviceId!,
      reportedDevice: partnerDevice,
      reason: reason,
      sessionId: widget.session.id,
    );

    if (result['success']) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.sparkReportSubmitted),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _sendMessage() async {
    if (!_canSendMessage || _isLoading || _sessionExpired) return;

    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    if (text.length > 199) {
      final l10n = AppLocalizations.of(context)!;
      _showError(l10n.sparkMessageTooLong);
      return;
    }

    // Cancel typing indicator
    _typingDebounce?.cancel();
    ChatService.updateTypingStatus(false, _myDeviceId!);
    _iAmTyping = false;

    // Reset ban button when sending message
    setState(() => _canBan = false);
    _banButtonTimer?.cancel();

    setState(() {
      _canSendMessage = false;
      _isLoading = true;
    });

    _messageController.clear();

    final result = await ChatService.sendMessage(
      sessionId: widget.session.id,
      senderDevice: _myDeviceId!,
      message: text,
    );

    if (result['success'] == true) {
      HapticFeedback.selectionClick();
      _loadMessages();
    } else {
      _messageController.text = text;
      final l10n = AppLocalizations.of(context)!;
      _showError(result['error'] ?? l10n.sparkFailedToSend);
      setState(() => _canSendMessage = true);
    }

    setState(() => _isLoading = false);
  }

  Future<void> _requestExtend() async {
    final l10n = AppLocalizations.of(context)!;

    if (_extendCount >= 2) {
      _showError(l10n.sparkMaxExtensionsReached);
      return;
    }

    HapticFeedback.mediumImpact();

    final result = await ChatService.requestExtension(
      sessionId: widget.session.id,
      deviceId: _myDeviceId!,
    );

    if (result['extended'] == true) {
      _showSuccess(l10n.sparkExtended);
      setState(() {
        _expiresAt = DateTime.parse(result['new_expires_at']);
        _extendCount = result['extended_count'];
      });
      _startCountdownTimer();
    } else if (result['waiting_for_other'] == true) {
      _showInfo(l10n.sparkWaitingForOther);
    } else {
      _showError(result['error'] ?? l10n.sparkFailedToExtend);
    }
  }

  void _endChat(String reason) {
    _countdownTimer?.cancel();
    _typingDebounce?.cancel();

    ChatService.updateTypingStatus(false, _myDeviceId!);
    ChatService.leaveChat();
    ChatService.endChat(widget.session.id, reason);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && _scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFF0066),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.black87),
            SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showInfo(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2A2A3A),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppTheme.primaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingDot(double leftPosition, int delay) {
    return Positioned(
      left: leftPosition,
      child: TweenAnimationBuilder<double>(
        key: ValueKey('dot_$leftPosition'),
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return FutureBuilder(
            future: Future.delayed(Duration(milliseconds: delay)),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(width: 6, height: 6);
              }
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3 + (value * 0.4)),
                  shape: BoxShape.circle,
                ),
              );
            },
          );
        },
        onEnd: () {
          // Restart animation
          if (_isPartnerTyping && mounted) {
            Future.delayed(const Duration(milliseconds: 200), () {
              if (mounted) setState(() {});
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // FIX: Show loader while not initialized
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0015),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.sparkConnectingToChat,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0015),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildMessagesList(),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    final remainingSeconds =
        _expiresAt?.difference(DateTime.now()).inSeconds ?? 0;
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1F),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: _showEndChatConfirmation,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Spark icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '⚡',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Names and timer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.sparkChatTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '$_myAlias & $_partnerAlias',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: remainingSeconds > 30
                            ? AppTheme.primaryColor
                            : const Color(0xFFFF9900),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      remainingSeconds > 0
                          ? '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
                          : l10n.sparkChatEnded,
                      style: TextStyle(
                        color: remainingSeconds > 30
                            ? AppTheme.primaryColor
                            : const Color(0xFFFF9900),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Moderation menu button
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _showModerationMenu,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_vert,
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
            ),
          ),

          // Extend button
          if (_extendCount < 2 && !_sessionExpired)
            GestureDetector(
              onTap: _requestExtend,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _partnerWantsExtend
                      ? AppTheme.primaryColor.withOpacity(0.2)
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _partnerWantsExtend
                        ? AppTheme.primaryColor
                        : Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _partnerWantsExtend ? Icons.check : Icons.add,
                      color: _partnerWantsExtend
                          ? AppTheme.primaryColor
                          : Colors.white.withOpacity(0.7),
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      _partnerWantsExtend ? 'OK?' : '3m',
                      style: TextStyle(
                        color: _partnerWantsExtend
                            ? AppTheme.primaryColor
                            : Colors.white.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    final l10n = AppLocalizations.of(context)!;

    // If no messages and not typing
    if (_messages.isEmpty && !_isPartnerTyping) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '⚡',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 16),
            Text(
              _canSendMessage
                  ? l10n.sparkSendFirstMessage
                  : l10n.sparkWaitingForMate,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length + (_isPartnerTyping ? 1 : 0),
      itemBuilder: (context, index) {
        // Show typing indicator as last element
        if (_isPartnerTyping && index == _messages.length) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8, left: 0, right: 100),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C28),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _partnerAlias ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 30,
                    height: 12,
                    child: Stack(
                      children: [
                        _buildTypingDot(0, 0),
                        _buildTypingDot(10, 200),
                        _buildTypingDot(20, 400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Regular message
        if (index >= _messages.length) return const SizedBox();

        final message = _messages[index];
        final isOwn = message.isOwn(_myDeviceId!);
        final alias = isOwn ? _myAlias : _partnerAlias;

        return Align(
          alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              gradient: isOwn
                  ? LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.secondaryColor,
                      ],
                    )
                  : null,
              color: isOwn ? null : const Color(0xFF1C1C28),
              borderRadius: BorderRadius.circular(18),
              border: isOwn
                  ? null
                  : Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alias ?? '',
                  style: TextStyle(
                    color: isOwn
                        ? Colors.white.withOpacity(0.8)
                        : AppTheme.primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputBar() {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: bottomPadding > 0 ? bottomPadding + 12 : 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1F),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 40,
                maxHeight: 100,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _canSendMessage
                      ? AppTheme.primaryColor.withOpacity(0.3)
                      : Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                focusNode: _focusNode,
                enabled: _canSendMessage && !_isLoading && !_sessionExpired,
                maxLength: 199,
                maxLines: null,
                textInputAction: TextInputAction.send,
                onChanged: (text) {
                  // Send typing status
                  _typingDebounce?.cancel();

                  if (text.isNotEmpty) {
                    _iAmTyping = true;
                    debugPrint('🔍 User started typing');
                    ChatService.updateTypingStatus(true, _myDeviceId!);

                    _typingDebounce = Timer(Duration(seconds: 2), () {
                      _iAmTyping = false;
                      debugPrint('🔍 User stopped typing (timeout)');
                      ChatService.updateTypingStatus(false, _myDeviceId!);
                    });
                  } else {
                    _iAmTyping = false;
                    debugPrint('🔍 User cleared text');
                    ChatService.updateTypingStatus(false, _myDeviceId!);
                  }
                },
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: _sessionExpired
                      ? l10n.sparkChatEndedPlaceholder
                      : _canSendMessage
                          ? l10n.sparkMessagePlaceholder
                          : l10n.sparkWaitForReply,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  counterText: '',
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button
          GestureDetector(
            onTap: _canSendMessage && !_isLoading && !_sessionExpired
                ? _sendMessage
                : null,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: _canSendMessage && !_isLoading && !_sessionExpired
                    ? LinearGradient(
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.secondaryColor,
                        ],
                      )
                    : null,
                color: _canSendMessage && !_isLoading && !_sessionExpired
                    ? null
                    : Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(
                        Icons.send_rounded,
                        color: _canSendMessage && !_sessionExpired
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        size: 18,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ChatService.leaveChat();
    _sessionChannel?.unsubscribe();
    _typingDebounce?.cancel();
    _typingHideTimer?.cancel();
    _banButtonTimer?.cancel();
    _countdownTimer?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
