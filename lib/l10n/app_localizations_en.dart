// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Yes';

  @override
  String get commonNo => 'No';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonShare => 'Share';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonError => 'Error';

  @override
  String get commonSuccess => 'Success';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonNext => 'Next';

  @override
  String get commonBack => 'Back';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonDone => 'Done';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get chatBlockedMessage =>
      'Cannot share personal information or inappropriate content';

  @override
  String get mapEmptyHintFridayTime =>
      'Empty now? Normal! 😊 Peak time is 6-10 PM when everyone\'s active 🌃';

  @override
  String get vibeLabelBrainMode => 'Brain Mode';

  @override
  String get vibeLabelLatteBreak => 'Latte Break';

  @override
  String get vibeLabelSportMode => 'Sport Mode';

  @override
  String get vibeLabelSoundLoop => 'Sound Loop';

  @override
  String get vibeLabelCityWalk => 'City Walk';

  @override
  String get vibeLabelContentMode => 'Content Mode';

  @override
  String get vibeLabelChillNight => 'Chill Night';

  @override
  String get vibeLabelPartyMode => 'Party Mode';

  @override
  String get scanYourVibe => 'Lock your vibe ⚡';

  @override
  String get pickYourMood => 'Pick your vibe & see what is happening rn 👀';

  @override
  String waitMinutes(int minutes) {
    return 'Wait $minutes min ⏰';
  }

  @override
  String get swipeDownToMap => '↓ Swipe down to see map';

  @override
  String get changeYourMood => 'Change your mood';

  @override
  String get swipeUp => 'Swipe up ↑';

  @override
  String get youAreNotAlone => 'You\'re not alone!';

  @override
  String get you => 'YOU';

  @override
  String get others => 'others';

  @override
  String get days => 'days';

  @override
  String streak(int days) {
    return '🔥 Streak: $days days';
  }

  @override
  String get shareMyVibe => '📤 Share my vibe';

  @override
  String get close => 'Close';

  @override
  String get happy => 'happy';

  @override
  String get nearby => 'nearby';

  @override
  String get enableLocationSettings => 'Enable location in settings';

  @override
  String get errorTryAgain => 'Error, try again';

  @override
  String get networkError => 'Network error';

  @override
  String get missingConfiguration => 'Missing configuration';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'no cap, feeling $emotion rn 💭 who else? check -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'My vibe on MoodMap! 🌟';

  @override
  String get pingErrorYourVibeExpired =>
      'Your vibe has expired, place a new one';

  @override
  String get pingSentSuccess => 'Ping sent! ⚡ 60s to get Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'Wait $seconds seconds';
  }

  @override
  String get pingSomeoneAlreadySent => 'Someone already sent a ping';

  @override
  String get pingPersonInSpark => 'This person is in a PW chat';

  @override
  String get pingThisVibeExpired => 'This vibe has expired';

  @override
  String get pingFailedToSend => 'Failed to send';

  @override
  String get pingSendingError => 'Sending error';

  @override
  String get pingCancelled => 'Ping cancelled';

  @override
  String get pingCancelledBySender => 'Ping was cancelled by sender';

  @override
  String get pingErrorConnecting => 'Error connecting with PW mate';

  @override
  String get pingErrorStartingChat => 'Error starting chat session';

  @override
  String get chatTimeNow => 'now';

  @override
  String chatTimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String chatTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get distanceVeryClose => 'very close';

  @override
  String distanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String distanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get sparkDefaultAlias1 => 'PW mate 1';

  @override
  String get sparkDefaultAlias2 => 'PW mate 2';

  @override
  String get birthYearTitle => 'your birth year';

  @override
  String get birthYearPrivacyText => 'private • never shown to anyone';

  @override
  String get birthYearDefaultGeneration => 'Cool Gen ⭐';

  @override
  String get genLabel2012 => 'iPad Kids 📱';

  @override
  String get genLabel2011 => 'Minecraft OGs ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'Instagram Gen 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'TikTok Kids 🎬';

  @override
  String get genLabel2006 => 'YouTube Gen 🎮';

  @override
  String get genLabel2005 => 'Facebook Era 👍';

  @override
  String get genLabel2004 => 'Snapchat 👻';

  @override
  String get genLabel2003 => 'MSN Era 💬';

  @override
  String get genLabel2002 => 'iPod Gen 🎧';

  @override
  String get genLabel2001 => 'Potterheads ⚡';

  @override
  String get genLabel2000 => 'Y2K Kids 🌐';

  @override
  String get genLabel1999 => 'Matrix Gen 💊';

  @override
  String get genLabel1998 => 'Game Boy 🎮';

  @override
  String get genLabel1997 => 'Pokémon 🔴';

  @override
  String get genLabel1996 => 'AOL Kids 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'Friends Era ☕';

  @override
  String get genLabel1993 => 'Sonic Gen 💨';

  @override
  String get genLabel1992 => 'Cartoon Network 📺';

  @override
  String get genLabel1991 => 'SNES Kids 🎮';

  @override
  String get genLabel1990 => 'MTV Gen 🎸';

  @override
  String get genLabel1989 => 'NES Era 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'VHS Kids 📼';

  @override
  String get genLabel1986 => 'Arcade Gen 👾';

  @override
  String get genLabel1985 => 'BTTF Era ⏰';

  @override
  String get genLabel1984 => 'Mac Kids 🍎';

  @override
  String get genLabel1983 => 'Star Wars ⚔️';

  @override
  String get genLabel1982 => 'E.T. Gen 👽';

  @override
  String get genLabel1981 => 'MTV Start 📺';

  @override
  String get genLabel1980 => 'Pac-Man 👾';

  @override
  String get genLabel1979 => 'Disco Era 🪩';

  @override
  String get genLabel1978 => 'Space Invaders 🚀';

  @override
  String get genLabel1977 => 'Star Wars OG 🌟';

  @override
  String get genLabel1976 => 'Punk Rock 🎸';

  @override
  String get genLabel1975 => 'Jaws Gen 🦈';

  @override
  String get genLabel1974 => 'Disco Start 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'Pong Era 🏓';

  @override
  String get genLabel1971 => 'Zeppelin 🎸';

  @override
  String get genLabel1970 => 'Beatles Gen 🎵';

  @override
  String get genLabel1969 => 'Legends 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmptyTitle => 'No emotions yet';

  @override
  String get historyEmptySubtitle =>
      'Start sharing your moods\nto see your history';

  @override
  String get historyMyEmotions => 'My emotions';

  @override
  String get historyStatTotal => 'Total';

  @override
  String get historyStatDominant => 'Dominant';

  @override
  String get historyToday => 'Today';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => 'Trends';

  @override
  String get trendsSubtitle => 'City stats are gathering';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'It\'s your own vibe';

  @override
  String get mapErrorNeedActiveVibeToPing =>
      'You need an active vibe to send pings';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'You already have an active ping or vibe is unavailable';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'You have been restricted for $time';
  }

  @override
  String get mapBanRestrictionLifted =>
      'Restriction lifted! You can share vibes again';

  @override
  String mapSuccessVibeSent(int count) {
    return 'Vibe sent! $count others nearby 🎉';
  }

  @override
  String get mapTutorialTapToSpark =>
      'tap someone\'s vibe • get PW chat in 60s';

  @override
  String mapActivePingStatus(int seconds) {
    return 'Active ping (${seconds}s) - Tap here to cancel';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin =>
      'see what\'s poppin\' around you rn';

  @override
  String get onboardingButtonLetsGo => 'let\'s go';

  @override
  String get onboardingBadgeAge13Plus => '13+ only';

  @override
  String get onboardingValueTitleInstantSparks => 'instant PW chat';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'connect in 60 sec';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'hyperlocal vibes';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => 'only 6km radius';

  @override
  String get onboardingValueTitleNoProfiles => 'no profiles';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'just pure moments';

  @override
  String get onboardingButtonImReady => 'i\'m ready';

  @override
  String get onboardingLocationTitle => 'unlock your area';

  @override
  String get onboardingLocationSubtitle => 'see moods within 6km radius';

  @override
  String get onboardingLocationPrivacyTitle => 'privacy first';

  @override
  String get onboardingLocationPrivacyBullet1 => 'only when app is open';

  @override
  String get onboardingLocationPrivacyBullet2 => 'no background tracking';

  @override
  String get onboardingLocationPrivacyBullet3 => 'anonymous vibes only';

  @override
  String get onboardingButtonEnableRadar => 'enable radar';

  @override
  String get onboardingButtonMaybeLater => 'maybe later';

  @override
  String get onboardingNotificationTitle => 'never miss a PW chat';

  @override
  String get onboardingNotificationSubtitle =>
      'get pinged when it\'s lit nearby';

  @override
  String get onboardingNotificationFeature1 =>
      'instant pings when someone vibes';

  @override
  String get onboardingNotificationFeature2 => 'daily vibe reminders';

  @override
  String get onboardingNotificationFeature3 => 'hot spots alerts';

  @override
  String get onboardingButtonTurnOnPings => 'turn on pings';

  @override
  String get onboardingButtonNotNow => 'not now';

  @override
  String get onboardingLegalTitle => 'almost there!';

  @override
  String get onboardingLegalAgeRequirement => 'you must be 13 or older';

  @override
  String get onboardingLegalAgeSubtitle => 'ping & wink is for teens and up';

  @override
  String get onboardingLegalConsent =>
      'by tapping continue, you confirm you\'re 13+ and agree to our';

  @override
  String get onboardingLegalTerms => 'terms';

  @override
  String get onboardingLegalAnd => ' & ';

  @override
  String get onboardingLegalPrivacyPolicy => 'privacy policy';

  @override
  String get onboardingLegalSafetyFeature1 => 'anonymous vibes only';

  @override
  String get onboardingLegalSafetyFeature2 => 'instant blocking & reporting';

  @override
  String get onboardingLegalSafetyFeature3 => '20 min timeout for bad behavior';

  @override
  String get onboardingButtonImAge13AndAgree => 'i\'m 13+ and i agree';

  @override
  String get onboardingButtonImUnder13 => 'i\'m under 13';

  @override
  String get onboardingLocationDeniedTitle => 'you\'ll miss all the PW sparks';

  @override
  String get onboardingLocationDeniedMessage =>
      'without location, you can\'t:\n• see who\'s around\n• send pings\n• get winks\n• PW spark connections';

  @override
  String get onboardingButtonGoBack => 'go back';

  @override
  String get onboardingButtonExitApp => 'exit app';

  @override
  String get onboardingNotificationDeniedTitle => 'you\'ll miss all the fun';

  @override
  String get onboardingNotificationDeniedMessage =>
      'without notifications:\n• no one can ping you\n• you\'ll miss PW sparks nearby\n• zero connections possible\n\nour users enable notifications';

  @override
  String get onboardingButtonLetMeReconsider => 'let me reconsider';

  @override
  String get onboardingButtonContinueAnyway => 'continue anyway';

  @override
  String get onboardingAgeDialogTitle => 'see you later!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink is for users 13 and older. come back when you\'re old enough!';

  @override
  String get onboardingButtonUnderstood => 'understood';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'now';

  @override
  String get onboardingNotificationExamplePing => 'new ping 230m away';

  @override
  String get onboardingNotificationExampleMessage => 'someone vibes with you';

  @override
  String get onboardingMapNotification => 'someone sparked 753m away';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• only when app is open\n• no background tracking\n• anonymous vibes only';

  @override
  String get onboardingLocationDeniedFormatted =>
      'without location, you can\'t:\n• see who\'s around\n• send pings\n• get winks\n• spark connections';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'without notifications:\n• no one can ping you\n• you\'ll miss vibes nearby\n• zero connections possible\n\nour users enable notifications';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'Connect with emotions';

  @override
  String get settingsShareTitle => 'Share with friends';

  @override
  String get settingsShareSubtitle => 'Invite others to discover vibes';

  @override
  String get settingsSectionPreferences => 'Preferences';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionSupport => 'Support';

  @override
  String get settingsSectionDataManagement => 'Data Management';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsNotificationsEnabled => 'Enabled';

  @override
  String get settingsNotificationsDisabled => 'Disabled';

  @override
  String get settingsMapThemeTitle => 'Map theme';

  @override
  String get settingsMapThemeCyberpunk => 'Cyberpunk';

  @override
  String get settingsMapThemeMinimalist => 'Minimalist';

  @override
  String get settingsLocationModeTitle => 'Location mode';

  @override
  String get settingsLocationModeSoft => 'Location shifts, just for style';

  @override
  String get settingsLocationModeExact => 'Your vibe right where it happens';

  @override
  String get settingsDeleteVibeTitle => 'Delete my vibe';

  @override
  String get settingsDeleteVibeSubtitle => 'Remove your emotion from the map';

  @override
  String get settingsPrivacyTitle => 'Privacy Policy';

  @override
  String get settingsPrivacySubtitle => 'How we protect your data';

  @override
  String get settingsTermsTitle => 'Terms of Service';

  @override
  String get settingsTermsSubtitle => 'Rules for using the app';

  @override
  String get settingsHelpTitle => 'Help Center';

  @override
  String get settingsHelpSubtitle => 'FAQ and guides';

  @override
  String get settingsContactTitle => 'Contact';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'Delete my account';

  @override
  String get settingsDeleteAccountSubtitle => 'Erase all your data';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Just Vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'Device ID: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => 'Delete your vibe?';

  @override
  String get settingsDeleteVibeDialogMessage =>
      'Your emotion will be removed from the map';

  @override
  String get settingsVibeDeletedSuccess => 'Your vibe has been deleted';

  @override
  String get settingsVibeDeleteError => 'Error deleting vibe';

  @override
  String get settingsNotificationWarningTitle => 'Warning!';

  @override
  String get settingsNotificationWarningMessage =>
      'If you disable notifications, you won\'t be able to receive PINGS from other users.\n\nPW chats (connections) cannot be established.\n\nDo you really want to disable?';

  @override
  String get settingsNotificationWarningCancel => 'Cancel';

  @override
  String get settingsNotificationWarningDisable => 'Disable anyway';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ Notifications disabled - You won\'t receive any pings';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ Notifications enabled - You can receive pings';

  @override
  String get settingsMapThemeCyberpunkActivated =>
      'Cyberpunk mode activated 🌃';

  @override
  String get settingsMapThemeDayActivated => 'Day mode activated ☀️';

  @override
  String get settingsSoftModeEnabled => 'Soft mode on! Your vibe is shifted 🌊';

  @override
  String get settingsNormalModeEnabled => 'Normal mode on! Exact location 📍';

  @override
  String get settingsIdCopied => 'ID copied';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ Delete account';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'This action is irreversible. All your emotions and data will be permanently deleted.\n\nAre you sure?';

  @override
  String get settingsDeleteAccountDialogDelete => 'Delete';

  @override
  String get settingsDeleteAccountError => 'Error deleting account';

  @override
  String get settingsModerationPanelTitle => '🔐 Moderation Panel';

  @override
  String get settingsModerationPanelSubtitle => 'For App Store Review Only';

  @override
  String get settingsModerationActiveBans => 'Active Bans';

  @override
  String get settingsModerationReports => 'Reports';

  @override
  String get settingsModerationClearData => 'Clear Test Data';

  @override
  String get settingsModerationDataCleared => 'Test data cleared';

  @override
  String get sparkConnectingToChat => 'Connecting to PW chat...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => 'Ended';

  @override
  String get sparkSendFirstMessage => 'Send first message!';

  @override
  String get sparkWaitingForMate => 'Waiting for PW mate...';

  @override
  String get sparkMessagePlaceholder => 'Message...';

  @override
  String get sparkWaitForReply => 'Wait for reply...';

  @override
  String get sparkChatEndedPlaceholder => 'Chat ended';

  @override
  String get sparkLeaveChat => 'Leave PW chat?';

  @override
  String get sparkChatEndForBoth => 'Chat will end for both PW mates';

  @override
  String get sparkStay => 'Stay';

  @override
  String get sparkLeave => 'Leave';

  @override
  String get sparkExtended => 'Extended! +3 min ⚡';

  @override
  String get sparkWaitingForOther => 'Waiting for PW mate...';

  @override
  String get sparkMaxExtensionsReached => 'Maximum extensions reached';

  @override
  String get sparkFailedToExtend => 'Failed to extend';

  @override
  String get sparkFailedToSend => 'Failed to send';

  @override
  String get sparkMessageTooLong => 'Message too long (max 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'Error initializing chat: $error';
  }

  @override
  String get sparkUserBanned => 'User banned for 7 minutes';

  @override
  String get sparkRestrictedForBanning =>
      'You have been restricted for excessive banning';

  @override
  String get sparkReportSubmitted => 'Report submitted';

  @override
  String get sparkBehaviorRestriction =>
      'You have been restricted for inappropriate behavior';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'SPARK THE MOMENT';

  @override
  String trendsEmotionalPulse(String time) {
    return 'Emotional pulse $time';
  }

  @override
  String get trendsTimeMorning => 'this morning';

  @override
  String get trendsTimeAfternoon => 'this afternoon';

  @override
  String get trendsTimeEvening => 'tonight';

  @override
  String get trendsTimeLateNight => 'late night';

  @override
  String get trendsActiveVibes => 'Active vibes';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => 'Dominant emotion';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% of PW mates';
  }

  @override
  String get trendsEmotionDistribution => 'Emotion distribution';

  @override
  String get trendsQuote1 => 'Every shared emotion creates a connection ✨';

  @override
  String get trendsQuote2 => 'Together we create the emotion map 🗺️';

  @override
  String get trendsQuote3 => 'Your vibe can change someone\'s day 💫';

  @override
  String get trendsQuote4 => 'PW chat start with a simple ping ⚡';

  @override
  String get banOverlayTitle => 'Temporarily Restricted';

  @override
  String get banOverlayMessage =>
      'Your PW mate found your message inappropriate';

  @override
  String get banOverlayRestrictionInfo =>
      'You cannot share vibes during this time';

  @override
  String get bottomNavMap => 'Map';

  @override
  String get bottomNavHistory => 'History';

  @override
  String get bottomNavTrends => 'Trends';

  @override
  String get bottomNavSettings => 'Settings';

  @override
  String get guidelinesTitle => 'Community Guidelines';

  @override
  String get guidelinesRespectTitle => 'Be respectful';

  @override
  String get guidelinesRespectSubtitle => 'Treat everyone with kindness';

  @override
  String get guidelinesNoHarassmentTitle => 'No harassment';

  @override
  String get guidelinesNoHarassmentSubtitle =>
      'Don\'t send inappropriate messages';

  @override
  String get guidelinesKeepRealTitle => 'Keep it real';

  @override
  String get guidelinesKeepRealSubtitle => 'Share genuine vibes only';

  @override
  String get guidelinesHaveFunTitle => 'Have fun';

  @override
  String get guidelinesHaveFunSubtitle => 'Enjoy PW sparking connections!';

  @override
  String get guidelinesViolationWarning =>
      'Violations may result in temporary or permanent restrictions';

  @override
  String get guidelinesButtonUnderstand => 'I Understand';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'Day $day - Keep your streak alive!';
  }

  @override
  String get emotionSelectorTapYourVibe => 'TAP YOUR VIBE';

  @override
  String get emotionSelectorWhatsYourVibe => 'what\'s your vibe rn?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count active now';
  }

  @override
  String get miniBarSendNewPing => 'Send a new ping';

  @override
  String get miniBarPingActive => 'Your ping is active';

  @override
  String get moderationBanTitle => 'Ban for 7 min';

  @override
  String get moderationBanSubtitle => 'Temporarily restrict this user';

  @override
  String get moderationReportTitle => 'Report';

  @override
  String get moderationReportSubtitle => 'Report inappropriate behavior';

  @override
  String get moderationEndChatTitle => 'End Chat';

  @override
  String get moderationEndChatSubtitle => 'Leave this PW session';

  @override
  String get moderationReportDialogTitle => 'Report User';

  @override
  String get moderationReportReasonHarassment => 'Harassment';

  @override
  String get moderationReportReasonSpam => 'Spam';

  @override
  String get moderationReportReasonHateSpeech => 'Hate speech';

  @override
  String get moderationReportReasonOther => 'Other';

  @override
  String get moderationReportSendButton => 'Send Report';

  @override
  String get pingBottomVibeTooFar => 'Vibe too far (max 6km)';

  @override
  String get pingBottomVibeTooFarMessage =>
      'Vibe too far - max 6km to send ping';

  @override
  String get pingBottomTooFar => 'TOO FAR';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'very close';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get pingBottomTimeNow => 'now';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get vibeAnimBrainEnergy => 'BIG BRAIN ENERGY';

  @override
  String get vibeAnimCozy => 'VIBE CHECK: COZY';

  @override
  String get vibeAnimSweatSlay => 'SWEAT. SLAY. REPEAT';

  @override
  String get vibeAnimLostInBeat => 'LOST IN THE BEAT';

  @override
  String get vibeAnimCityLights => 'CITY LIGHTS: ON';

  @override
  String get vibeAnimLightsCameraVibes => 'LIGHTS. CAMERA. VIBES.';

  @override
  String get vibeAnimEveningVibes => 'EVENING VIBES';

  @override
  String get vibeAnimPartyMode => 'PARTY MODE: ON';

  @override
  String get vibeAnimSubBrainTime => 'Big brain time 🧠';

  @override
  String get vibeAnimSubCaffeine => 'Caffeine vibes ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'No days off 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'Volume: MAX 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'Urban explorer 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'Create & glow 📸';

  @override
  String get vibeAnimSubNightFlow => 'Night Flow 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'Unleash the chaos 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE SET';

  @override
  String get vibeAnimDefaultSubMessage => 'Let\'s go!';

  @override
  String get viralShareFailed => 'Failed to share';

  @override
  String get viralShareTextNight =>
      'everyone\'s asleep. but something\'s happening\npingandwink.com';

  @override
  String get viralShareTextEvening => 'evening. the best time\npingandwink.com';

  @override
  String get viralShareTextDefault =>
      'what\'s happening right now?\npingandwink.com';

  @override
  String get viralShareMainText => 'what\'s happening\nwhile you read this?';

  @override
  String get viralShareFindOut => 'find out';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'share →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate wants to connect';

  @override
  String get winkBannerWinkBack => 'WINK BACK';
}
