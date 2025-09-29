// lib/services/simple_content_filter.dart

/// Minimal content filter for Apple Review compliance
/// Blocks: contact sharing, harassment, sexual content
class SimpleContentFilter {
  
  /// Check if message contains blocked content
  static bool isMessageBlocked(String message) {
    if (message.isEmpty) return false;
    
    // Convert to lowercase for checking
    final lower = message.toLowerCase();
    
    // Remove spaces and common replacements to catch bypass attempts
    final cleaned = lower
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll('-', '')
        .replaceAll('_', '');
    
    // Check against all blocked patterns
    for (final word in _blockedWords) {
      if (lower.contains(word) || cleaned.contains(word.replaceAll(' ', ''))) {
        return true;
      }
    }
    
    // Check for phone number patterns
    if (_hasPhoneNumber(message)) return true;
    
    // Check for email pattern
    if (_hasEmail(message)) return true;
    
    // Check for social media handles
    if (_hasSocialHandle(message)) return true;
    
    return false;
  }
  
  /// Simple phone number detection
  static bool _hasPhoneNumber(String text) {
    // Look for 10+ consecutive digits
    final digitCount = RegExp(r'\d{10,}').hasMatch(text);
    // Look for formatted phone numbers
    final formatted = RegExp(r'\d{3}[-.\s]?\d{3}[-.\s]?\d{4}').hasMatch(text);
    return digitCount || formatted;
  }
  
  /// Simple email detection
  static bool _hasEmail(String text) {
    return text.contains('@') && text.contains('.');
  }
  
  /// Simple social media handle detection
  static bool _hasSocialHandle(String text) {
    if (!text.contains('@')) return false;
    final lower = text.toLowerCase();
    return lower.contains('instagram') || 
           lower.contains('insta') ||
           lower.contains('snapchat') ||
           lower.contains('snap') ||
           lower.contains('telegram') ||
           lower.contains('whatsapp');
  }
  
  /// Minimal blocked words list for Apple Review
  static const List<String> _blockedWords = [
    // === CONTACT SHARING (Most important for Apple) ===
    'my instagram', 'my insta', 'my snap', 'my snapchat',
    'my whatsapp', 'my telegram', 'my discord',
    'add me on', 'find me on', 'dm me', 'message me',
    'my number is', 'my phone', 'call me', 'text me',
    'my email', '@gmail', '@yahoo', '@hotmail', '@outlook',
    'instagram.com', 'ig.me', 't.me',
    
    // === HARASSMENT (Basic protection) ===
    'kill yourself', 'kys', 'die', 'hate you',
    'fuck you', 'fuck off', 'fucking',
    'shit', 'bitch', 'asshole', 'bastard',
    'retard', 'idiot', 'stupid', 'dumb',
    
    // === HATE SPEECH (Critical for Apple) ===
    'nigger', 'nigga', 'faggot', 'fag',
    'chink', 'spic', 'nazi',
    
    // === SEXUAL CONTENT (Child safety) ===
    'sex', 'nude', 'naked', 'dick', 'cock', 'penis',
    'pussy', 'vagina', 'boobs', 'tits',
    'send pics', 'send nudes', 'send photo',
    'horny', 'fuck me', 'suck my',
    'onlyfans', 'porn',
  ];
}