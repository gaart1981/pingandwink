import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('de'),
    Locale('es'),
    Locale('es', '419'),
    Locale('es', 'ES'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('tr')
  ];

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get commonError;

  /// No description provided for @commonSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get commonSuccess;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @chatBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Cannot share personal information or inappropriate content'**
  String get chatBlockedMessage;

  /// Hint shown when map is empty after onboarding
  ///
  /// In en, this message translates to:
  /// **'Empty now? Normal! 😊 Peak time is 6-10 PM when everyone\'s active 🌃'**
  String get mapEmptyHintFridayTime;

  /// No description provided for @vibeLabelBrainMode.
  ///
  /// In en, this message translates to:
  /// **'Brain Mode'**
  String get vibeLabelBrainMode;

  /// No description provided for @vibeLabelLatteBreak.
  ///
  /// In en, this message translates to:
  /// **'Latte Break'**
  String get vibeLabelLatteBreak;

  /// No description provided for @vibeLabelSportMode.
  ///
  /// In en, this message translates to:
  /// **'Sport Mode'**
  String get vibeLabelSportMode;

  /// No description provided for @vibeLabelSoundLoop.
  ///
  /// In en, this message translates to:
  /// **'Sound Loop'**
  String get vibeLabelSoundLoop;

  /// No description provided for @vibeLabelCityWalk.
  ///
  /// In en, this message translates to:
  /// **'City Walk'**
  String get vibeLabelCityWalk;

  /// No description provided for @vibeLabelContentMode.
  ///
  /// In en, this message translates to:
  /// **'Content Mode'**
  String get vibeLabelContentMode;

  /// No description provided for @vibeLabelChillNight.
  ///
  /// In en, this message translates to:
  /// **'Chill Night'**
  String get vibeLabelChillNight;

  /// No description provided for @vibeLabelPartyMode.
  ///
  /// In en, this message translates to:
  /// **'Party Mode'**
  String get vibeLabelPartyMode;

  /// No description provided for @scanYourVibe.
  ///
  /// In en, this message translates to:
  /// **'Lock your vibe ⚡'**
  String get scanYourVibe;

  /// No description provided for @pickYourMood.
  ///
  /// In en, this message translates to:
  /// **'Pick your vibe & see what is happening rn 👀'**
  String get pickYourMood;

  /// No description provided for @waitMinutes.
  ///
  /// In en, this message translates to:
  /// **'Wait {minutes} min ⏰'**
  String waitMinutes(int minutes);

  /// No description provided for @swipeDownToMap.
  ///
  /// In en, this message translates to:
  /// **'↓ Swipe down to see map'**
  String get swipeDownToMap;

  /// No description provided for @changeYourMood.
  ///
  /// In en, this message translates to:
  /// **'Change your mood'**
  String get changeYourMood;

  /// No description provided for @swipeUp.
  ///
  /// In en, this message translates to:
  /// **'Swipe up ↑'**
  String get swipeUp;

  /// No description provided for @youAreNotAlone.
  ///
  /// In en, this message translates to:
  /// **'You\'re not alone!'**
  String get youAreNotAlone;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get you;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'others'**
  String get others;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'🔥 Streak: {days} days'**
  String streak(int days);

  /// No description provided for @shareMyVibe.
  ///
  /// In en, this message translates to:
  /// **'📤 Share my vibe'**
  String get shareMyVibe;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'happy'**
  String get happy;

  /// No description provided for @nearby.
  ///
  /// In en, this message translates to:
  /// **'nearby'**
  String get nearby;

  /// No description provided for @enableLocationSettings.
  ///
  /// In en, this message translates to:
  /// **'Enable location in settings'**
  String get enableLocationSettings;

  /// No description provided for @errorTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Error, try again'**
  String get errorTryAgain;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get networkError;

  /// No description provided for @missingConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Missing configuration'**
  String get missingConfiguration;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'no cap, feeling {emotion} rn 💭 who else? check -> moodmap.cloud  #MoodMap #VibeCheck'**
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent);

  /// No description provided for @shareSubject.
  ///
  /// In en, this message translates to:
  /// **'My vibe on MoodMap! 🌟'**
  String get shareSubject;

  /// No description provided for @pingErrorYourVibeExpired.
  ///
  /// In en, this message translates to:
  /// **'Your vibe has expired, place a new one'**
  String get pingErrorYourVibeExpired;

  /// No description provided for @pingSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ping sent! ⚡ 60s to get Wink'**
  String get pingSentSuccess;

  /// No description provided for @pingWaitSeconds.
  ///
  /// In en, this message translates to:
  /// **'Wait {seconds} seconds'**
  String pingWaitSeconds(int seconds);

  /// No description provided for @pingSomeoneAlreadySent.
  ///
  /// In en, this message translates to:
  /// **'Someone already sent a ping'**
  String get pingSomeoneAlreadySent;

  /// No description provided for @pingPersonInSpark.
  ///
  /// In en, this message translates to:
  /// **'This person is in a PW chat'**
  String get pingPersonInSpark;

  /// No description provided for @pingThisVibeExpired.
  ///
  /// In en, this message translates to:
  /// **'This vibe has expired'**
  String get pingThisVibeExpired;

  /// No description provided for @pingFailedToSend.
  ///
  /// In en, this message translates to:
  /// **'Failed to send'**
  String get pingFailedToSend;

  /// No description provided for @pingSendingError.
  ///
  /// In en, this message translates to:
  /// **'Sending error'**
  String get pingSendingError;

  /// No description provided for @pingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Ping cancelled'**
  String get pingCancelled;

  /// No description provided for @pingCancelledBySender.
  ///
  /// In en, this message translates to:
  /// **'Ping was cancelled by sender'**
  String get pingCancelledBySender;

  /// No description provided for @pingErrorConnecting.
  ///
  /// In en, this message translates to:
  /// **'Error connecting with PW mate'**
  String get pingErrorConnecting;

  /// No description provided for @pingErrorStartingChat.
  ///
  /// In en, this message translates to:
  /// **'Error starting chat session'**
  String get pingErrorStartingChat;

  /// No description provided for @chatTimeNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get chatTimeNow;

  /// No description provided for @chatTimeMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String chatTimeMinutes(int minutes);

  /// No description provided for @chatTimeHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String chatTimeHours(int hours);

  /// No description provided for @distanceVeryClose.
  ///
  /// In en, this message translates to:
  /// **'very close'**
  String get distanceVeryClose;

  /// No description provided for @distanceMeters.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String distanceMeters(int meters);

  /// No description provided for @distanceKilometers.
  ///
  /// In en, this message translates to:
  /// **'{km}km'**
  String distanceKilometers(String km);

  /// No description provided for @sparkDefaultAlias1.
  ///
  /// In en, this message translates to:
  /// **'PW mate 1'**
  String get sparkDefaultAlias1;

  /// No description provided for @sparkDefaultAlias2.
  ///
  /// In en, this message translates to:
  /// **'PW mate 2'**
  String get sparkDefaultAlias2;

  /// No description provided for @birthYearTitle.
  ///
  /// In en, this message translates to:
  /// **'your birth year'**
  String get birthYearTitle;

  /// No description provided for @birthYearPrivacyText.
  ///
  /// In en, this message translates to:
  /// **'private • never shown to anyone'**
  String get birthYearPrivacyText;

  /// No description provided for @birthYearDefaultGeneration.
  ///
  /// In en, this message translates to:
  /// **'Cool Gen ⭐'**
  String get birthYearDefaultGeneration;

  /// No description provided for @genLabel2012.
  ///
  /// In en, this message translates to:
  /// **'iPad Kids 📱'**
  String get genLabel2012;

  /// No description provided for @genLabel2011.
  ///
  /// In en, this message translates to:
  /// **'Minecraft OGs ⛏️'**
  String get genLabel2011;

  /// No description provided for @genLabel2010.
  ///
  /// In en, this message translates to:
  /// **'Angry Birds 🦅'**
  String get genLabel2010;

  /// No description provided for @genLabel2009.
  ///
  /// In en, this message translates to:
  /// **'Instagram Gen 📸'**
  String get genLabel2009;

  /// No description provided for @genLabel2008.
  ///
  /// In en, this message translates to:
  /// **'Musical.ly 🎵'**
  String get genLabel2008;

  /// No description provided for @genLabel2007.
  ///
  /// In en, this message translates to:
  /// **'TikTok Kids 🎬'**
  String get genLabel2007;

  /// No description provided for @genLabel2006.
  ///
  /// In en, this message translates to:
  /// **'YouTube Gen 🎮'**
  String get genLabel2006;

  /// No description provided for @genLabel2005.
  ///
  /// In en, this message translates to:
  /// **'Facebook Era 👍'**
  String get genLabel2005;

  /// No description provided for @genLabel2004.
  ///
  /// In en, this message translates to:
  /// **'Snapchat 👻'**
  String get genLabel2004;

  /// No description provided for @genLabel2003.
  ///
  /// In en, this message translates to:
  /// **'MSN Era 💬'**
  String get genLabel2003;

  /// No description provided for @genLabel2002.
  ///
  /// In en, this message translates to:
  /// **'iPod Gen 🎧'**
  String get genLabel2002;

  /// No description provided for @genLabel2001.
  ///
  /// In en, this message translates to:
  /// **'Potterheads ⚡'**
  String get genLabel2001;

  /// No description provided for @genLabel2000.
  ///
  /// In en, this message translates to:
  /// **'Y2K Kids 🌐'**
  String get genLabel2000;

  /// No description provided for @genLabel1999.
  ///
  /// In en, this message translates to:
  /// **'Matrix Gen 💊'**
  String get genLabel1999;

  /// No description provided for @genLabel1998.
  ///
  /// In en, this message translates to:
  /// **'Game Boy 🎮'**
  String get genLabel1998;

  /// No description provided for @genLabel1997.
  ///
  /// In en, this message translates to:
  /// **'Pokémon 🔴'**
  String get genLabel1997;

  /// No description provided for @genLabel1996.
  ///
  /// In en, this message translates to:
  /// **'AOL Kids 💻'**
  String get genLabel1996;

  /// No description provided for @genLabel1995.
  ///
  /// In en, this message translates to:
  /// **'Windows 95 🪟'**
  String get genLabel1995;

  /// No description provided for @genLabel1994.
  ///
  /// In en, this message translates to:
  /// **'Friends Era ☕'**
  String get genLabel1994;

  /// No description provided for @genLabel1993.
  ///
  /// In en, this message translates to:
  /// **'Sonic Gen 💨'**
  String get genLabel1993;

  /// No description provided for @genLabel1992.
  ///
  /// In en, this message translates to:
  /// **'Cartoon Network 📺'**
  String get genLabel1992;

  /// No description provided for @genLabel1991.
  ///
  /// In en, this message translates to:
  /// **'SNES Kids 🎮'**
  String get genLabel1991;

  /// No description provided for @genLabel1990.
  ///
  /// In en, this message translates to:
  /// **'MTV Gen 🎸'**
  String get genLabel1990;

  /// No description provided for @genLabel1989.
  ///
  /// In en, this message translates to:
  /// **'NES Era 🕹️'**
  String get genLabel1989;

  /// No description provided for @genLabel1988.
  ///
  /// In en, this message translates to:
  /// **'Walkman 🎧'**
  String get genLabel1988;

  /// No description provided for @genLabel1987.
  ///
  /// In en, this message translates to:
  /// **'VHS Kids 📼'**
  String get genLabel1987;

  /// No description provided for @genLabel1986.
  ///
  /// In en, this message translates to:
  /// **'Arcade Gen 👾'**
  String get genLabel1986;

  /// No description provided for @genLabel1985.
  ///
  /// In en, this message translates to:
  /// **'BTTF Era ⏰'**
  String get genLabel1985;

  /// No description provided for @genLabel1984.
  ///
  /// In en, this message translates to:
  /// **'Mac Kids 🍎'**
  String get genLabel1984;

  /// No description provided for @genLabel1983.
  ///
  /// In en, this message translates to:
  /// **'Star Wars ⚔️'**
  String get genLabel1983;

  /// No description provided for @genLabel1982.
  ///
  /// In en, this message translates to:
  /// **'E.T. Gen 👽'**
  String get genLabel1982;

  /// No description provided for @genLabel1981.
  ///
  /// In en, this message translates to:
  /// **'MTV Start 📺'**
  String get genLabel1981;

  /// No description provided for @genLabel1980.
  ///
  /// In en, this message translates to:
  /// **'Pac-Man 👾'**
  String get genLabel1980;

  /// No description provided for @genLabel1979.
  ///
  /// In en, this message translates to:
  /// **'Disco Era 🪩'**
  String get genLabel1979;

  /// No description provided for @genLabel1978.
  ///
  /// In en, this message translates to:
  /// **'Space Invaders 🚀'**
  String get genLabel1978;

  /// No description provided for @genLabel1977.
  ///
  /// In en, this message translates to:
  /// **'Star Wars OG 🌟'**
  String get genLabel1977;

  /// No description provided for @genLabel1976.
  ///
  /// In en, this message translates to:
  /// **'Punk Rock 🎸'**
  String get genLabel1976;

  /// No description provided for @genLabel1975.
  ///
  /// In en, this message translates to:
  /// **'Jaws Gen 🦈'**
  String get genLabel1975;

  /// No description provided for @genLabel1974.
  ///
  /// In en, this message translates to:
  /// **'Disco Start 💃'**
  String get genLabel1974;

  /// No description provided for @genLabel1973.
  ///
  /// In en, this message translates to:
  /// **'Pink Floyd 🌈'**
  String get genLabel1973;

  /// No description provided for @genLabel1972.
  ///
  /// In en, this message translates to:
  /// **'Pong Era 🏓'**
  String get genLabel1972;

  /// No description provided for @genLabel1971.
  ///
  /// In en, this message translates to:
  /// **'Zeppelin 🎸'**
  String get genLabel1971;

  /// No description provided for @genLabel1970.
  ///
  /// In en, this message translates to:
  /// **'Beatles Gen 🎵'**
  String get genLabel1970;

  /// No description provided for @genLabel1969.
  ///
  /// In en, this message translates to:
  /// **'Legends 👑'**
  String get genLabel1969;

  /// No description provided for @birthYear1969Plus.
  ///
  /// In en, this message translates to:
  /// **'1969+'**
  String get birthYear1969Plus;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No emotions yet'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start sharing your moods\nto see your history'**
  String get historyEmptySubtitle;

  /// No description provided for @historyMyEmotions.
  ///
  /// In en, this message translates to:
  /// **'My emotions'**
  String get historyMyEmotions;

  /// No description provided for @historyStatTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get historyStatTotal;

  /// No description provided for @historyStatDominant.
  ///
  /// In en, this message translates to:
  /// **'Dominant'**
  String get historyStatDominant;

  /// No description provided for @historyToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get historyToday;

  /// No description provided for @historyTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'{date} • {time}'**
  String historyTimeFormat(String date, String time);

  /// No description provided for @historyTodayFormat.
  ///
  /// In en, this message translates to:
  /// **'{today} • {time}'**
  String historyTodayFormat(String today, String time);

  /// No description provided for @trendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get trendsTitle;

  /// No description provided for @trendsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'City stats are gathering'**
  String get trendsSubtitle;

  /// No description provided for @trendsEmoji.
  ///
  /// In en, this message translates to:
  /// **'📊'**
  String get trendsEmoji;

  /// No description provided for @mapToastYourOwnVibe.
  ///
  /// In en, this message translates to:
  /// **'It\'s your own vibe'**
  String get mapToastYourOwnVibe;

  /// No description provided for @mapErrorNeedActiveVibeToPing.
  ///
  /// In en, this message translates to:
  /// **'You need an active vibe to send pings'**
  String get mapErrorNeedActiveVibeToPing;

  /// No description provided for @mapErrorAlreadyHavePingOrUnavailable.
  ///
  /// In en, this message translates to:
  /// **'You already have an active ping or vibe is unavailable'**
  String get mapErrorAlreadyHavePingOrUnavailable;

  /// No description provided for @mapBanRestrictionMessage.
  ///
  /// In en, this message translates to:
  /// **'You have been restricted for {time}'**
  String mapBanRestrictionMessage(String time);

  /// No description provided for @mapBanRestrictionLifted.
  ///
  /// In en, this message translates to:
  /// **'Restriction lifted! You can share vibes again'**
  String get mapBanRestrictionLifted;

  /// No description provided for @mapSuccessVibeSent.
  ///
  /// In en, this message translates to:
  /// **'Vibe sent! {count} others nearby 🎉'**
  String mapSuccessVibeSent(int count);

  /// No description provided for @mapTutorialTapToSpark.
  ///
  /// In en, this message translates to:
  /// **'tap someone\'s vibe • get PW chat in 60s'**
  String get mapTutorialTapToSpark;

  /// No description provided for @mapActivePingStatus.
  ///
  /// In en, this message translates to:
  /// **'Active ping ({seconds}s) - Tap here to cancel'**
  String mapActivePingStatus(int seconds);

  /// No description provided for @onboardingTitlePingWink.
  ///
  /// In en, this message translates to:
  /// **'ping & wink'**
  String get onboardingTitlePingWink;

  /// No description provided for @onboardingSubtitleSeeWhatsPoppin.
  ///
  /// In en, this message translates to:
  /// **'see what\'s poppin\' around you rn'**
  String get onboardingSubtitleSeeWhatsPoppin;

  /// No description provided for @onboardingButtonLetsGo.
  ///
  /// In en, this message translates to:
  /// **'let\'s go'**
  String get onboardingButtonLetsGo;

  /// No description provided for @onboardingBadgeAge13Plus.
  ///
  /// In en, this message translates to:
  /// **'13+ only'**
  String get onboardingBadgeAge13Plus;

  /// No description provided for @onboardingValueTitleInstantSparks.
  ///
  /// In en, this message translates to:
  /// **'instant PW chat'**
  String get onboardingValueTitleInstantSparks;

  /// No description provided for @onboardingValueSubtitleConnect60Sec.
  ///
  /// In en, this message translates to:
  /// **'connect in 60 sec'**
  String get onboardingValueSubtitleConnect60Sec;

  /// No description provided for @onboardingValueTitleHyperlocalVibes.
  ///
  /// In en, this message translates to:
  /// **'hyperlocal vibes'**
  String get onboardingValueTitleHyperlocalVibes;

  /// No description provided for @onboardingValueSubtitleOnly2kmRadius.
  ///
  /// In en, this message translates to:
  /// **'only 6km radius'**
  String get onboardingValueSubtitleOnly2kmRadius;

  /// No description provided for @onboardingValueTitleNoProfiles.
  ///
  /// In en, this message translates to:
  /// **'no profiles'**
  String get onboardingValueTitleNoProfiles;

  /// No description provided for @onboardingValueSubtitleJustPureMoments.
  ///
  /// In en, this message translates to:
  /// **'just pure moments'**
  String get onboardingValueSubtitleJustPureMoments;

  /// No description provided for @onboardingButtonImReady.
  ///
  /// In en, this message translates to:
  /// **'i\'m ready'**
  String get onboardingButtonImReady;

  /// No description provided for @onboardingLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'unlock your area'**
  String get onboardingLocationTitle;

  /// No description provided for @onboardingLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'see moods within 6km radius'**
  String get onboardingLocationSubtitle;

  /// No description provided for @onboardingLocationPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'privacy first'**
  String get onboardingLocationPrivacyTitle;

  /// No description provided for @onboardingLocationPrivacyBullet1.
  ///
  /// In en, this message translates to:
  /// **'only when app is open'**
  String get onboardingLocationPrivacyBullet1;

  /// No description provided for @onboardingLocationPrivacyBullet2.
  ///
  /// In en, this message translates to:
  /// **'no background tracking'**
  String get onboardingLocationPrivacyBullet2;

  /// No description provided for @onboardingLocationPrivacyBullet3.
  ///
  /// In en, this message translates to:
  /// **'anonymous vibes only'**
  String get onboardingLocationPrivacyBullet3;

  /// No description provided for @onboardingButtonEnableRadar.
  ///
  /// In en, this message translates to:
  /// **'enable radar'**
  String get onboardingButtonEnableRadar;

  /// No description provided for @onboardingButtonMaybeLater.
  ///
  /// In en, this message translates to:
  /// **'maybe later'**
  String get onboardingButtonMaybeLater;

  /// No description provided for @onboardingNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'never miss a PW chat'**
  String get onboardingNotificationTitle;

  /// No description provided for @onboardingNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'get pinged when it\'s lit nearby'**
  String get onboardingNotificationSubtitle;

  /// No description provided for @onboardingNotificationFeature1.
  ///
  /// In en, this message translates to:
  /// **'instant pings when someone vibes'**
  String get onboardingNotificationFeature1;

  /// No description provided for @onboardingNotificationFeature2.
  ///
  /// In en, this message translates to:
  /// **'daily vibe reminders'**
  String get onboardingNotificationFeature2;

  /// No description provided for @onboardingNotificationFeature3.
  ///
  /// In en, this message translates to:
  /// **'hot spots alerts'**
  String get onboardingNotificationFeature3;

  /// No description provided for @onboardingButtonTurnOnPings.
  ///
  /// In en, this message translates to:
  /// **'turn on pings'**
  String get onboardingButtonTurnOnPings;

  /// No description provided for @onboardingButtonNotNow.
  ///
  /// In en, this message translates to:
  /// **'not now'**
  String get onboardingButtonNotNow;

  /// No description provided for @onboardingLegalTitle.
  ///
  /// In en, this message translates to:
  /// **'almost there!'**
  String get onboardingLegalTitle;

  /// No description provided for @onboardingLegalAgeRequirement.
  ///
  /// In en, this message translates to:
  /// **'you must be 13 or older'**
  String get onboardingLegalAgeRequirement;

  /// No description provided for @onboardingLegalAgeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ping & wink is for teens and up'**
  String get onboardingLegalAgeSubtitle;

  /// No description provided for @onboardingLegalConsent.
  ///
  /// In en, this message translates to:
  /// **'by tapping continue, you confirm you\'re 13+ and agree to our'**
  String get onboardingLegalConsent;

  /// No description provided for @onboardingLegalTerms.
  ///
  /// In en, this message translates to:
  /// **'terms'**
  String get onboardingLegalTerms;

  /// No description provided for @onboardingLegalAnd.
  ///
  /// In en, this message translates to:
  /// **' & '**
  String get onboardingLegalAnd;

  /// No description provided for @onboardingLegalPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get onboardingLegalPrivacyPolicy;

  /// No description provided for @onboardingLegalSafetyFeature1.
  ///
  /// In en, this message translates to:
  /// **'anonymous vibes only'**
  String get onboardingLegalSafetyFeature1;

  /// No description provided for @onboardingLegalSafetyFeature2.
  ///
  /// In en, this message translates to:
  /// **'instant blocking & reporting'**
  String get onboardingLegalSafetyFeature2;

  /// No description provided for @onboardingLegalSafetyFeature3.
  ///
  /// In en, this message translates to:
  /// **'20 min timeout for bad behavior'**
  String get onboardingLegalSafetyFeature3;

  /// No description provided for @onboardingButtonImAge13AndAgree.
  ///
  /// In en, this message translates to:
  /// **'i\'m 13+ and i agree'**
  String get onboardingButtonImAge13AndAgree;

  /// No description provided for @onboardingButtonImUnder13.
  ///
  /// In en, this message translates to:
  /// **'i\'m under 13'**
  String get onboardingButtonImUnder13;

  /// No description provided for @onboardingLocationDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'you\'ll miss all the PW sparks'**
  String get onboardingLocationDeniedTitle;

  /// No description provided for @onboardingLocationDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'without location, you can\'t:\n• see who\'s around\n• send pings\n• get winks\n• PW spark connections'**
  String get onboardingLocationDeniedMessage;

  /// No description provided for @onboardingButtonGoBack.
  ///
  /// In en, this message translates to:
  /// **'go back'**
  String get onboardingButtonGoBack;

  /// No description provided for @onboardingButtonExitApp.
  ///
  /// In en, this message translates to:
  /// **'exit app'**
  String get onboardingButtonExitApp;

  /// No description provided for @onboardingNotificationDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'you\'ll miss all the fun'**
  String get onboardingNotificationDeniedTitle;

  /// No description provided for @onboardingNotificationDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'without notifications:\n• no one can ping you\n• you\'ll miss PW sparks nearby\n• zero connections possible\n\nour users enable notifications'**
  String get onboardingNotificationDeniedMessage;

  /// No description provided for @onboardingButtonLetMeReconsider.
  ///
  /// In en, this message translates to:
  /// **'let me reconsider'**
  String get onboardingButtonLetMeReconsider;

  /// No description provided for @onboardingButtonContinueAnyway.
  ///
  /// In en, this message translates to:
  /// **'continue anyway'**
  String get onboardingButtonContinueAnyway;

  /// No description provided for @onboardingAgeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'see you later!'**
  String get onboardingAgeDialogTitle;

  /// No description provided for @onboardingAgeDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'ping & wink is for users 13 and older. come back when you\'re old enough!'**
  String get onboardingAgeDialogMessage;

  /// No description provided for @onboardingButtonUnderstood.
  ///
  /// In en, this message translates to:
  /// **'understood'**
  String get onboardingButtonUnderstood;

  /// No description provided for @onboardingNotificationExampleTitle.
  ///
  /// In en, this message translates to:
  /// **'ping & wink'**
  String get onboardingNotificationExampleTitle;

  /// No description provided for @onboardingNotificationExampleNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get onboardingNotificationExampleNow;

  /// No description provided for @onboardingNotificationExamplePing.
  ///
  /// In en, this message translates to:
  /// **'new ping 230m away'**
  String get onboardingNotificationExamplePing;

  /// No description provided for @onboardingNotificationExampleMessage.
  ///
  /// In en, this message translates to:
  /// **'someone vibes with you'**
  String get onboardingNotificationExampleMessage;

  /// No description provided for @onboardingMapNotification.
  ///
  /// In en, this message translates to:
  /// **'someone sparked 753m away'**
  String get onboardingMapNotification;

  /// No description provided for @onboardingLocationPrivacyFormatted.
  ///
  /// In en, this message translates to:
  /// **'• only when app is open\n• no background tracking\n• anonymous vibes only'**
  String get onboardingLocationPrivacyFormatted;

  /// No description provided for @onboardingLocationDeniedFormatted.
  ///
  /// In en, this message translates to:
  /// **'without location, you can\'t:\n• see who\'s around\n• send pings\n• get winks\n• spark connections'**
  String get onboardingLocationDeniedFormatted;

  /// No description provided for @onboardingNotificationDeniedFormatted.
  ///
  /// In en, this message translates to:
  /// **'without notifications:\n• no one can ping you\n• you\'ll miss vibes nearby\n• zero connections possible\n\nour users enable notifications'**
  String get onboardingNotificationDeniedFormatted;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAppName.
  ///
  /// In en, this message translates to:
  /// **'Ping&Wink'**
  String get settingsAppName;

  /// No description provided for @settingsAppTagline.
  ///
  /// In en, this message translates to:
  /// **'Connect with emotions'**
  String get settingsAppTagline;

  /// No description provided for @settingsShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share with friends'**
  String get settingsShareTitle;

  /// No description provided for @settingsShareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invite others to discover vibes'**
  String get settingsShareSubtitle;

  /// No description provided for @settingsSectionPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsSectionPreferences;

  /// No description provided for @settingsSectionLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get settingsSectionLegal;

  /// No description provided for @settingsSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSectionSupport;

  /// No description provided for @settingsSectionDataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get settingsSectionDataManagement;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get settingsNotificationsEnabled;

  /// No description provided for @settingsNotificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get settingsNotificationsDisabled;

  /// No description provided for @settingsMapThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Map theme'**
  String get settingsMapThemeTitle;

  /// No description provided for @settingsMapThemeCyberpunk.
  ///
  /// In en, this message translates to:
  /// **'Cyberpunk'**
  String get settingsMapThemeCyberpunk;

  /// No description provided for @settingsMapThemeMinimalist.
  ///
  /// In en, this message translates to:
  /// **'Minimalist'**
  String get settingsMapThemeMinimalist;

  /// No description provided for @settingsLocationModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Location mode'**
  String get settingsLocationModeTitle;

  /// No description provided for @settingsLocationModeSoft.
  ///
  /// In en, this message translates to:
  /// **'Location shifts, just for style'**
  String get settingsLocationModeSoft;

  /// No description provided for @settingsLocationModeExact.
  ///
  /// In en, this message translates to:
  /// **'Your vibe right where it happens'**
  String get settingsLocationModeExact;

  /// No description provided for @settingsDeleteVibeTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete my vibe'**
  String get settingsDeleteVibeTitle;

  /// No description provided for @settingsDeleteVibeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Remove your emotion from the map'**
  String get settingsDeleteVibeSubtitle;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'How we protect your data'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get settingsTermsTitle;

  /// No description provided for @settingsTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rules for using the app'**
  String get settingsTermsSubtitle;

  /// No description provided for @settingsHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get settingsHelpTitle;

  /// No description provided for @settingsHelpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ and guides'**
  String get settingsHelpSubtitle;

  /// No description provided for @settingsContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get settingsContactTitle;

  /// No description provided for @settingsContactEmail.
  ///
  /// In en, this message translates to:
  /// **'hello@pingandwink.com'**
  String get settingsContactEmail;

  /// No description provided for @settingsDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get settingsDeleteAccountTitle;

  /// No description provided for @settingsDeleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Erase all your data'**
  String get settingsDeleteAccountSubtitle;

  /// No description provided for @settingsFooterTagline.
  ///
  /// In en, this message translates to:
  /// **'Ping & Wink - Just Vibes'**
  String get settingsFooterTagline;

  /// No description provided for @settingsFooterCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Ping and Wink'**
  String get settingsFooterCopyright;

  /// No description provided for @settingsDeviceIdPrefix.
  ///
  /// In en, this message translates to:
  /// **'Device ID: {id}...'**
  String settingsDeviceIdPrefix(String id);

  /// No description provided for @settingsDeleteVibeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your vibe?'**
  String get settingsDeleteVibeDialogTitle;

  /// No description provided for @settingsDeleteVibeDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Your emotion will be removed from the map'**
  String get settingsDeleteVibeDialogMessage;

  /// No description provided for @settingsVibeDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your vibe has been deleted'**
  String get settingsVibeDeletedSuccess;

  /// No description provided for @settingsVibeDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting vibe'**
  String get settingsVibeDeleteError;

  /// No description provided for @settingsNotificationWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning!'**
  String get settingsNotificationWarningTitle;

  /// No description provided for @settingsNotificationWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'If you disable notifications, you won\'t be able to receive PINGS from other users.\n\nPW chats (connections) cannot be established.\n\nDo you really want to disable?'**
  String get settingsNotificationWarningMessage;

  /// No description provided for @settingsNotificationWarningCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsNotificationWarningCancel;

  /// No description provided for @settingsNotificationWarningDisable.
  ///
  /// In en, this message translates to:
  /// **'Disable anyway'**
  String get settingsNotificationWarningDisable;

  /// No description provided for @settingsNotificationsDisabledMessage.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Notifications disabled - You won\'t receive any pings'**
  String get settingsNotificationsDisabledMessage;

  /// No description provided for @settingsNotificationsEnabledMessage.
  ///
  /// In en, this message translates to:
  /// **'✅ Notifications enabled - You can receive pings'**
  String get settingsNotificationsEnabledMessage;

  /// No description provided for @settingsMapThemeCyberpunkActivated.
  ///
  /// In en, this message translates to:
  /// **'Cyberpunk mode activated 🌃'**
  String get settingsMapThemeCyberpunkActivated;

  /// No description provided for @settingsMapThemeDayActivated.
  ///
  /// In en, this message translates to:
  /// **'Day mode activated ☀️'**
  String get settingsMapThemeDayActivated;

  /// No description provided for @settingsSoftModeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Soft mode on! Your vibe is shifted 🌊'**
  String get settingsSoftModeEnabled;

  /// No description provided for @settingsNormalModeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Normal mode on! Exact location 📍'**
  String get settingsNormalModeEnabled;

  /// No description provided for @settingsIdCopied.
  ///
  /// In en, this message translates to:
  /// **'ID copied'**
  String get settingsIdCopied;

  /// No description provided for @settingsDeleteAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Delete account'**
  String get settingsDeleteAccountDialogTitle;

  /// No description provided for @settingsDeleteAccountDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. All your emotions and data will be permanently deleted.\n\nAre you sure?'**
  String get settingsDeleteAccountDialogMessage;

  /// No description provided for @settingsDeleteAccountDialogDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDeleteAccountDialogDelete;

  /// No description provided for @settingsDeleteAccountError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting account'**
  String get settingsDeleteAccountError;

  /// No description provided for @settingsModerationPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'🔐 Moderation Panel'**
  String get settingsModerationPanelTitle;

  /// No description provided for @settingsModerationPanelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For App Store Review Only'**
  String get settingsModerationPanelSubtitle;

  /// No description provided for @settingsModerationActiveBans.
  ///
  /// In en, this message translates to:
  /// **'Active Bans'**
  String get settingsModerationActiveBans;

  /// No description provided for @settingsModerationReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get settingsModerationReports;

  /// No description provided for @settingsModerationClearData.
  ///
  /// In en, this message translates to:
  /// **'Clear Test Data'**
  String get settingsModerationClearData;

  /// No description provided for @settingsModerationDataCleared.
  ///
  /// In en, this message translates to:
  /// **'Test data cleared'**
  String get settingsModerationDataCleared;

  /// No description provided for @sparkConnectingToChat.
  ///
  /// In en, this message translates to:
  /// **'Connecting to PW chat...'**
  String get sparkConnectingToChat;

  /// No description provided for @sparkChatTitle.
  ///
  /// In en, this message translates to:
  /// **'PW Chat'**
  String get sparkChatTitle;

  /// No description provided for @sparkChatEnded.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get sparkChatEnded;

  /// No description provided for @sparkSendFirstMessage.
  ///
  /// In en, this message translates to:
  /// **'Send first message!'**
  String get sparkSendFirstMessage;

  /// No description provided for @sparkWaitingForMate.
  ///
  /// In en, this message translates to:
  /// **'Waiting for PW mate...'**
  String get sparkWaitingForMate;

  /// No description provided for @sparkMessagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Message...'**
  String get sparkMessagePlaceholder;

  /// No description provided for @sparkWaitForReply.
  ///
  /// In en, this message translates to:
  /// **'Wait for reply...'**
  String get sparkWaitForReply;

  /// No description provided for @sparkChatEndedPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Chat ended'**
  String get sparkChatEndedPlaceholder;

  /// No description provided for @sparkLeaveChat.
  ///
  /// In en, this message translates to:
  /// **'Leave PW chat?'**
  String get sparkLeaveChat;

  /// No description provided for @sparkChatEndForBoth.
  ///
  /// In en, this message translates to:
  /// **'Chat will end for both PW mates'**
  String get sparkChatEndForBoth;

  /// No description provided for @sparkStay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get sparkStay;

  /// No description provided for @sparkLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get sparkLeave;

  /// No description provided for @sparkExtended.
  ///
  /// In en, this message translates to:
  /// **'Extended! +3 min ⚡'**
  String get sparkExtended;

  /// No description provided for @sparkWaitingForOther.
  ///
  /// In en, this message translates to:
  /// **'Waiting for PW mate...'**
  String get sparkWaitingForOther;

  /// No description provided for @sparkMaxExtensionsReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum extensions reached'**
  String get sparkMaxExtensionsReached;

  /// No description provided for @sparkFailedToExtend.
  ///
  /// In en, this message translates to:
  /// **'Failed to extend'**
  String get sparkFailedToExtend;

  /// No description provided for @sparkFailedToSend.
  ///
  /// In en, this message translates to:
  /// **'Failed to send'**
  String get sparkFailedToSend;

  /// No description provided for @sparkMessageTooLong.
  ///
  /// In en, this message translates to:
  /// **'Message too long (max 199)'**
  String get sparkMessageTooLong;

  /// No description provided for @sparkErrorInitializing.
  ///
  /// In en, this message translates to:
  /// **'Error initializing chat: {error}'**
  String sparkErrorInitializing(String error);

  /// No description provided for @sparkUserBanned.
  ///
  /// In en, this message translates to:
  /// **'User banned for 7 minutes'**
  String get sparkUserBanned;

  /// No description provided for @sparkRestrictedForBanning.
  ///
  /// In en, this message translates to:
  /// **'You have been restricted for excessive banning'**
  String get sparkRestrictedForBanning;

  /// No description provided for @sparkReportSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted'**
  String get sparkReportSubmitted;

  /// No description provided for @sparkBehaviorRestriction.
  ///
  /// In en, this message translates to:
  /// **'You have been restricted for inappropriate behavior'**
  String get sparkBehaviorRestriction;

  /// No description provided for @splashTitlePing.
  ///
  /// In en, this message translates to:
  /// **'PING'**
  String get splashTitlePing;

  /// No description provided for @splashTitleAmpersand.
  ///
  /// In en, this message translates to:
  /// **'&'**
  String get splashTitleAmpersand;

  /// No description provided for @splashTitleWink.
  ///
  /// In en, this message translates to:
  /// **'WINK'**
  String get splashTitleWink;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'SPARK THE MOMENT'**
  String get splashTagline;

  /// No description provided for @trendsEmotionalPulse.
  ///
  /// In en, this message translates to:
  /// **'Emotional pulse {time}'**
  String trendsEmotionalPulse(String time);

  /// No description provided for @trendsTimeMorning.
  ///
  /// In en, this message translates to:
  /// **'this morning'**
  String get trendsTimeMorning;

  /// No description provided for @trendsTimeAfternoon.
  ///
  /// In en, this message translates to:
  /// **'this afternoon'**
  String get trendsTimeAfternoon;

  /// No description provided for @trendsTimeEvening.
  ///
  /// In en, this message translates to:
  /// **'tonight'**
  String get trendsTimeEvening;

  /// No description provided for @trendsTimeLateNight.
  ///
  /// In en, this message translates to:
  /// **'late night'**
  String get trendsTimeLateNight;

  /// No description provided for @trendsActiveVibes.
  ///
  /// In en, this message translates to:
  /// **'Active vibes'**
  String get trendsActiveVibes;

  /// No description provided for @trendsSparkers.
  ///
  /// In en, this message translates to:
  /// **'PW mates'**
  String get trendsSparkers;

  /// No description provided for @trendsDominantEmotion.
  ///
  /// In en, this message translates to:
  /// **'Dominant emotion'**
  String get trendsDominantEmotion;

  /// No description provided for @trendsPercentOfSparkers.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of PW mates'**
  String trendsPercentOfSparkers(int percent);

  /// No description provided for @trendsEmotionDistribution.
  ///
  /// In en, this message translates to:
  /// **'Emotion distribution'**
  String get trendsEmotionDistribution;

  /// No description provided for @trendsQuote1.
  ///
  /// In en, this message translates to:
  /// **'Every shared emotion creates a connection ✨'**
  String get trendsQuote1;

  /// No description provided for @trendsQuote2.
  ///
  /// In en, this message translates to:
  /// **'Together we create the emotion map 🗺️'**
  String get trendsQuote2;

  /// No description provided for @trendsQuote3.
  ///
  /// In en, this message translates to:
  /// **'Your vibe can change someone\'s day 💫'**
  String get trendsQuote3;

  /// No description provided for @trendsQuote4.
  ///
  /// In en, this message translates to:
  /// **'PW chat start with a simple ping ⚡'**
  String get trendsQuote4;

  /// No description provided for @banOverlayTitle.
  ///
  /// In en, this message translates to:
  /// **'Temporarily Restricted'**
  String get banOverlayTitle;

  /// No description provided for @banOverlayMessage.
  ///
  /// In en, this message translates to:
  /// **'Your PW mate found your message inappropriate'**
  String get banOverlayMessage;

  /// No description provided for @banOverlayRestrictionInfo.
  ///
  /// In en, this message translates to:
  /// **'You cannot share vibes during this time'**
  String get banOverlayRestrictionInfo;

  /// No description provided for @bottomNavMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get bottomNavMap;

  /// No description provided for @bottomNavHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get bottomNavHistory;

  /// No description provided for @bottomNavTrends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get bottomNavTrends;

  /// No description provided for @bottomNavSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottomNavSettings;

  /// No description provided for @guidelinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Community Guidelines'**
  String get guidelinesTitle;

  /// No description provided for @guidelinesRespectTitle.
  ///
  /// In en, this message translates to:
  /// **'Be respectful'**
  String get guidelinesRespectTitle;

  /// No description provided for @guidelinesRespectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Treat everyone with kindness'**
  String get guidelinesRespectSubtitle;

  /// No description provided for @guidelinesNoHarassmentTitle.
  ///
  /// In en, this message translates to:
  /// **'No harassment'**
  String get guidelinesNoHarassmentTitle;

  /// No description provided for @guidelinesNoHarassmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t send inappropriate messages'**
  String get guidelinesNoHarassmentSubtitle;

  /// No description provided for @guidelinesKeepRealTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep it real'**
  String get guidelinesKeepRealTitle;

  /// No description provided for @guidelinesKeepRealSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share genuine vibes only'**
  String get guidelinesKeepRealSubtitle;

  /// No description provided for @guidelinesHaveFunTitle.
  ///
  /// In en, this message translates to:
  /// **'Have fun'**
  String get guidelinesHaveFunTitle;

  /// No description provided for @guidelinesHaveFunSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoy PW sparking connections!'**
  String get guidelinesHaveFunSubtitle;

  /// No description provided for @guidelinesViolationWarning.
  ///
  /// In en, this message translates to:
  /// **'Violations may result in temporary or permanent restrictions'**
  String get guidelinesViolationWarning;

  /// No description provided for @guidelinesButtonUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get guidelinesButtonUnderstand;

  /// No description provided for @emotionSelectorStreakDay.
  ///
  /// In en, this message translates to:
  /// **'Day {day} - Keep your streak alive!'**
  String emotionSelectorStreakDay(int day);

  /// No description provided for @emotionSelectorTapYourVibe.
  ///
  /// In en, this message translates to:
  /// **'TAP YOUR VIBE'**
  String get emotionSelectorTapYourVibe;

  /// No description provided for @emotionSelectorWhatsYourVibe.
  ///
  /// In en, this message translates to:
  /// **'what\'s your vibe rn?'**
  String get emotionSelectorWhatsYourVibe;

  /// No description provided for @emotionSelectorActiveNow.
  ///
  /// In en, this message translates to:
  /// **'{count} active now'**
  String emotionSelectorActiveNow(int count);

  /// No description provided for @miniBarSendNewPing.
  ///
  /// In en, this message translates to:
  /// **'Send a new ping'**
  String get miniBarSendNewPing;

  /// No description provided for @miniBarPingActive.
  ///
  /// In en, this message translates to:
  /// **'Your ping is active'**
  String get miniBarPingActive;

  /// No description provided for @moderationBanTitle.
  ///
  /// In en, this message translates to:
  /// **'Ban for 7 min'**
  String get moderationBanTitle;

  /// No description provided for @moderationBanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Temporarily restrict this user'**
  String get moderationBanSubtitle;

  /// No description provided for @moderationReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get moderationReportTitle;

  /// No description provided for @moderationReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report inappropriate behavior'**
  String get moderationReportSubtitle;

  /// No description provided for @moderationEndChatTitle.
  ///
  /// In en, this message translates to:
  /// **'End Chat'**
  String get moderationEndChatTitle;

  /// No description provided for @moderationEndChatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Leave this PW session'**
  String get moderationEndChatSubtitle;

  /// No description provided for @moderationReportDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Report User'**
  String get moderationReportDialogTitle;

  /// No description provided for @moderationReportReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get moderationReportReasonHarassment;

  /// No description provided for @moderationReportReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get moderationReportReasonSpam;

  /// No description provided for @moderationReportReasonHateSpeech.
  ///
  /// In en, this message translates to:
  /// **'Hate speech'**
  String get moderationReportReasonHateSpeech;

  /// No description provided for @moderationReportReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get moderationReportReasonOther;

  /// No description provided for @moderationReportSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Report'**
  String get moderationReportSendButton;

  /// No description provided for @pingBottomVibeTooFar.
  ///
  /// In en, this message translates to:
  /// **'Vibe too far (max 6km)'**
  String get pingBottomVibeTooFar;

  /// No description provided for @pingBottomVibeTooFarMessage.
  ///
  /// In en, this message translates to:
  /// **'Vibe too far - max 6km to send ping'**
  String get pingBottomVibeTooFarMessage;

  /// No description provided for @pingBottomTooFar.
  ///
  /// In en, this message translates to:
  /// **'TOO FAR'**
  String get pingBottomTooFar;

  /// No description provided for @pingBottomPing.
  ///
  /// In en, this message translates to:
  /// **'PING'**
  String get pingBottomPing;

  /// No description provided for @pingBottomDistanceVeryClose.
  ///
  /// In en, this message translates to:
  /// **'very close'**
  String get pingBottomDistanceVeryClose;

  /// No description provided for @pingBottomDistanceMeters.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String pingBottomDistanceMeters(int meters);

  /// No description provided for @pingBottomDistanceKilometers.
  ///
  /// In en, this message translates to:
  /// **'{km}km'**
  String pingBottomDistanceKilometers(String km);

  /// No description provided for @pingBottomTimeNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get pingBottomTimeNow;

  /// No description provided for @pingBottomTimeMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}min'**
  String pingBottomTimeMinutes(int minutes);

  /// No description provided for @pingBottomTimeHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String pingBottomTimeHours(int hours);

  /// No description provided for @vibeAnimBrainEnergy.
  ///
  /// In en, this message translates to:
  /// **'BIG BRAIN ENERGY'**
  String get vibeAnimBrainEnergy;

  /// No description provided for @vibeAnimCozy.
  ///
  /// In en, this message translates to:
  /// **'VIBE CHECK: COZY'**
  String get vibeAnimCozy;

  /// No description provided for @vibeAnimSweatSlay.
  ///
  /// In en, this message translates to:
  /// **'SWEAT. SLAY. REPEAT'**
  String get vibeAnimSweatSlay;

  /// No description provided for @vibeAnimLostInBeat.
  ///
  /// In en, this message translates to:
  /// **'LOST IN THE BEAT'**
  String get vibeAnimLostInBeat;

  /// No description provided for @vibeAnimCityLights.
  ///
  /// In en, this message translates to:
  /// **'CITY LIGHTS: ON'**
  String get vibeAnimCityLights;

  /// No description provided for @vibeAnimLightsCameraVibes.
  ///
  /// In en, this message translates to:
  /// **'LIGHTS. CAMERA. VIBES.'**
  String get vibeAnimLightsCameraVibes;

  /// No description provided for @vibeAnimEveningVibes.
  ///
  /// In en, this message translates to:
  /// **'EVENING VIBES'**
  String get vibeAnimEveningVibes;

  /// No description provided for @vibeAnimPartyMode.
  ///
  /// In en, this message translates to:
  /// **'PARTY MODE: ON'**
  String get vibeAnimPartyMode;

  /// No description provided for @vibeAnimSubBrainTime.
  ///
  /// In en, this message translates to:
  /// **'Big brain time 🧠'**
  String get vibeAnimSubBrainTime;

  /// No description provided for @vibeAnimSubCaffeine.
  ///
  /// In en, this message translates to:
  /// **'Caffeine vibes ☕'**
  String get vibeAnimSubCaffeine;

  /// No description provided for @vibeAnimSubNoDaysOff.
  ///
  /// In en, this message translates to:
  /// **'No days off 🔥'**
  String get vibeAnimSubNoDaysOff;

  /// No description provided for @vibeAnimSubVolumeMax.
  ///
  /// In en, this message translates to:
  /// **'Volume: MAX 🎧'**
  String get vibeAnimSubVolumeMax;

  /// No description provided for @vibeAnimSubUrbanExplorer.
  ///
  /// In en, this message translates to:
  /// **'Urban explorer 🌃'**
  String get vibeAnimSubUrbanExplorer;

  /// No description provided for @vibeAnimSubCreateGlow.
  ///
  /// In en, this message translates to:
  /// **'Create & glow 📸'**
  String get vibeAnimSubCreateGlow;

  /// No description provided for @vibeAnimSubNightFlow.
  ///
  /// In en, this message translates to:
  /// **'Night Flow 🌙'**
  String get vibeAnimSubNightFlow;

  /// No description provided for @vibeAnimSubUnleashChaos.
  ///
  /// In en, this message translates to:
  /// **'Unleash the chaos 🎉'**
  String get vibeAnimSubUnleashChaos;

  /// No description provided for @vibeAnimDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'VIBE SET'**
  String get vibeAnimDefaultMessage;

  /// No description provided for @vibeAnimDefaultSubMessage.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go!'**
  String get vibeAnimDefaultSubMessage;

  /// No description provided for @viralShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to share'**
  String get viralShareFailed;

  /// No description provided for @viralShareTextNight.
  ///
  /// In en, this message translates to:
  /// **'everyone\'s asleep. but something\'s happening\npingandwink.com'**
  String get viralShareTextNight;

  /// No description provided for @viralShareTextEvening.
  ///
  /// In en, this message translates to:
  /// **'evening. the best time\npingandwink.com'**
  String get viralShareTextEvening;

  /// No description provided for @viralShareTextDefault.
  ///
  /// In en, this message translates to:
  /// **'what\'s happening right now?\npingandwink.com'**
  String get viralShareTextDefault;

  /// No description provided for @viralShareMainText.
  ///
  /// In en, this message translates to:
  /// **'what\'s happening\nwhile you read this?'**
  String get viralShareMainText;

  /// No description provided for @viralShareFindOut.
  ///
  /// In en, this message translates to:
  /// **'find out'**
  String get viralShareFindOut;

  /// No description provided for @viralShareLogo.
  ///
  /// In en, this message translates to:
  /// **'ping&wink'**
  String get viralShareLogo;

  /// No description provided for @viralShareButton.
  ///
  /// In en, this message translates to:
  /// **'share →'**
  String get viralShareButton;

  /// No description provided for @winkBannerPing.
  ///
  /// In en, this message translates to:
  /// **'PING {distance}'**
  String winkBannerPing(String distance);

  /// No description provided for @winkBannerSparkmateWants.
  ///
  /// In en, this message translates to:
  /// **'PW mate wants to connect'**
  String get winkBannerSparkmateWants;

  /// No description provided for @winkBannerWinkBack.
  ///
  /// In en, this message translates to:
  /// **'WINK BACK'**
  String get winkBannerWinkBack;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'ko',
        'pt',
        'ru',
        'tr'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'es':
      {
        switch (locale.countryCode) {
          case '419':
            return AppLocalizationsEs419();
          case 'ES':
            return AppLocalizationsEsEs();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
