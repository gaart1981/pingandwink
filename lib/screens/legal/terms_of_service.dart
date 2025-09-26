// lib/screens/legal/terms_of_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../config/theme.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Terms of Service',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A0B2E),
              Colors.black,
            ],
          ),
        ),
        child: Markdown(
          data: _termsText,
          styleSheet: MarkdownStyleSheet(
            h1: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            h2: const TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
            h3: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            p: const TextStyle(
                color: Colors.white70, fontSize: 14, height: 1.5),
            listBullet: const TextStyle(color: AppTheme.primaryColor),
            strong: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            a: const TextStyle(
                color: AppTheme.primaryColor,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }

  static const String _termsText = '''
# Terms of Service

**Last Updated: September 19, 2025**  
**Effective Date: September 19, 2025**

## 1. Acceptance of Terms

By downloading, installing, or using Ping&Wink ("Service," "App," "we," "us," "our"), you acknowledge that you have read, understood, and agree to be bound by these Terms of Service ("Terms"). If you do not agree, do not use the Service.

## 2. Description of Service

Ping&Wink is a location-based social application that allows users to:
• Share emotional states ("vibes") anonymously on a map
• View emotions of other anonymous users nearby
• Send connection requests ("pings")
• Respond to connections ("winks")
• Engage in time-limited chat sessions ("sparks")

All vibes automatically expire after 2 hours. Chat sessions last 3 minutes with possible extensions up to 9 minutes total.

## 3. Age Requirements

**You must be at least 13 years old to use this Service.**

• Users under 18 should have parental consent
• We use birth year verification for age-appropriate matching
• Users under 18 can only interact with users within 6 years of their age
• We reserve the right to terminate accounts of users under 13

## 4. User Accounts

• The app uses anonymous device identifiers
• No registration or personal information required
• You are responsible for all activity under your device ID
• One account per device

## 5. User Conduct

You agree NOT to:

### 5.1 Prohibited Content
• Share illegal, harmful, or offensive content
• Post sexual, pornographic, or inappropriate material
• Engage in harassment, bullying, or threats
• Share personal information (yours or others')
• Spread hate speech or discrimination
• Impersonate others or misrepresent your age

### 5.2 Prohibited Activities
• Use the Service for illegal activities
• Attempt to hack, exploit, or damage the Service
• Create multiple accounts to evade bans
• Use automated systems or bots
• Collect data from other users
• Use the Service for commercial purposes
• Arrange meetings with minors

### 5.3 Safety Guidelines
• Never share personal contact information
• Report inappropriate behavior immediately
• Block users who make you uncomfortable
• Meet other users at your own risk (we recommend public places)

## 6. Content Moderation

• We provide reporting and blocking features
• Users can be temporarily banned (20 minutes) for violations
• Repeat offenders may be permanently banned
• We reserve the right to remove content and terminate accounts
• Moderation decisions are final

## 7. Intellectual Property

### 7.1 Our Rights
• The Service and its content are owned by Ping&Wink
• Our trademarks, logos, and content are protected
• You may not copy, modify, or reverse engineer the Service

### 7.2 Your Rights
• You retain rights to content you create
• By using the Service, you grant us a license to display your vibes/messages
• This license is limited to operating the Service
• Content is automatically deleted per our retention policy

## 8. Privacy

Your privacy is important to us. Please review our Privacy Policy at https://pingandwink.com/privacy which is incorporated into these Terms.

Key points:
• We collect minimal anonymous data
• Location only when app is active
• All data expires automatically
• We don't sell or share personal data

## 9. Disclaimers

### 9.1 Service Availability
• The Service is provided "AS IS" and "AS AVAILABLE"
• We don't guarantee uninterrupted or error-free service
• Features may change or be discontinued
• We may suspend or terminate the Service at any time

### 9.2 User Interactions
• We are not responsible for user behavior
• We don't verify user identities or ages beyond birth year
• Interactions with other users are at your own risk
• We are not responsible for offline meetings

### 9.3 No Warranties
We disclaim all warranties, express or implied, including:
• Fitness for a particular purpose
• Merchantability
• Non-infringement
• Security or accuracy

## 10. Limitation of Liability

TO THE MAXIMUM EXTENT PERMITTED BY LAW:

• We are not liable for any indirect, incidental, or consequential damages
• We are not liable for lost profits, data, or opportunities
• We are not liable for user conduct or content
• Our total liability is limited to €10 or the amount you paid us (if any)

This limitation applies regardless of the legal theory or remedy.

## 11. Indemnification

You agree to indemnify and hold harmless Ping&Wink from any claims, damages, losses, or expenses (including legal fees) arising from:
• Your use of the Service
• Your violation of these Terms
• Your violation of any rights of others
• Your content or interactions with other users

## 12. Modifications to Terms

• We may update these Terms at any time
• We'll notify you of material changes via app notification
• Continued use after changes means acceptance
• If you disagree with changes, stop using the Service

## 13. Termination

• You may stop using the Service at any time
• We may terminate or suspend your access for any reason
• Sections that should survive termination will remain in effect
• Termination doesn't limit our other rights or remedies

## 14. Governing Law

• These Terms are governed by the laws of France and the EU
• Any disputes will be resolved in French courts
• You consent to the jurisdiction of French courts

## 15. General Provisions

### 15.1 Entire Agreement
These Terms and our Privacy Policy constitute the entire agreement between you and Ping&Wink.

### 15.2 Severability
If any provision is found invalid, the rest remains in effect.

### 15.3 Waiver
Our failure to enforce any right doesn't waive that right.

### 15.4 Assignment
We may assign these Terms. You may not assign them without our consent.

### 15.5 Force Majeure
We're not liable for delays or failures due to circumstances beyond our control.

## 16. Safety for Minors

• Special protections apply to users under 18
• Age-inappropriate interactions are strictly prohibited
• Report any concerning behavior involving minors immediately
• We cooperate with law enforcement when required

## 17. Community Guidelines

Be respectful and authentic:
• Express genuine emotions
• Respect others' vibes
• Keep chats friendly
• Report violations
• Help create a positive community

## 18. Contact Information

For questions, concerns, or reports:

**Email:** support@pingandwink.com  
**Website:** https://pingandwink.com  
**Response Time:** Within 48-72 hours

## 19. Apple App Store Additional Terms

When downloaded from Apple App Store:
• Apple has no obligation to furnish maintenance or support
• Apple is not responsible for product warranties
• Apple is not responsible for addressing claims relating to the app
• Apple is a third-party beneficiary of these Terms

## 20. Acknowledgment

BY USING THIS SERVICE, YOU ACKNOWLEDGE THAT:
• You have read and understood these Terms
• You are at least 13 years old
• You accept all terms and conditions
• You will use the Service responsibly

---

© 2025 Ping&Wink. All rights reserved.  
Thank you for being part of our vibe community! 
''';
}
