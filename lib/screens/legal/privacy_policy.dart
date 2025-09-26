// lib/screens/legal/privacy_policy.dart
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../config/theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Privacy Policy',
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
          data: _privacyPolicyText,
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

  static const String _privacyPolicyText = '''
# Privacy Policy

**Last Updated: September 19, 2025**  
**Effective Date: September 19, 2025**

## 1. Introduction

Welcome to Ping&Wink ("we," "our," or "us"). We are committed to protecting your privacy and ensuring a safe, anonymous experience. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile application.

By using Ping&Wink, you agree to the collection and use of information in accordance with this policy. If you do not agree, please do not use the app.

**⚠️ Age Requirement:** You must be at least 13 years old to use Ping&Wink. Users under 18 are subject to additional safety measures described in Section 7.

## 2. Information We Collect

### 2.1 Information You Provide
• **Birth Year:** Required for age verification and age-appropriate matching
• **Vibes/Emotions:** The mood selections you make (8 different vibes)
• **Chat Messages:** Temporary messages sent during Spark Chat sessions (3-minute sessions)

### 2.2 Information Collected Automatically
• **Device Identifier:** An anonymous device ID (platform-provided identifier on Android/iOS, or generated UUID as fallback)
• **Location Data:** Your geographic location (only when the app is actively in use)
• **Usage Data:** App interaction patterns and session information
• **Push Token:** For delivering notifications (if you enable them)

### 2.3 Information We DO NOT Collect
• Real names or personal identities
• Email addresses (unless you contact support)
• Phone numbers
• Photos or videos
• Social media profiles
• Payment information
• Contacts or address book

## 3. How We Use Your Information

We use the collected information to:
• Display vibes on the map and enable connections between users
• Enforce age-appropriate matching and content filtering
• Enable Spark Chat sessions and Ping&Wink interactions
• Send push notifications about incoming Pings (if enabled)
• Understand usage patterns to improve the service
• Investigate reports and enforce community guidelines
• Comply with legal obligations

## 4. Data Retention and Deletion

### 4.1 Automatic Data Expiration
• **Vibes on Map:** Automatically deleted after 2 hours
• **Spark Chat Messages:** Automatically deleted after 24 hours
• **Ping Requests:** Expire after 60 seconds if not accepted
• **Location Data:** Updated only when app is active

### 4.2 Manual Data Deletion
You can delete all your data at any time:
• **In-App:** Settings → Delete My Data
• **Email Request:** support@pingandwink.com

Upon deletion, we remove:
• Your device profile and birth year
• All active vibes from the map
• Any pending Pings or Winks
• Chat history (if any remains)
• Analytics data associated with your device ID

## 5. Data Sharing and Disclosure

### 5.1 We DO NOT:
• Sell your data to third parties
• Share your data with advertisers
• Use your data for marketing
• Create user profiles for targeting

### 5.2 Limited Sharing:
• **Other Users:** Only your vibe emoji and approximate location on the map
• **Chat Partners:** Only your chosen alias and messages during Spark Chat
• **Service Providers:** Technical partners necessary for operation (see Section 6)
• **Legal Requirements:** If required by law or to protect safety

## 6. Third-Party Services

We use these services to operate the app:
• **Supabase:** Database and backend infrastructure (GDPR compliant)
• **Mapbox:** Map display and geolocation services (anonymous usage)
• **OneSignal:** Push notification delivery (if you enable notifications)

These services have their own privacy policies. We ensure all partners comply with GDPR and privacy regulations.

## 7. Children's Privacy and Safety

### Age Verification and Protection:
• **Minimum Age:** Users must be at least 13 years old
• **Age Verification:** Birth year is required during onboarding
• **Age-Appropriate Matching:** 
  - 13-18 years: Can only interact with users within 6 years of their age
  - 19+ years: Can interact with users ±6 years of their age
• **Content Moderation:** Report and ban features to protect minors
• **No Personal Information:** The app prevents sharing of personal details

If we discover information from a child under 13, we will delete it immediately. To report, contact: support@pingandwink.com

## 8. Your Privacy Rights

### 8.1 Rights for All Users
• **Access:** Request information about your data
• **Delete:** Request deletion of all your data
• **Opt-out:** Disable location services or notifications
• **Withdraw Consent:** Stop using the app at any time

### 8.2 EU/EEA Users (GDPR Rights)
• **Right to Rectification:** Correct inaccurate data
• **Right to Restriction:** Limit processing of your data
• **Right to Data Portability:** Receive your data in structured format
• **Right to Object:** Object to processing activities
• **Right to Lodge a Complaint:** File with your local data protection authority

### 8.3 California Privacy Rights (CCPA)
California residents have rights to:
• Know what personal information is collected
• Know whether information is sold or disclosed (we don't sell data)
• Access and delete personal information
• Not be discriminated against for exercising rights

## 9. Data Security

We implement security measures including:
• **Encryption:** Data encrypted in transit using TLS/SSL
• **Anonymous IDs:** We use anonymous device IDs
• **Limited Access:** Only essential personnel access backend systems
• **Auto-Expiration:** Most data automatically expires
• **Secure Infrastructure:** Enterprise-grade cloud services

However, no method is 100% secure. We cannot guarantee absolute security.

## 10. Location Information

• **When Collected:** Only when the app is open and active
• **Precision:** General area rather than exact location
• **Storage:** Temporary, linked only to anonymous device ID
• **Control:** Disable in device settings (limits functionality)

## 11. Push Notifications

If you enable notifications:
• We'll notify you about incoming Pings
• Notifications contain minimal information
• You can disable them anytime in settings
• Push tokens deleted when you delete account

## 12. International Data Transfers

Your information may be processed in countries other than your residence. We ensure appropriate safeguards protect your information in accordance with this policy.

## 13. Changes to This Privacy Policy

We may update this Privacy Policy. We will notify you of material changes by:
• Posting the new Privacy Policy here
• Updating the "Last Updated" date
• Sending a push notification (if enabled)
• Showing an in-app notice

Continued use after changes constitutes acceptance.

## 14. Contact Information

For questions or concerns about this Privacy Policy:

**Email:** support@pingandwink.com  
**Privacy inquiries:** privacy@pingandwink.com  
**Website:** https://pingandwink.com

## 15. Legal Basis for Processing (GDPR)

For EU/EEA users, we process data based on:
• **Consent:** You consent by using the app
• **Contract:** Processing necessary to provide service
• **Legitimate Interests:** Improving services and ensuring safety
• **Legal Obligations:** Complying with applicable laws

---

© 2025 Ping&Wink. All rights reserved.  
Made for connecting vibes 
''';
}
