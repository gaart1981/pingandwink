import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

/// The translations for Spanish, as used in Latin America (`es_419`).
class AppLocalizationsEs419 extends AppLocalizationsEs {
  AppLocalizationsEs419([String locale = 'es_419']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Sí';

  @override
  String get commonNo => 'No';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonShare => 'Compartir';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String get commonError => 'Error';

  @override
  String get commonSuccess => 'Listo';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonDone => 'Listo';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get vibeLabelBrainMode => 'Modo Focus';

  @override
  String get vibeLabelLatteBreak => 'Break Café';

  @override
  String get vibeLabelSportMode => 'Modo Gym';

  @override
  String get vibeLabelSoundLoop => 'En la Music';

  @override
  String get vibeLabelCityWalk => 'Paseando';

  @override
  String get vibeLabelContentMode => 'Creando';

  @override
  String get vibeLabelChillNight => 'Noche Chill';

  @override
  String get vibeLabelPartyMode => 'Modo Fiesta';

  @override
  String get scanYourVibe => 'Fija tu vibe ⚡';

  @override
  String get pickYourMood => 'Elige tu mood y mira qué pasa ahorita 👀';

  @override
  String waitMinutes(int minutes) {
    return 'Espera $minutes min ⏰';
  }

  @override
  String get swipeDownToMap => '↓ Desliza para ver el mapa';

  @override
  String get changeYourMood => 'Cambiar tu mood';

  @override
  String get swipeUp => 'Desliza arriba ↑';

  @override
  String get youAreNotAlone => '¡No estás solo!';

  @override
  String get you => 'TÚ';

  @override
  String get others => 'más';

  @override
  String get days => 'días';

  @override
  String streak(int days) {
    return '🔥 Racha: $days días';
  }

  @override
  String get shareMyVibe => '📤 Compartir mi vibe';

  @override
  String get close => 'Cerrar';

  @override
  String get happy => 'vibran';

  @override
  String get nearby => 'cerca de ti';

  @override
  String get enableLocationSettings => 'Activa ubicación en ajustes';

  @override
  String get errorTryAgain => 'Error, intenta otra vez';

  @override
  String get networkError => 'Error de red';

  @override
  String get missingConfiguration => 'Falta configuración';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'mi mood $emotion ahorita 💭 quién más? checa -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => '¡Mi vibe en MoodMap! 🌟';

  @override
  String get pingErrorYourVibeExpired => 'Tu vibe expiró, pon uno nuevo';

  @override
  String get pingSentSuccess => '¡Ping enviado! ⚡ 60s para un Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'Espera $seconds seg';
  }

  @override
  String get pingSomeoneAlreadySent => 'Alguien ya envió un ping';

  @override
  String get pingPersonInSpark => 'Esta persona ya está en PW chat';

  @override
  String get pingThisVibeExpired => 'Este vibe ya expiró';

  @override
  String get pingFailedToSend => 'No se pudo enviar';

  @override
  String get pingSendingError => 'Error al enviar';

  @override
  String get pingCancelled => 'Ping cancelado';

  @override
  String get pingCancelledBySender => 'Ping cancelado por quien envió';

  @override
  String get pingErrorConnecting => 'Error conectando con PW mate';

  @override
  String get pingErrorStartingChat => 'Error iniciando el chat';

  @override
  String get chatTimeNow => 'ahora';

  @override
  String chatTimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String chatTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get distanceVeryClose => 'muy cerca';

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
  String get birthYearTitle => 'tu año de nacimiento';

  @override
  String get birthYearPrivacyText => 'privado • nunca se muestra';

  @override
  String get birthYearDefaultGeneration => 'Generación Cool ⭐';

  @override
  String get genLabel2012 => 'Niños iPad 📱';

  @override
  String get genLabel2011 => 'OG Minecraft ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'Gen Instagram 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'Niños TikTok 🎬';

  @override
  String get genLabel2006 => 'Gen YouTube 🎮';

  @override
  String get genLabel2005 => 'Era Facebook 👍';

  @override
  String get genLabel2004 => 'Snapchat 👻';

  @override
  String get genLabel2003 => 'Era MSN 💬';

  @override
  String get genLabel2002 => 'Gen iPod 🎧';

  @override
  String get genLabel2001 => 'Potterheads ⚡';

  @override
  String get genLabel2000 => 'Niños Y2K 🌐';

  @override
  String get genLabel1999 => 'Gen Matrix 💊';

  @override
  String get genLabel1998 => 'Game Boy 🎮';

  @override
  String get genLabel1997 => 'Pokémon 🔴';

  @override
  String get genLabel1996 => 'Niños Internet 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'Era Friends ☕';

  @override
  String get genLabel1993 => 'Gen Sonic 💨';

  @override
  String get genLabel1992 => 'Dragon Ball Z 📺';

  @override
  String get genLabel1991 => 'Super Nintendo 🎮';

  @override
  String get genLabel1990 => 'Gen MTV 🎸';

  @override
  String get genLabel1989 => 'Era Nintendo 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'Niños VHS 📼';

  @override
  String get genLabel1986 => 'Gen Arcade 👾';

  @override
  String get genLabel1985 => 'Volver al Futuro ⏰';

  @override
  String get genLabel1984 => 'Niños Mac 🍎';

  @override
  String get genLabel1983 => 'Star Wars ⚔️';

  @override
  String get genLabel1982 => 'Gen E.T. 👽';

  @override
  String get genLabel1981 => 'Inicio MTV 📺';

  @override
  String get genLabel1980 => 'Pac-Man 👾';

  @override
  String get genLabel1979 => 'Era Disco 🪩';

  @override
  String get genLabel1978 => 'Space Invaders 🚀';

  @override
  String get genLabel1977 => 'Star Wars OG 🌟';

  @override
  String get genLabel1976 => 'Punk Rock 🎸';

  @override
  String get genLabel1975 => 'Gen Tiburón 🦈';

  @override
  String get genLabel1974 => 'Inicio Disco 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'Era Pong 🏓';

  @override
  String get genLabel1971 => 'Zeppelin 🎸';

  @override
  String get genLabel1970 => 'Gen Beatles 🎵';

  @override
  String get genLabel1969 => 'Leyendas 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'Historial';

  @override
  String get historyEmptyTitle => 'Sin emociones aún';

  @override
  String get historyEmptySubtitle =>
      'Empieza a compartir tus vibes\npara ver tu historial';

  @override
  String get historyMyEmotions => 'Mis emociones';

  @override
  String get historyStatTotal => 'Total';

  @override
  String get historyStatDominant => 'Dominante';

  @override
  String get historyToday => 'Hoy';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => 'Tendencias';

  @override
  String get trendsSubtitle => 'Llegando las stats de la ciudad';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'Es tu propio vibe';

  @override
  String get mapErrorNeedActiveVibeToPing =>
      'Necesitas un vibe activo para enviar pings';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'Ya tienes un ping activo o el vibe no está disponible';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'Estás restringido por $time';
  }

  @override
  String get mapBanRestrictionLifted =>
      '¡Restricción levantada! Puedes compartir vibes de nuevo';

  @override
  String mapSuccessVibeSent(int count) {
    return '¡Vibe enviado! $count más cerca 🎉';
  }

  @override
  String get mapTutorialTapToSpark => 'toca un vibe • PW chat en 60s';

  @override
  String mapActivePingStatus(int seconds) {
    return 'Ping activo (${seconds}s) - Toca para cancelar';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin =>
      'mira qué está pasando cerca ahorita';

  @override
  String get onboardingButtonLetsGo => 'dale';

  @override
  String get onboardingBadgeAge13Plus => 'solo 13+';

  @override
  String get onboardingValueTitleInstantSparks => 'PW chat al instante';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'conecta en 60 seg';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'vibes hiperlocales';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => 'solo 2km de radio';

  @override
  String get onboardingValueTitleNoProfiles => 'sin perfiles';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'solo momentos reales';

  @override
  String get onboardingButtonImReady => 'estoy ready';

  @override
  String get onboardingLocationTitle => 'desbloquea tu zona';

  @override
  String get onboardingLocationSubtitle => 'mira los vibes en 2km a la redonda';

  @override
  String get onboardingLocationPrivacyTitle => 'privacidad primero';

  @override
  String get onboardingLocationPrivacyBullet1 =>
      'solo cuando la app está abierta';

  @override
  String get onboardingLocationPrivacyBullet2 =>
      'sin tracking en segundo plano';

  @override
  String get onboardingLocationPrivacyBullet3 => 'solo vibes anónimos';

  @override
  String get onboardingButtonEnableRadar => 'activar radar';

  @override
  String get onboardingButtonMaybeLater => 'quizás después';

  @override
  String get onboardingNotificationTitle => 'nunca te pierdas un PW chat';

  @override
  String get onboardingNotificationSubtitle =>
      'recibe pings cuando haya movimiento cerca';

  @override
  String get onboardingNotificationFeature1 => 'pings instantáneos de vibers';

  @override
  String get onboardingNotificationFeature2 => 'recordatorios diarios de vibe';

  @override
  String get onboardingNotificationFeature3 => 'alertas de zonas hot';

  @override
  String get onboardingButtonTurnOnPings => 'activar pings';

  @override
  String get onboardingButtonNotNow => 'ahora no';

  @override
  String get onboardingLegalTitle => '¡casi listo!';

  @override
  String get onboardingLegalAgeRequirement => 'debes tener 13 años o más';

  @override
  String get onboardingLegalAgeSubtitle =>
      'ping & wink es para teens y mayores';

  @override
  String get onboardingLegalConsent =>
      'al continuar, confirmas que tienes 13+ y aceptas nuestros';

  @override
  String get onboardingLegalTerms => 'términos';

  @override
  String get onboardingLegalAnd => ' y ';

  @override
  String get onboardingLegalPrivacyPolicy => 'política de privacidad';

  @override
  String get onboardingLegalSafetyFeature1 => 'solo vibes anónimos';

  @override
  String get onboardingLegalSafetyFeature2 => 'bloqueo y reporte instantáneo';

  @override
  String get onboardingLegalSafetyFeature3 =>
      'timeout de 20 min por mal comportamiento';

  @override
  String get onboardingButtonImAge13AndAgree => 'tengo 13+ y acepto';

  @override
  String get onboardingButtonImUnder13 => 'tengo menos de 13';

  @override
  String get onboardingLocationDeniedTitle =>
      'te vas a perder todas las PW chispas';

  @override
  String get onboardingLocationDeniedMessage =>
      'sin ubicación no puedes:\n• ver quién está cerca\n• enviar pings\n• recibir winks\n• crear PW chispas';

  @override
  String get onboardingButtonGoBack => 'regresar';

  @override
  String get onboardingButtonExitApp => 'salir';

  @override
  String get onboardingNotificationDeniedTitle => 'te vas a perder todo';

  @override
  String get onboardingNotificationDeniedMessage =>
      'sin notis:\n• nadie puede pingearte\n• te pierdes las PW chispas cerca\n• cero conexiones posibles\n\nnuestros usuarios activan notis';

  @override
  String get onboardingButtonLetMeReconsider => 'déjame pensarlo';

  @override
  String get onboardingButtonContinueAnyway => 'continuar igual';

  @override
  String get onboardingAgeDialogTitle => '¡nos vemos después!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink es para usuarios de 13 años o más. ¡regresa cuando crezcas!';

  @override
  String get onboardingButtonUnderstood => 'entendido';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'ahora';

  @override
  String get onboardingNotificationExamplePing => 'nuevo ping a 230m';

  @override
  String get onboardingNotificationExampleMessage => 'alguien vibra contigo';

  @override
  String get onboardingMapNotification => 'alguien se prendió a 753m';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• solo cuando la app está abierta\n• sin tracking en segundo plano\n• solo vibes anónimos';

  @override
  String get onboardingLocationDeniedFormatted =>
      'sin ubicación no puedes:\n• ver quién está cerca\n• enviar pings\n• recibir winks\n• crear chispas';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'sin notis:\n• nadie puede pingearte\n• te pierdes los vibes cerca\n• cero conexiones\n\nnuestros usuarios activan notis';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'Conecta por emociones';

  @override
  String get settingsShareTitle => 'Comparte con tus amigos';

  @override
  String get settingsShareSubtitle => 'Invita a otros a descubrir vibes';

  @override
  String get settingsSectionPreferences => 'Preferencias';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionSupport => 'Soporte';

  @override
  String get settingsSectionDataManagement => 'Gestión de datos';

  @override
  String get settingsNotificationsTitle => 'Notificaciones';

  @override
  String get settingsNotificationsEnabled => 'Activadas';

  @override
  String get settingsNotificationsDisabled => 'Desactivadas';

  @override
  String get settingsMapThemeTitle => 'Tema del mapa';

  @override
  String get settingsMapThemeCyberpunk => 'Cyberpunk';

  @override
  String get settingsMapThemeMinimalist => 'Minimalista';

  @override
  String get settingsLocationModeTitle => 'Modo ubicación';

  @override
  String get settingsLocationModeSoft => 'Ubicación movida, solo por estilo';

  @override
  String get settingsLocationModeExact => 'Tu vibe exactamente donde estás';

  @override
  String get settingsDeleteVibeTitle => 'Borrar mi vibe';

  @override
  String get settingsDeleteVibeSubtitle => 'Quitar tu emoción del mapa';

  @override
  String get settingsPrivacyTitle => 'Política de privacidad';

  @override
  String get settingsPrivacySubtitle => 'Cómo protegemos tus datos';

  @override
  String get settingsTermsTitle => 'Términos de uso';

  @override
  String get settingsTermsSubtitle => 'Reglas para usar la app';

  @override
  String get settingsHelpTitle => 'Centro de ayuda';

  @override
  String get settingsHelpSubtitle => 'FAQ y guías';

  @override
  String get settingsContactTitle => 'Contacto';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'Eliminar mi cuenta';

  @override
  String get settingsDeleteAccountSubtitle => 'Borrar todos tus datos';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Solo vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'ID dispositivo: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => '¿Borrar tu vibe?';

  @override
  String get settingsDeleteVibeDialogMessage =>
      'Tu emoción desaparecerá del mapa';

  @override
  String get settingsVibeDeletedSuccess => 'Tu vibe fue borrado';

  @override
  String get settingsVibeDeleteError => 'Error borrando vibe';

  @override
  String get settingsNotificationWarningTitle => '¡Atención!';

  @override
  String get settingsNotificationWarningMessage =>
      'Si desactivas las notis, no podrás recibir PINGS de otros.\n\nLos PW chats (conexiones) serán imposibles.\n\n¿Seguro desactivar?';

  @override
  String get settingsNotificationWarningCancel => 'Cancelar';

  @override
  String get settingsNotificationWarningDisable => 'Desactivar igual';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ Notis desactivadas - No recibirás ningún ping';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ Notis activadas - Puedes recibir pings';

  @override
  String get settingsMapThemeCyberpunkActivated => 'Modo cyberpunk activado 🌃';

  @override
  String get settingsMapThemeDayActivated => 'Modo día activado ☀️';

  @override
  String get settingsSoftModeEnabled => '¡Modo soft! Tu vibe está movido 🌊';

  @override
  String get settingsNormalModeEnabled => '¡Modo normal! Ubicación exacta 📍';

  @override
  String get settingsIdCopied => 'ID copiado';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ Eliminar cuenta';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'Esta acción es irreversible. Todas tus emociones y datos se borrarán para siempre.\n\n¿Estás seguro?';

  @override
  String get settingsDeleteAccountDialogDelete => 'Eliminar';

  @override
  String get settingsDeleteAccountError => 'Error eliminando cuenta';

  @override
  String get settingsModerationPanelTitle => '🔍 Panel de moderación';

  @override
  String get settingsModerationPanelSubtitle => 'Solo para review de App Store';

  @override
  String get settingsModerationActiveBans => 'Bans activos';

  @override
  String get settingsModerationReports => 'Reportes';

  @override
  String get settingsModerationClearData => 'Limpiar datos de prueba';

  @override
  String get settingsModerationDataCleared => 'Datos de prueba limpiados';

  @override
  String get sparkConnectingToChat => 'Conectando al PW chat...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => 'Terminado';

  @override
  String get sparkSendFirstMessage => '¡Envía el primer mensaje!';

  @override
  String get sparkWaitingForMate => 'Esperando al PW mate...';

  @override
  String get sparkMessagePlaceholder => 'Mensaje...';

  @override
  String get sparkWaitForReply => 'Espera respuesta...';

  @override
  String get sparkChatEndedPlaceholder => 'Chat terminado';

  @override
  String get sparkLeaveChat => '¿Salir del PW chat?';

  @override
  String get sparkChatEndForBoth => 'El chat termina para ambos PW mates';

  @override
  String get sparkStay => 'Quedarme';

  @override
  String get sparkLeave => 'Salir';

  @override
  String get sparkExtended => '¡Extendido! +3 min ⚡';

  @override
  String get sparkWaitingForOther => 'Esperando al PW mate...';

  @override
  String get sparkMaxExtensionsReached => 'Máximo de extensiones alcanzado';

  @override
  String get sparkFailedToExtend => 'Falla al extender';

  @override
  String get sparkFailedToSend => 'Falla al enviar';

  @override
  String get sparkMessageTooLong => 'Mensaje muy largo (máx 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'Error iniciando chat: $error';
  }

  @override
  String get sparkUserBanned => 'Usuario baneado por 7 minutos';

  @override
  String get sparkRestrictedForBanning => 'Estás restringido por banear mucho';

  @override
  String get sparkReportSubmitted => 'Reporte enviado';

  @override
  String get sparkBehaviorRestriction =>
      'Estás restringido por comportamiento inadecuado';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'PRENDE EL MOMENTO';

  @override
  String trendsEmotionalPulse(String time) {
    return 'Pulso emocional $time';
  }

  @override
  String get trendsTimeMorning => 'esta mañana';

  @override
  String get trendsTimeAfternoon => 'esta tarde';

  @override
  String get trendsTimeEvening => 'esta noche';

  @override
  String get trendsTimeLateNight => 'tarde en la noche';

  @override
  String get trendsActiveVibes => 'Vibes activos';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => 'Emoción dominante';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% de PW mates';
  }

  @override
  String get trendsEmotionDistribution => 'Distribución de emociones';

  @override
  String get trendsQuote1 => 'Cada emoción compartida crea una conexión ✨';

  @override
  String get trendsQuote2 => 'Juntos creamos el mapa de emociones 🗺️';

  @override
  String get trendsQuote3 => 'Tu vibe puede cambiar el día de alguien 💫';

  @override
  String get trendsQuote4 => 'Los PW chats empiezan con un simple ping ⚡';

  @override
  String get banOverlayTitle => 'Restricción temporal';

  @override
  String get banOverlayMessage => 'Tu PW mate encontró tu mensaje inapropiado';

  @override
  String get banOverlayRestrictionInfo =>
      'No puedes compartir vibes durante este tiempo';

  @override
  String get bottomNavMap => 'Mapa';

  @override
  String get bottomNavHistory => 'Historial';

  @override
  String get bottomNavTrends => 'Tendencias';

  @override
  String get bottomNavSettings => 'Ajustes';

  @override
  String get guidelinesTitle => 'Reglas de la comunidad';

  @override
  String get guidelinesRespectTitle => 'Sé respetuoso';

  @override
  String get guidelinesRespectSubtitle => 'Trata a todos con buena onda';

  @override
  String get guidelinesNoHarassmentTitle => 'Sin acoso';

  @override
  String get guidelinesNoHarassmentSubtitle =>
      'No envíes mensajes inapropiados';

  @override
  String get guidelinesKeepRealTitle => 'Sé real';

  @override
  String get guidelinesKeepRealSubtitle => 'Comparte solo vibes auténticos';

  @override
  String get guidelinesHaveFunTitle => 'Diviértete';

  @override
  String get guidelinesHaveFunSubtitle => '¡Disfruta las PW chispas!';

  @override
  String get guidelinesViolationWarning =>
      'Las violaciones pueden resultar en restricciones temporales o permanentes';

  @override
  String get guidelinesButtonUnderstand => 'Entendido';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'Día $day - ¡Mantén tu racha!';
  }

  @override
  String get emotionSelectorTapYourVibe => 'TOCA TU VIBE';

  @override
  String get emotionSelectorWhatsYourVibe => '¿cuál es tu vibe ahorita?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count activos ahora';
  }

  @override
  String get miniBarSendNewPing => 'Envía un nuevo ping';

  @override
  String get miniBarPingActive => 'Tu ping está activo';

  @override
  String get moderationBanTitle => 'Ban por 7 min';

  @override
  String get moderationBanSubtitle => 'Restringir temporalmente a este usuario';

  @override
  String get moderationReportTitle => 'Reportar';

  @override
  String get moderationReportSubtitle => 'Reportar comportamiento inadecuado';

  @override
  String get moderationEndChatTitle => 'Terminar chat';

  @override
  String get moderationEndChatSubtitle => 'Salir de esta sesión PW';

  @override
  String get moderationReportDialogTitle => 'Reportar usuario';

  @override
  String get moderationReportReasonHarassment => 'Acoso';

  @override
  String get moderationReportReasonSpam => 'Spam';

  @override
  String get moderationReportReasonHateSpeech => 'Discurso de odio';

  @override
  String get moderationReportReasonOther => 'Otro';

  @override
  String get moderationReportSendButton => 'Enviar reporte';

  @override
  String get pingBottomVibeTooFar => 'Vibe muy lejos (máx 3km)';

  @override
  String get pingBottomVibeTooFarMessage =>
      'Vibe muy lejos - máx 3km para ping';

  @override
  String get pingBottomTooFar => 'MUY LEJOS';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'muy cerca';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get pingBottomTimeNow => 'ahora';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get vibeAnimBrainEnergy => 'MENTE A FULL';

  @override
  String get vibeAnimCozy => 'VIBE: RELAX';

  @override
  String get vibeAnimSweatSlay => 'SUDAR. GANAR. REPETIR';

  @override
  String get vibeAnimLostInBeat => 'PERDIDO EN EL BEAT';

  @override
  String get vibeAnimCityLights => 'LUCES DE LA CIUDAD';

  @override
  String get vibeAnimLightsCameraVibes => 'LUZ. CÁMARA. VIBES.';

  @override
  String get vibeAnimEveningVibes => 'VIBES NOCTURNOS';

  @override
  String get vibeAnimPartyMode => 'MODO: FIESTA';

  @override
  String get vibeAnimSubBrainTime => 'Hora de pensar 🧠';

  @override
  String get vibeAnimSubCaffeine => 'Vibes de cafeína ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'Sin descanso 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'Volumen: MAX 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'Explorador urbano 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'Crear y brillar 📸';

  @override
  String get vibeAnimSubNightFlow => 'Flow nocturno 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'Suelta el caos 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE FIJADO';

  @override
  String get vibeAnimDefaultSubMessage => '¡Vamos!';

  @override
  String get viralShareFailed => 'Falla al compartir';

  @override
  String get viralShareTextNight =>
      'todos duermen. pero algo está pasando\npingandwink.com';

  @override
  String get viralShareTextEvening =>
      'la noche. el mejor momento\npingandwink.com';

  @override
  String get viralShareTextDefault =>
      '¿qué está pasando ahorita?\npingandwink.com';

  @override
  String get viralShareMainText => '¿qué está pasando\nmientras lees esto?';

  @override
  String get viralShareFindOut => 'descubre';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'compartir →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate quiere conectar';

  @override
  String get winkBannerWinkBack => 'WINK DE VUELTA';
}
