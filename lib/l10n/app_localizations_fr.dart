// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Oui';

  @override
  String get commonNo => 'Non';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonShare => 'Partager';

  @override
  String get commonLoading => 'Chargement...';

  @override
  String get commonError => 'Erreur';

  @override
  String get commonSuccess => 'Succès';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String get chatBlockedMessage =>
      'Cannot share personal information or inappropriate content';

  @override
  String get mapEmptyHintFridayTime =>
      'Vide maintenant ? C\'est normal ! 😊 L\'heure de pointe c\'est 18h-22h quand tout le monde est actif 🌃';

  @override
  String get vibeLabelBrainMode => 'Mode Focus';

  @override
  String get vibeLabelLatteBreak => 'Pause Café';

  @override
  String get vibeLabelSportMode => 'Mode Sport';

  @override
  String get vibeLabelSoundLoop => 'Dans le Son';

  @override
  String get vibeLabelCityWalk => 'Balade Urbaine';

  @override
  String get vibeLabelContentMode => 'Mode Créa';

  @override
  String get vibeLabelChillNight => 'Soirée Chill';

  @override
  String get vibeLabelPartyMode => 'Mode Soirée';

  @override
  String get scanYourVibe => 'Fixe ton vibe ⚡';

  @override
  String get pickYourMood =>
      'Choisis ton mood et regarde ce qui se passe là 👀';

  @override
  String waitMinutes(int minutes) {
    return 'Attends $minutes min ⏰';
  }

  @override
  String get swipeDownToMap => '↓ Swipe vers le bas pour la carte';

  @override
  String get changeYourMood => 'Changer ton mood';

  @override
  String get swipeUp => 'Swipe vers le haut ↑';

  @override
  String get youAreNotAlone => 'T\'es pas seul !';

  @override
  String get you => 'TOI';

  @override
  String get others => 'autres';

  @override
  String get days => 'jours';

  @override
  String streak(int days) {
    return '🔥 Série : $days j';
  }

  @override
  String get shareMyVibe => '📤 Partager mon vibe';

  @override
  String get close => 'Fermer';

  @override
  String get happy => 'kiffent';

  @override
  String get nearby => 'près de toi';

  @override
  String get enableLocationSettings => 'Active la géoloc dans les réglages';

  @override
  String get errorTryAgain => 'Erreur, réessaie';

  @override
  String get networkError => 'Problème réseau';

  @override
  String get missingConfiguration => 'Config manquante';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'mon mood $emotion là maintenant 💭 qui d\'autre ? check -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'Mon vibe sur MoodMap ! 🌟';

  @override
  String get pingErrorYourVibeExpired =>
      'Ton vibe a expiré, mets-en un nouveau';

  @override
  String get pingSentSuccess => 'Ping envoyé ! ⚡ 60s pour un Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'Attends $seconds sec';
  }

  @override
  String get pingSomeoneAlreadySent => 'Quelqu\'un a déjà envoyé un ping';

  @override
  String get pingPersonInSpark => 'Cette personne est déjà en PW chat';

  @override
  String get pingThisVibeExpired => 'Ce vibe a expiré';

  @override
  String get pingFailedToSend => 'Échec de l\'envoi';

  @override
  String get pingSendingError => 'Erreur d\'envoi';

  @override
  String get pingCancelled => 'Ping annulé';

  @override
  String get pingCancelledBySender => 'Ping annulé par l\'expéditeur';

  @override
  String get pingErrorConnecting => 'Erreur de connexion avec le PW mate';

  @override
  String get pingErrorStartingChat => 'Erreur au lancement du chat';

  @override
  String get chatTimeNow => 'maintenant';

  @override
  String chatTimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String chatTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get distanceVeryClose => 'très proche';

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
  String get birthYearTitle => 'ton année de naissance';

  @override
  String get birthYearPrivacyText => 'privé • jamais montré';

  @override
  String get birthYearDefaultGeneration => 'Génération Cool ⭐';

  @override
  String get genLabel2012 => 'Enfants iPad 📱';

  @override
  String get genLabel2011 => 'OG Minecraft ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'Génération Insta 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'Enfants TikTok 🎬';

  @override
  String get genLabel2006 => 'Génération YouTube 🎮';

  @override
  String get genLabel2005 => 'Ère Facebook 👍';

  @override
  String get genLabel2004 => 'Snapchat 👻';

  @override
  String get genLabel2003 => 'Ère MSN 💬';

  @override
  String get genLabel2002 => 'Génération iPod 🎧';

  @override
  String get genLabel2001 => 'Harry Potter ⚡';

  @override
  String get genLabel2000 => 'Enfants Y2K 🌐';

  @override
  String get genLabel1999 => 'Génération Matrix 💊';

  @override
  String get genLabel1998 => 'Game Boy 🎮';

  @override
  String get genLabel1997 => 'Pokémon 🔴';

  @override
  String get genLabel1996 => 'Enfants Modem 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'Ère Friends ☕';

  @override
  String get genLabel1993 => 'Génération Sonic 💨';

  @override
  String get genLabel1992 => 'Club Dorothée 📺';

  @override
  String get genLabel1991 => 'Enfants NES 🎮';

  @override
  String get genLabel1990 => 'Génération MTV 🎸';

  @override
  String get genLabel1989 => 'Ère Game Boy 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'Enfants VHS 📼';

  @override
  String get genLabel1986 => 'Génération Arcade 👾';

  @override
  String get genLabel1985 => 'Retour Futur ⏰';

  @override
  String get genLabel1984 => 'Enfants Mac 🍎';

  @override
  String get genLabel1983 => 'Star Wars ⚔️';

  @override
  String get genLabel1982 => 'Génération E.T. 👽';

  @override
  String get genLabel1981 => 'Début MTV 📺';

  @override
  String get genLabel1980 => 'Pac-Man 👾';

  @override
  String get genLabel1979 => 'Ère Disco 🪩';

  @override
  String get genLabel1978 => 'Space Invaders 🚀';

  @override
  String get genLabel1977 => 'Star Wars OG 🌟';

  @override
  String get genLabel1976 => 'Punk Rock 🎸';

  @override
  String get genLabel1975 => 'Les Dents de la Mer 🦈';

  @override
  String get genLabel1974 => 'Début Disco 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'Ère Pong 🏓';

  @override
  String get genLabel1971 => 'Zeppelin 🎸';

  @override
  String get genLabel1970 => 'Génération Beatles 🎵';

  @override
  String get genLabel1969 => 'Légendes 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'Historique';

  @override
  String get historyEmptyTitle => 'Pas encore d\'émotions';

  @override
  String get historyEmptySubtitle =>
      'Commence à partager tes vibes\npour voir ton historique';

  @override
  String get historyMyEmotions => 'Mes émotions';

  @override
  String get historyStatTotal => 'Total';

  @override
  String get historyStatDominant => 'Dominante';

  @override
  String get historyToday => 'Aujourd\'hui';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => 'Tendances';

  @override
  String get trendsSubtitle => 'Les stats de la ville arrivent';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'C\'est ton propre vibe';

  @override
  String get mapErrorNeedActiveVibeToPing =>
      'Il te faut un vibe actif pour envoyer des pings';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'Tu as déjà un ping actif ou le vibe est indispo';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'Tu es restreint pendant $time';
  }

  @override
  String get mapBanRestrictionLifted =>
      'Restriction levée ! Tu peux repartager des vibes';

  @override
  String mapSuccessVibeSent(int count) {
    return 'Vibe envoyé ! $count autres près de toi 🎉';
  }

  @override
  String get mapTutorialTapToSpark => 'tape sur un vibe • PW chat en 60s';

  @override
  String mapActivePingStatus(int seconds) {
    return 'Ping actif (${seconds}s) - Tape pour annuler';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin =>
      'regarde ce qui se passe autour maintenant';

  @override
  String get onboardingButtonLetsGo => 'c\'est parti';

  @override
  String get onboardingBadgeAge13Plus => '13+ seulement';

  @override
  String get onboardingValueTitleInstantSparks => 'PW chat instantané';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'connexion en 60 sec';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'vibes hyperlocaux';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => 'seulement 2km de rayon';

  @override
  String get onboardingValueTitleNoProfiles => 'aucun profil';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'juste des moments purs';

  @override
  String get onboardingButtonImReady => 'je suis prêt';

  @override
  String get onboardingLocationTitle => 'débloque ta zone';

  @override
  String get onboardingLocationSubtitle =>
      'vois les vibes dans un rayon de 2km';

  @override
  String get onboardingLocationPrivacyTitle => 'vie privée d\'abord';

  @override
  String get onboardingLocationPrivacyBullet1 =>
      'seulement quand l\'app est ouverte';

  @override
  String get onboardingLocationPrivacyBullet2 =>
      'pas de tracking en arrière-plan';

  @override
  String get onboardingLocationPrivacyBullet3 => 'vibes anonymes uniquement';

  @override
  String get onboardingButtonEnableRadar => 'activer le radar';

  @override
  String get onboardingButtonMaybeLater => 'peut-être plus tard';

  @override
  String get onboardingNotificationTitle => 'rate jamais un PW chat';

  @override
  String get onboardingNotificationSubtitle =>
      'reçois des pings quand ça bouge près de toi';

  @override
  String get onboardingNotificationFeature1 => 'pings instantanés des vibers';

  @override
  String get onboardingNotificationFeature2 => 'rappels quotidiens de vibe';

  @override
  String get onboardingNotificationFeature3 => 'alertes zones chaudes';

  @override
  String get onboardingButtonTurnOnPings => 'activer les pings';

  @override
  String get onboardingButtonNotNow => 'pas maintenant';

  @override
  String get onboardingLegalTitle => 'presque fini !';

  @override
  String get onboardingLegalAgeRequirement => 'tu dois avoir 13 ans ou plus';

  @override
  String get onboardingLegalAgeSubtitle =>
      'ping & wink est pour les ados et plus';

  @override
  String get onboardingLegalConsent =>
      'en continuant, tu confirmes avoir 13+ et acceptes nos';

  @override
  String get onboardingLegalTerms => 'conditions';

  @override
  String get onboardingLegalAnd => ' et ';

  @override
  String get onboardingLegalPrivacyPolicy => 'politique de confidentialité';

  @override
  String get onboardingLegalSafetyFeature1 => 'vibes anonymes uniquement';

  @override
  String get onboardingLegalSafetyFeature2 =>
      'blocage et signalement instantanés';

  @override
  String get onboardingLegalSafetyFeature3 =>
      'timeout 20 min pour mauvais comportement';

  @override
  String get onboardingButtonImAge13AndAgree => 'j\'ai 13+ et j\'accepte';

  @override
  String get onboardingButtonImUnder13 => 'j\'ai moins de 13 ans';

  @override
  String get onboardingLocationDeniedTitle =>
      'tu vas rater toutes les PW étincelles';

  @override
  String get onboardingLocationDeniedMessage =>
      'sans géoloc tu peux pas :\n• voir qui est là\n• envoyer des pings\n• recevoir des winks\n• créer des PW étincelles';

  @override
  String get onboardingButtonGoBack => 'retour';

  @override
  String get onboardingButtonExitApp => 'quitter';

  @override
  String get onboardingNotificationDeniedTitle => 'tu vas tout rater';

  @override
  String get onboardingNotificationDeniedMessage =>
      'sans notifs :\n• personne peut te pinger\n• tu rates les PW étincelles\n• zéro connexion possible\n\nnos users activent les notifs';

  @override
  String get onboardingButtonLetMeReconsider => 'laisse-moi réfléchir';

  @override
  String get onboardingButtonContinueAnyway => 'continuer quand même';

  @override
  String get onboardingAgeDialogTitle => 'à plus tard !';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink est pour les 13 ans et plus. reviens quand tu auras grandi !';

  @override
  String get onboardingButtonUnderstood => 'compris';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'maintenant';

  @override
  String get onboardingNotificationExamplePing => 'nouveau ping à 230m';

  @override
  String get onboardingNotificationExampleMessage => 'quelqu\'un vibe avec toi';

  @override
  String get onboardingMapNotification => 'quelqu\'un s\'est allumé à 753m';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• seulement quand l\'app est ouverte\n• pas de tracking en arrière-plan\n• vibes anonymes uniquement';

  @override
  String get onboardingLocationDeniedFormatted =>
      'sans géoloc tu peux pas :\n• voir qui est là\n• envoyer des pings\n• recevoir des winks\n• créer des étincelles';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'sans notifs :\n• personne peut te pinger\n• tu rates les vibes proches\n• zéro connexion\n\nnos users activent les notifs';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'Connexion par émotions';

  @override
  String get settingsShareTitle => 'Partage avec tes potes';

  @override
  String get settingsShareSubtitle => 'Invite les autres à découvrir les vibes';

  @override
  String get settingsSectionPreferences => 'Préférences';

  @override
  String get settingsSectionLegal => 'Légal';

  @override
  String get settingsSectionSupport => 'Support';

  @override
  String get settingsSectionDataManagement => 'Gestion des données';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsNotificationsEnabled => 'Activées';

  @override
  String get settingsNotificationsDisabled => 'Désactivées';

  @override
  String get settingsMapThemeTitle => 'Thème de carte';

  @override
  String get settingsMapThemeCyberpunk => 'Cyberpunk';

  @override
  String get settingsMapThemeMinimalist => 'Minimaliste';

  @override
  String get settingsLocationModeTitle => 'Mode localisation';

  @override
  String get settingsLocationModeSoft =>
      'Position décalée, juste pour le style';

  @override
  String get settingsLocationModeExact => 'Ton vibe exactement où tu es';

  @override
  String get settingsDeleteVibeTitle => 'Supprimer mon vibe';

  @override
  String get settingsDeleteVibeSubtitle => 'Retirer ton émotion de la carte';

  @override
  String get settingsPrivacyTitle => 'Politique de confidentialité';

  @override
  String get settingsPrivacySubtitle => 'Comment on protège tes données';

  @override
  String get settingsTermsTitle => 'Conditions d\'utilisation';

  @override
  String get settingsTermsSubtitle => 'Règles d\'utilisation de l\'app';

  @override
  String get settingsHelpTitle => 'Centre d\'aide';

  @override
  String get settingsHelpSubtitle => 'FAQ et guides';

  @override
  String get settingsContactTitle => 'Contact';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'Supprimer mon compte';

  @override
  String get settingsDeleteAccountSubtitle => 'Effacer toutes tes données';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Juste des vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'ID appareil : $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => 'Supprimer ton vibe ?';

  @override
  String get settingsDeleteVibeDialogMessage =>
      'Ton émotion disparaîtra de la carte';

  @override
  String get settingsVibeDeletedSuccess => 'Ton vibe a été supprimé';

  @override
  String get settingsVibeDeleteError => 'Erreur de suppression du vibe';

  @override
  String get settingsNotificationWarningTitle => 'Attention !';

  @override
  String get settingsNotificationWarningMessage =>
      'Si tu désactives les notifs, tu pourras pas recevoir de PINGS des autres.\n\nLes PW chats (connexions) seront impossibles.\n\nVraiment désactiver ?';

  @override
  String get settingsNotificationWarningCancel => 'Annuler';

  @override
  String get settingsNotificationWarningDisable => 'Désactiver quand même';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ Notifs désactivées - Tu recevras aucun ping';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ Notifs activées - Tu peux recevoir des pings';

  @override
  String get settingsMapThemeCyberpunkActivated => 'Mode cyberpunk activé 🌃';

  @override
  String get settingsMapThemeDayActivated => 'Mode jour activé ☀️';

  @override
  String get settingsSoftModeEnabled => 'Mode soft ! Ton vibe est décalé 🌊';

  @override
  String get settingsNormalModeEnabled => 'Mode normal ! Position exacte 📍';

  @override
  String get settingsIdCopied => 'ID copié';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ Supprimer le compte';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'Cette action est irréversible. Toutes tes émotions et données seront supprimées définitivement.\n\nT\'es sûr ?';

  @override
  String get settingsDeleteAccountDialogDelete => 'Supprimer';

  @override
  String get settingsDeleteAccountError => 'Erreur suppression compte';

  @override
  String get settingsModerationPanelTitle => '🔍 Panel de modération';

  @override
  String get settingsModerationPanelSubtitle =>
      'Seulement pour review App Store';

  @override
  String get settingsModerationActiveBans => 'Bans actifs';

  @override
  String get settingsModerationReports => 'Signalements';

  @override
  String get settingsModerationClearData => 'Effacer données test';

  @override
  String get settingsModerationDataCleared => 'Données test effacées';

  @override
  String get sparkConnectingToChat => 'Connexion au PW chat...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => 'Terminé';

  @override
  String get sparkSendFirstMessage => 'Envoie le premier message !';

  @override
  String get sparkWaitingForMate => 'J\'attends le PW mate...';

  @override
  String get sparkMessagePlaceholder => 'Message...';

  @override
  String get sparkWaitForReply => 'Attends la réponse...';

  @override
  String get sparkChatEndedPlaceholder => 'Chat terminé';

  @override
  String get sparkLeaveChat => 'Quitter le PW chat ?';

  @override
  String get sparkChatEndForBoth => 'Le chat se termine pour les deux PW mates';

  @override
  String get sparkStay => 'Rester';

  @override
  String get sparkLeave => 'Partir';

  @override
  String get sparkExtended => 'Prolongé ! +3 min ⚡';

  @override
  String get sparkWaitingForOther => 'J\'attends le PW mate...';

  @override
  String get sparkMaxExtensionsReached => 'Maximum de prolongations atteint';

  @override
  String get sparkFailedToExtend => 'Échec de prolongation';

  @override
  String get sparkFailedToSend => 'Échec d\'envoi';

  @override
  String get sparkMessageTooLong => 'Message trop long (max 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'Erreur d\'initialisation du chat : $error';
  }

  @override
  String get sparkUserBanned => 'Utilisateur banni pour 7 minutes';

  @override
  String get sparkRestrictedForBanning =>
      'Tu es restreint pour bannissements excessifs';

  @override
  String get sparkReportSubmitted => 'Signalement envoyé';

  @override
  String get sparkBehaviorRestriction =>
      'Tu es restreint pour comportement inapproprié';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'ALLUME L\'INSTANT';

  @override
  String trendsEmotionalPulse(String time) {
    return 'Pouls émotionnel $time';
  }

  @override
  String get trendsTimeMorning => 'ce matin';

  @override
  String get trendsTimeAfternoon => 'cet aprèm';

  @override
  String get trendsTimeEvening => 'ce soir';

  @override
  String get trendsTimeLateNight => 'tard le soir';

  @override
  String get trendsActiveVibes => 'Vibes actifs';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => 'Émotion dominante';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% des PW mates';
  }

  @override
  String get trendsEmotionDistribution => 'Répartition des émotions';

  @override
  String get trendsQuote1 => 'Chaque émotion partagée crée une connexion ✨';

  @override
  String get trendsQuote2 => 'Ensemble on crée la carte des émotions 🗺️';

  @override
  String get trendsQuote3 =>
      'Ton vibe peut changer la journée de quelqu\'un 💫';

  @override
  String get trendsQuote4 => 'Les PW chats commencent par un simple ping ⚡';

  @override
  String get banOverlayTitle => 'Restriction temporaire';

  @override
  String get banOverlayMessage =>
      'Ton PW mate a trouvé ton message inapproprié';

  @override
  String get banOverlayRestrictionInfo =>
      'Tu peux pas partager de vibes pendant ce temps';

  @override
  String get bottomNavMap => 'Carte';

  @override
  String get bottomNavHistory => 'Historique';

  @override
  String get bottomNavTrends => 'Tendances';

  @override
  String get bottomNavSettings => 'Réglages';

  @override
  String get guidelinesTitle => 'Règles de la communauté';

  @override
  String get guidelinesRespectTitle => 'Sois respectueux';

  @override
  String get guidelinesRespectSubtitle =>
      'Traite tout le monde avec gentillesse';

  @override
  String get guidelinesNoHarassmentTitle => 'Pas de harcèlement';

  @override
  String get guidelinesNoHarassmentSubtitle =>
      'N\'envoie pas de messages inappropriés';

  @override
  String get guidelinesKeepRealTitle => 'Reste vrai';

  @override
  String get guidelinesKeepRealSubtitle =>
      'Partage seulement des vibes authentiques';

  @override
  String get guidelinesHaveFunTitle => 'Amuse-toi';

  @override
  String get guidelinesHaveFunSubtitle => 'Profite des PW étincelles !';

  @override
  String get guidelinesViolationWarning =>
      'Les violations peuvent entraîner des restrictions temporaires ou permanentes';

  @override
  String get guidelinesButtonUnderstand => 'J\'ai compris';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'Jour $day - Garde ta série !';
  }

  @override
  String get emotionSelectorTapYourVibe => 'TAPE TON VIBE';

  @override
  String get emotionSelectorWhatsYourVibe => 'c\'est quoi ton vibe là ?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count actifs maintenant';
  }

  @override
  String get miniBarSendNewPing => 'Envoie un nouveau ping';

  @override
  String get miniBarPingActive => 'Ton ping est actif';

  @override
  String get moderationBanTitle => 'Ban pour 7 min';

  @override
  String get moderationBanSubtitle => 'Restreindre temporairement cet user';

  @override
  String get moderationReportTitle => 'Signaler';

  @override
  String get moderationReportSubtitle => 'Signaler un comportement inapproprié';

  @override
  String get moderationEndChatTitle => 'Terminer le chat';

  @override
  String get moderationEndChatSubtitle => 'Quitter cette session PW';

  @override
  String get moderationReportDialogTitle => 'Signaler l\'utilisateur';

  @override
  String get moderationReportReasonHarassment => 'Harcèlement';

  @override
  String get moderationReportReasonSpam => 'Spam';

  @override
  String get moderationReportReasonHateSpeech => 'Discours de haine';

  @override
  String get moderationReportReasonOther => 'Autre';

  @override
  String get moderationReportSendButton => 'Envoyer le signalement';

  @override
  String get pingBottomVibeTooFar => 'Vibe trop loin (max 6km)';

  @override
  String get pingBottomVibeTooFarMessage =>
      'Vibe trop loin - max 6km pour un ping';

  @override
  String get pingBottomTooFar => 'TROP LOIN';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'très proche';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get pingBottomTimeNow => 'maintenant';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get vibeAnimBrainEnergy => 'CERVEAU EN FEU';

  @override
  String get vibeAnimCozy => 'VIBE : COSY';

  @override
  String get vibeAnimSweatSlay => 'SUER. KIFFER. RÉPÉTER';

  @override
  String get vibeAnimLostInBeat => 'PERDU DANS LE SON';

  @override
  String get vibeAnimCityLights => 'LUMIÈRES URBAINES';

  @override
  String get vibeAnimLightsCameraVibes => 'ACTION. CAMÉRA. VIBES.';

  @override
  String get vibeAnimEveningVibes => 'VIBES DU SOIR';

  @override
  String get vibeAnimPartyMode => 'MODE : SOIRÉE';

  @override
  String get vibeAnimSubBrainTime => 'Temps de réflexion 🧠';

  @override
  String get vibeAnimSubCaffeine => 'Vibes caféine ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'Pas de repos 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'Volume : MAX 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'Explorateur urbain 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'Créer et briller 📸';

  @override
  String get vibeAnimSubNightFlow => 'Flow nocturne 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'Libère le chaos 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE FIXÉ';

  @override
  String get vibeAnimDefaultSubMessage => 'C\'est parti !';

  @override
  String get viralShareFailed => 'Échec du partage';

  @override
  String get viralShareTextNight =>
      'tout le monde dort. mais quelque chose se passe\npingandwink.com';

  @override
  String get viralShareTextEvening =>
      'le soir. le meilleur moment\npingandwink.com';

  @override
  String get viralShareTextDefault =>
      'qu\'est-ce qui se passe maintenant ?\npingandwink.com';

  @override
  String get viralShareMainText =>
      'qu\'est-ce qui se passe\npendant que tu lis ça ?';

  @override
  String get viralShareFindOut => 'découvre';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'partager →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate veut connecter';

  @override
  String get winkBannerWinkBack => 'WINK RETOUR';
}
