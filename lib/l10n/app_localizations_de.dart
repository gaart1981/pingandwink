// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Ja';

  @override
  String get commonNo => 'Nein';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonShare => 'Teilen';

  @override
  String get commonLoading => 'Lädt...';

  @override
  String get commonError => 'Fehler';

  @override
  String get commonSuccess => 'Fertig';

  @override
  String get commonRetry => 'Nochmal';

  @override
  String get commonNext => 'Weiter';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonDone => 'Fertig';

  @override
  String get commonContinue => 'Weiter';

  @override
  String get commonConfirm => 'Bestätigen';

  @override
  String get chatBlockedMessage =>
      'Cannot share personal information or inappropriate content';

  @override
  String get mapEmptyHintFridayTime =>
      'Jetzt leer? Ganz normal! 😊 Hauptzeit ist 18-22 Uhr wenn alle aktiv sind 🌃';

  @override
  String get vibeLabelBrainMode => 'Fokus Mode';

  @override
  String get vibeLabelLatteBreak => 'Kaffee Pause';

  @override
  String get vibeLabelSportMode => 'Sport Mode';

  @override
  String get vibeLabelSoundLoop => 'Im Beat';

  @override
  String get vibeLabelCityWalk => 'Unterwegs';

  @override
  String get vibeLabelContentMode => 'Creating';

  @override
  String get vibeLabelChillNight => 'Chill Abend';

  @override
  String get vibeLabelPartyMode => 'Party Mode';

  @override
  String get scanYourVibe => 'Lock deinen Vibe ⚡';

  @override
  String get pickYourMood => 'Pick deine Mood und check was gerade abgeht 👀';

  @override
  String waitMinutes(int minutes) {
    return 'Warte $minutes Min ⏰';
  }

  @override
  String get swipeDownToMap => '↓ Swipe runter zur Map';

  @override
  String get changeYourMood => 'Mood ändern';

  @override
  String get swipeUp => 'Swipe nach oben ↑';

  @override
  String get youAreNotAlone => 'Du bist nicht allein!';

  @override
  String get you => 'DU';

  @override
  String get others => 'andere';

  @override
  String get days => 'Tage';

  @override
  String streak(int days) {
    return '🔥 Streak: $days Tage';
  }

  @override
  String get shareMyVibe => '📤 Vibe teilen';

  @override
  String get close => 'Schließen';

  @override
  String get happy => 'fühlen';

  @override
  String get nearby => 'in deiner Nähe';

  @override
  String get enableLocationSettings => 'Standort in Einstellungen aktivieren';

  @override
  String get errorTryAgain => 'Fehler, versuch\'s nochmal';

  @override
  String get networkError => 'Netzwerkfehler';

  @override
  String get missingConfiguration => 'Konfiguration fehlt';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'meine mood $emotion gerade 💭 wer noch? check -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'Mein Vibe auf MoodMap! 🌟';

  @override
  String get pingErrorYourVibeExpired =>
      'Dein Vibe ist abgelaufen, setz einen neuen';

  @override
  String get pingSentSuccess => 'Ping gesendet! ⚡ 60s für einen Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'Warte $seconds Sek';
  }

  @override
  String get pingSomeoneAlreadySent => 'Jemand hat schon einen Ping gesendet';

  @override
  String get pingPersonInSpark => 'Diese Person ist schon im PW Chat';

  @override
  String get pingThisVibeExpired => 'Dieser Vibe ist abgelaufen';

  @override
  String get pingFailedToSend => 'Senden fehlgeschlagen';

  @override
  String get pingSendingError => 'Fehler beim Senden';

  @override
  String get pingCancelled => 'Ping abgebrochen';

  @override
  String get pingCancelledBySender => 'Ping vom Sender abgebrochen';

  @override
  String get pingErrorConnecting => 'Fehler beim Verbinden mit PW Mate';

  @override
  String get pingErrorStartingChat => 'Fehler beim Chat-Start';

  @override
  String get chatTimeNow => 'jetzt';

  @override
  String chatTimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String chatTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get distanceVeryClose => 'sehr nah';

  @override
  String distanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String distanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get sparkDefaultAlias1 => 'PW Mate 1';

  @override
  String get sparkDefaultAlias2 => 'PW Mate 2';

  @override
  String get birthYearTitle => 'dein Geburtsjahr';

  @override
  String get birthYearPrivacyText => 'privat • wird nie gezeigt';

  @override
  String get birthYearDefaultGeneration => 'Coole Generation ⭐';

  @override
  String get genLabel2012 => 'iPad Kids 📱';

  @override
  String get genLabel2011 => 'Minecraft OGs ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'Insta Generation 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'TikTok Kids 🎬';

  @override
  String get genLabel2006 => 'YouTube Gen 🎮';

  @override
  String get genLabel2005 => 'StudiVZ Ära 👍';

  @override
  String get genLabel2004 => 'Snapchat 👻';

  @override
  String get genLabel2003 => 'ICQ Ära 💬';

  @override
  String get genLabel2002 => 'iPod Generation 🎧';

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
  String get genLabel1996 => 'Modem Kids 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'Friends Ära ☕';

  @override
  String get genLabel1993 => 'Sonic Gen 💨';

  @override
  String get genLabel1992 => 'RTL2 Anime 📺';

  @override
  String get genLabel1991 => 'Super Nintendo 🎮';

  @override
  String get genLabel1990 => 'MTV Generation 🎸';

  @override
  String get genLabel1989 => 'Mauerfall Kids 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'VHS Kids 📼';

  @override
  String get genLabel1986 => 'Arcade Gen 👾';

  @override
  String get genLabel1985 => 'Zurück in die Zukunft ⏰';

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
  String get genLabel1979 => 'Disco Ära 🪩';

  @override
  String get genLabel1978 => 'Space Invaders 🚀';

  @override
  String get genLabel1977 => 'Star Wars OG 🌟';

  @override
  String get genLabel1976 => 'Punk Rock 🎸';

  @override
  String get genLabel1975 => 'Der weiße Hai Gen 🦈';

  @override
  String get genLabel1974 => 'Disco Start 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'Pong Ära 🏓';

  @override
  String get genLabel1971 => 'Zeppelin 🎸';

  @override
  String get genLabel1970 => 'Beatles Gen 🎵';

  @override
  String get genLabel1969 => 'Legenden 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'Verlauf';

  @override
  String get historyEmptyTitle => 'Noch keine Emotionen';

  @override
  String get historyEmptySubtitle =>
      'Teile deine Vibes\num deinen Verlauf zu sehen';

  @override
  String get historyMyEmotions => 'Meine Emotionen';

  @override
  String get historyStatTotal => 'Gesamt';

  @override
  String get historyStatDominant => 'Dominant';

  @override
  String get historyToday => 'Heute';

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
  String get trendsSubtitle => 'City-Stats werden geladen';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'Das ist dein eigener Vibe';

  @override
  String get mapErrorNeedActiveVibeToPing =>
      'Du brauchst einen aktiven Vibe für Pings';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'Du hast schon einen aktiven Ping oder Vibe ist nicht verfügbar';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'Du bist eingeschränkt für $time';
  }

  @override
  String get mapBanRestrictionLifted =>
      'Einschränkung aufgehoben! Du kannst wieder Vibes teilen';

  @override
  String mapSuccessVibeSent(int count) {
    return 'Vibe gesendet! $count andere nearby 🎉';
  }

  @override
  String get mapTutorialTapToSpark => 'tipp auf einen Vibe • PW Chat in 60s';

  @override
  String mapActivePingStatus(int seconds) {
    return 'Aktiver Ping (${seconds}s) - Tippen zum Abbrechen';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin =>
      'check was gerade in deiner nähe abgeht';

  @override
  String get onboardingButtonLetsGo => 'los geht\'s';

  @override
  String get onboardingBadgeAge13Plus => 'nur 13+';

  @override
  String get onboardingValueTitleInstantSparks => 'instant PW chat';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'connecte in 60 sek';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'hyperlokale vibes';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => 'nur 2km radius';

  @override
  String get onboardingValueTitleNoProfiles => 'keine profile';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'nur echte momente';

  @override
  String get onboardingButtonImReady => 'ich bin ready';

  @override
  String get onboardingLocationTitle => 'unlock deine area';

  @override
  String get onboardingLocationSubtitle => 'sieh vibes im 2km umkreis';

  @override
  String get onboardingLocationPrivacyTitle => 'privatsphäre first';

  @override
  String get onboardingLocationPrivacyBullet1 => 'nur wenn app offen ist';

  @override
  String get onboardingLocationPrivacyBullet2 => 'kein hintergrund-tracking';

  @override
  String get onboardingLocationPrivacyBullet3 => 'nur anonyme vibes';

  @override
  String get onboardingButtonEnableRadar => 'radar aktivieren';

  @override
  String get onboardingButtonMaybeLater => 'vielleicht später';

  @override
  String get onboardingNotificationTitle => 'verpass keinen PW chat';

  @override
  String get onboardingNotificationSubtitle => 'bekomm pings wenn was los ist';

  @override
  String get onboardingNotificationFeature1 => 'instant pings von vibern';

  @override
  String get onboardingNotificationFeature2 => 'tägliche vibe reminder';

  @override
  String get onboardingNotificationFeature3 => 'hot spot alerts';

  @override
  String get onboardingButtonTurnOnPings => 'pings aktivieren';

  @override
  String get onboardingButtonNotNow => 'jetzt nicht';

  @override
  String get onboardingLegalTitle => 'fast fertig!';

  @override
  String get onboardingLegalAgeRequirement => 'du musst 13 oder älter sein';

  @override
  String get onboardingLegalAgeSubtitle =>
      'ping & wink ist für teens und älter';

  @override
  String get onboardingLegalConsent =>
      'mit weiter bestätigst du dass du 13+ bist und akzeptierst unsere';

  @override
  String get onboardingLegalTerms => 'nutzungsbedingungen';

  @override
  String get onboardingLegalAnd => ' und ';

  @override
  String get onboardingLegalPrivacyPolicy => 'datenschutzrichtlinie';

  @override
  String get onboardingLegalSafetyFeature1 => 'nur anonyme vibes';

  @override
  String get onboardingLegalSafetyFeature2 => 'instant blocking & reporting';

  @override
  String get onboardingLegalSafetyFeature3 =>
      '20 min timeout bei fehlverhalten';

  @override
  String get onboardingButtonImAge13AndAgree => 'ich bin 13+ und akzeptiere';

  @override
  String get onboardingButtonImUnder13 => 'ich bin unter 13';

  @override
  String get onboardingLocationDeniedTitle => 'du verpasst alle PW sparks';

  @override
  String get onboardingLocationDeniedMessage =>
      'ohne standort kannst du nicht:\n• sehen wer in der nähe ist\n• pings senden\n• winks bekommen\n• PW sparks erstellen';

  @override
  String get onboardingButtonGoBack => 'zurück';

  @override
  String get onboardingButtonExitApp => 'beenden';

  @override
  String get onboardingNotificationDeniedTitle => 'du verpasst alles';

  @override
  String get onboardingNotificationDeniedMessage =>
      'ohne benachrichtigungen:\n• niemand kann dich pingen\n• du verpasst PW sparks nearby\n• null connections möglich\n\nunsere user aktivieren benachrichtigungen';

  @override
  String get onboardingButtonLetMeReconsider => 'lass mich überlegen';

  @override
  String get onboardingButtonContinueAnyway => 'trotzdem weiter';

  @override
  String get onboardingAgeDialogTitle => 'bis später!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink ist für nutzer ab 13 jahren. komm zurück wenn du alt genug bist!';

  @override
  String get onboardingButtonUnderstood => 'verstanden';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'jetzt';

  @override
  String get onboardingNotificationExamplePing => 'neuer ping 230m entfernt';

  @override
  String get onboardingNotificationExampleMessage => 'jemand vibed mit dir';

  @override
  String get onboardingMapNotification => 'jemand ist 753m entfernt am start';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• nur wenn app offen ist\n• kein hintergrund-tracking\n• nur anonyme vibes';

  @override
  String get onboardingLocationDeniedFormatted =>
      'ohne standort kannst du nicht:\n• sehen wer in der nähe ist\n• pings senden\n• winks bekommen\n• sparks erstellen';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'ohne benachrichtigungen:\n• niemand kann dich pingen\n• verpasst vibes nearby\n• null connections\n\nunsere user aktivieren benachrichtigungen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'Connecte durch Emotionen';

  @override
  String get settingsShareTitle => 'Mit Friends teilen';

  @override
  String get settingsShareSubtitle => 'Lade andere ein Vibes zu entdecken';

  @override
  String get settingsSectionPreferences => 'Einstellungen';

  @override
  String get settingsSectionLegal => 'Rechtliches';

  @override
  String get settingsSectionSupport => 'Support';

  @override
  String get settingsSectionDataManagement => 'Datenverwaltung';

  @override
  String get settingsNotificationsTitle => 'Benachrichtigungen';

  @override
  String get settingsNotificationsEnabled => 'Aktiviert';

  @override
  String get settingsNotificationsDisabled => 'Deaktiviert';

  @override
  String get settingsMapThemeTitle => 'Map Theme';

  @override
  String get settingsMapThemeCyberpunk => 'Cyberpunk';

  @override
  String get settingsMapThemeMinimalist => 'Minimalistisch';

  @override
  String get settingsLocationModeTitle => 'Standort-Modus';

  @override
  String get settingsLocationModeSoft => 'Standort verschoben, nur für Style';

  @override
  String get settingsLocationModeExact => 'Dein Vibe genau wo du bist';

  @override
  String get settingsDeleteVibeTitle => 'Meinen Vibe löschen';

  @override
  String get settingsDeleteVibeSubtitle =>
      'Deine Emotion von der Map entfernen';

  @override
  String get settingsPrivacyTitle => 'Datenschutzrichtlinie';

  @override
  String get settingsPrivacySubtitle => 'Wie wir deine Daten schützen';

  @override
  String get settingsTermsTitle => 'Nutzungsbedingungen';

  @override
  String get settingsTermsSubtitle => 'Regeln für die App-Nutzung';

  @override
  String get settingsHelpTitle => 'Hilfe-Center';

  @override
  String get settingsHelpSubtitle => 'FAQ und Guides';

  @override
  String get settingsContactTitle => 'Kontakt';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'Account löschen';

  @override
  String get settingsDeleteAccountSubtitle => 'Alle deine Daten löschen';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Just Vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'Geräte-ID: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => 'Deinen Vibe löschen?';

  @override
  String get settingsDeleteVibeDialogMessage =>
      'Deine Emotion verschwindet von der Map';

  @override
  String get settingsVibeDeletedSuccess => 'Dein Vibe wurde gelöscht';

  @override
  String get settingsVibeDeleteError => 'Fehler beim Löschen des Vibes';

  @override
  String get settingsNotificationWarningTitle => 'Achtung!';

  @override
  String get settingsNotificationWarningMessage =>
      'Wenn du Benachrichtigungen deaktivierst, kannst du keine PINGS von anderen empfangen.\n\nPW Chats (Connections) werden unmöglich.\n\nWirklich deaktivieren?';

  @override
  String get settingsNotificationWarningCancel => 'Abbrechen';

  @override
  String get settingsNotificationWarningDisable => 'Trotzdem deaktivieren';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ Benachrichtigungen deaktiviert - Du bekommst keine Pings';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ Benachrichtigungen aktiviert - Du kannst Pings empfangen';

  @override
  String get settingsMapThemeCyberpunkActivated =>
      'Cyberpunk Mode aktiviert 🌃';

  @override
  String get settingsMapThemeDayActivated => 'Tag-Modus aktiviert ☀️';

  @override
  String get settingsSoftModeEnabled =>
      'Soft Mode! Dein Vibe ist verschoben 🌊';

  @override
  String get settingsNormalModeEnabled => 'Normal Mode! Exakter Standort 📍';

  @override
  String get settingsIdCopied => 'ID kopiert';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ Account löschen';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden. Alle deine Emotionen und Daten werden für immer gelöscht.\n\nBist du sicher?';

  @override
  String get settingsDeleteAccountDialogDelete => 'Löschen';

  @override
  String get settingsDeleteAccountError => 'Fehler beim Account löschen';

  @override
  String get settingsModerationPanelTitle => '🔍 Moderations-Panel';

  @override
  String get settingsModerationPanelSubtitle => 'Nur für App Store Review';

  @override
  String get settingsModerationActiveBans => 'Aktive Bans';

  @override
  String get settingsModerationReports => 'Reports';

  @override
  String get settingsModerationClearData => 'Testdaten löschen';

  @override
  String get settingsModerationDataCleared => 'Testdaten gelöscht';

  @override
  String get sparkConnectingToChat => 'Verbinde mit PW Chat...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => 'Beendet';

  @override
  String get sparkSendFirstMessage => 'Sende die erste Message!';

  @override
  String get sparkWaitingForMate => 'Warte auf PW Mate...';

  @override
  String get sparkMessagePlaceholder => 'Nachricht...';

  @override
  String get sparkWaitForReply => 'Warte auf Antwort...';

  @override
  String get sparkChatEndedPlaceholder => 'Chat beendet';

  @override
  String get sparkLeaveChat => 'PW Chat verlassen?';

  @override
  String get sparkChatEndForBoth => 'Chat endet für beide PW Mates';

  @override
  String get sparkStay => 'Bleiben';

  @override
  String get sparkLeave => 'Verlassen';

  @override
  String get sparkExtended => 'Verlängert! +3 Min ⚡';

  @override
  String get sparkWaitingForOther => 'Warte auf PW Mate...';

  @override
  String get sparkMaxExtensionsReached => 'Maximale Verlängerungen erreicht';

  @override
  String get sparkFailedToExtend => 'Verlängern fehlgeschlagen';

  @override
  String get sparkFailedToSend => 'Senden fehlgeschlagen';

  @override
  String get sparkMessageTooLong => 'Nachricht zu lang (max 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'Fehler beim Chat-Start: $error';
  }

  @override
  String get sparkUserBanned => 'User für 7 Minuten gebannt';

  @override
  String get sparkRestrictedForBanning =>
      'Du bist wegen zu vielen Bans eingeschränkt';

  @override
  String get sparkReportSubmitted => 'Report gesendet';

  @override
  String get sparkBehaviorRestriction =>
      'Du bist wegen unangemessenem Verhalten eingeschränkt';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'ZÜNDE DEN MOMENT';

  @override
  String trendsEmotionalPulse(String time) {
    return 'Emotionaler Puls $time';
  }

  @override
  String get trendsTimeMorning => 'heute morgen';

  @override
  String get trendsTimeAfternoon => 'heute nachmittag';

  @override
  String get trendsTimeEvening => 'heute abend';

  @override
  String get trendsTimeLateNight => 'spät nachts';

  @override
  String get trendsActiveVibes => 'Aktive Vibes';

  @override
  String get trendsSparkers => 'PW Mates';

  @override
  String get trendsDominantEmotion => 'Dominante Emotion';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% der PW Mates';
  }

  @override
  String get trendsEmotionDistribution => 'Emotions-Verteilung';

  @override
  String get trendsQuote1 => 'Jede geteilte Emotion schafft eine Connection ✨';

  @override
  String get trendsQuote2 => 'Zusammen erschaffen wir die Emotions-Map 🗺️';

  @override
  String get trendsQuote3 => 'Dein Vibe kann jemandes Tag ändern 💫';

  @override
  String get trendsQuote4 => 'PW Chats starten mit einem simplen Ping ⚡';

  @override
  String get banOverlayTitle => 'Temporäre Einschränkung';

  @override
  String get banOverlayMessage =>
      'Dein PW Mate fand deine Message unangemessen';

  @override
  String get banOverlayRestrictionInfo =>
      'Du kannst während dieser Zeit keine Vibes teilen';

  @override
  String get bottomNavMap => 'Map';

  @override
  String get bottomNavHistory => 'Verlauf';

  @override
  String get bottomNavTrends => 'Trends';

  @override
  String get bottomNavSettings => 'Settings';

  @override
  String get guidelinesTitle => 'Community-Richtlinien';

  @override
  String get guidelinesRespectTitle => 'Sei respektvoll';

  @override
  String get guidelinesRespectSubtitle => 'Behandle alle mit Freundlichkeit';

  @override
  String get guidelinesNoHarassmentTitle => 'Keine Belästigung';

  @override
  String get guidelinesNoHarassmentSubtitle =>
      'Sende keine unangemessenen Messages';

  @override
  String get guidelinesKeepRealTitle => 'Bleib echt';

  @override
  String get guidelinesKeepRealSubtitle => 'Teile nur authentische Vibes';

  @override
  String get guidelinesHaveFunTitle => 'Hab Spaß';

  @override
  String get guidelinesHaveFunSubtitle => 'Genieße PW Spark Connections!';

  @override
  String get guidelinesViolationWarning =>
      'Verstöße können zu temporären oder permanenten Einschränkungen führen';

  @override
  String get guidelinesButtonUnderstand => 'Verstanden';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'Tag $day - Halte deine Streak!';
  }

  @override
  String get emotionSelectorTapYourVibe => 'TIPP DEINEN VIBE';

  @override
  String get emotionSelectorWhatsYourVibe => 'was ist dein vibe gerade?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count aktiv jetzt';
  }

  @override
  String get miniBarSendNewPing => 'Neuen Ping senden';

  @override
  String get miniBarPingActive => 'Dein Ping ist aktiv';

  @override
  String get moderationBanTitle => 'Ban für 7 Min';

  @override
  String get moderationBanSubtitle => 'Diesen User temporär einschränken';

  @override
  String get moderationReportTitle => 'Melden';

  @override
  String get moderationReportSubtitle => 'Unangemessenes Verhalten melden';

  @override
  String get moderationEndChatTitle => 'Chat beenden';

  @override
  String get moderationEndChatSubtitle => 'Diese PW Session verlassen';

  @override
  String get moderationReportDialogTitle => 'User melden';

  @override
  String get moderationReportReasonHarassment => 'Belästigung';

  @override
  String get moderationReportReasonSpam => 'Spam';

  @override
  String get moderationReportReasonHateSpeech => 'Hassrede';

  @override
  String get moderationReportReasonOther => 'Anderes';

  @override
  String get moderationReportSendButton => 'Report senden';

  @override
  String get pingBottomVibeTooFar => 'Vibe zu weit weg (max 6km)';

  @override
  String get pingBottomVibeTooFarMessage => 'Vibe zu weit - max 6km für Ping';

  @override
  String get pingBottomTooFar => 'ZU WEIT';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'sehr nah';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get pingBottomTimeNow => 'jetzt';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get vibeAnimBrainEnergy => 'KOPF AM GLÜHEN';

  @override
  String get vibeAnimCozy => 'VIBE: GEMÜTLICH';

  @override
  String get vibeAnimSweatSlay => 'SCHWITZEN. SIEGEN. REPEAT';

  @override
  String get vibeAnimLostInBeat => 'LOST IM BEAT';

  @override
  String get vibeAnimCityLights => 'CITY LIGHTS AN';

  @override
  String get vibeAnimLightsCameraVibes => 'LICHT. KAMERA. VIBES.';

  @override
  String get vibeAnimEveningVibes => 'ABEND VIBES';

  @override
  String get vibeAnimPartyMode => 'PARTY MODE: AN';

  @override
  String get vibeAnimSubBrainTime => 'Brain Time 🧠';

  @override
  String get vibeAnimSubCaffeine => 'Koffein Vibes ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'No Days Off 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'Lautstärke: MAX 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'Urban Explorer 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'Create & Glow 📸';

  @override
  String get vibeAnimSubNightFlow => 'Night Flow 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'Chaos entfesseln 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE GESETZT';

  @override
  String get vibeAnimDefaultSubMessage => 'Let\'s go!';

  @override
  String get viralShareFailed => 'Teilen fehlgeschlagen';

  @override
  String get viralShareTextNight =>
      'alle schlafen. aber etwas passiert\npingandwink.com';

  @override
  String get viralShareTextEvening =>
      'der abend. die beste zeit\npingandwink.com';

  @override
  String get viralShareTextDefault =>
      'was passiert gerade jetzt?\npingandwink.com';

  @override
  String get viralShareMainText => 'was passiert\nwährend du das liest?';

  @override
  String get viralShareFindOut => 'finde es raus';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'teilen →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW Mate will connecten';

  @override
  String get winkBannerWinkBack => 'WINK ZURÜCK';
}
