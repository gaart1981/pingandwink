// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Sim';

  @override
  String get commonNo => 'Não';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDelete => 'Apagar';

  @override
  String get commonShare => 'Partilhar';

  @override
  String get commonLoading => 'A carregar...';

  @override
  String get commonError => 'Erro';

  @override
  String get commonSuccess => 'Feito';

  @override
  String get commonRetry => 'Tentar outra vez';

  @override
  String get commonNext => 'Seguinte';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonSkip => 'Saltar';

  @override
  String get commonDone => 'Pronto';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get emptyStateMorningStoryMain =>
      'a cidade ainda tá acordando, se espreguiçando devagar\ntodo mundo nos rituais matinais\ncafé, transporte, fingindo trabalhar\nmas o que eles não sabem ainda:\nhoje à noite às 22h, esse mapa se transforma completamente';

  @override
  String get emptyStateMorningStorySub =>
      'bota o alarme agora, agradeça depois ⏰';

  @override
  String get emptyStateMorningCuriosityMain =>
      'você pegou o mapa na fase quieta\ntipo balada ao meio-dia - vazia mas cheia de potencial\n3 pessoas checaram antes de você hoje\ntodas botaram lembretes pras 22h\ncoincidência? ou elas sabem de algo?';

  @override
  String get emptyStateMorningCuriositySub =>
      'a resposta se revela no pôr do sol 🌅';

  @override
  String get emptyStateMorningSocialMain =>
      'verdade da segunda de manhã:\ntodo mundo fingindo trabalhar agora\nplanilhas abertas, mentes em outro lugar\nvocê é 1 de 7 pessoas que checaram antes do meio-dia\nisso te faz especial, ou louco, ou os dois';

  @override
  String get emptyStateMorningSocialSub => 'volta às 22h pra descobrir qual';

  @override
  String emptyStateFridayMain(int hours) {
    return 'paradoxo da sexta à tarde:\ntodo mundo mentalmente desligado mas fisicamente preso\ncontando horas até a liberdade ($hours faltando)\nàs 17h a metamorfose começa\nde zumbis do trabalho pra guerreiros do fim de semana';
  }

  @override
  String get emptyStateFridaySub => 'você chegou cedo pra testemunhar 🦋';

  @override
  String get emptyStateAfternoonReturningMain =>
      'você continua voltando nessa hora\nprocurando algo que não tá aqui... ainda\npersistência ou loucura?\no universo tá observando\ne recompensa paciência';

  @override
  String emptyStateAfternoonReturningSub(int hours) {
    return 'approximately $hours hours until ignition 🚀';
  }

  @override
  String get emptyStateAfternoonFirstMain =>
      'às vezes acontece às 14:47\nàs vezes às 18:13\nmas sempre acontece\na transformação de morto pra vivo\nde vazio pra elétrico';

  @override
  String get emptyStateAfternoonFirstSub =>
      'a pergunta é: você vai estar aqui quando acontecer?';

  @override
  String get emptyStatePrimetimeFirstMain =>
      'bem-vindo à beira de algo grande\nem 23 minutos, esse mapa vazio explode\ncentenas de vibes aparecendo como estrelas\ncada uma uma pessoa real, emoção real, momento real\nvocê tá aqui antes da multidão';

  @override
  String get emptyStatePrimetimeFirstSub => 'isso é genialidade ou sorte ⚡';

  @override
  String get emptyStatePrimetimeReturnMain =>
      'o silêncio pré-jogo antes da tempestade\nvocê sabe o que vem aí\n22h bate diferente nesse mapa\nestresse do trabalho se transforma em energia de fim de semana\nassista acontecer em tempo real';

  @override
  String get emptyStatePrimetimeReturnSub =>
      'ou fecha o app e fica na curiosidade pra sempre';

  @override
  String get emptyStateWeekendEveningMain =>
      'fenômeno de sábado à noite:\ntodo mundo lá fora vivendo sua melhor vida\nou fingindo no instagram\nmas você achou o pulso real da cidade\nemoções sem filtro, sem edição, sem censura';

  @override
  String get emptyStateWeekendEveningSub =>
      'atualiza em 5 minutos pra verdade 🌃';

  @override
  String get emptyStateWeekendMorningMain =>
      'a cidade tá de ressaca\njuntando os pedaços da noite passada devagar\nchecando danos, contando arrependimentos\no mapa dorme até 14h\nmas quando acordar...';

  @override
  String get emptyStateWeekendMorningSub => 'o caos round 2 começa 🎭';

  @override
  String get emptyStateLateNightMain =>
      'clareza das 2 da manhã bate diferente\nquando o barulho para, a verdade emerge\nsó os reais tão acordados agora\ncompartilhando pensamentos das 3 da manhã\ncru, honesto, sem filtro';

  @override
  String get emptyStateLateNightSub => 'você não tá sozinho no escuro 🌙';

  @override
  String get emptyStatePush1Title => 'ping&wink';

  @override
  String get emptyStatePush1Body => 'o mapa tá acordando 👀';

  @override
  String get emptyStatePush2Title => 'ping&wink';

  @override
  String get emptyStatePush2Body => 'vibes no pico agora ⚡';

  @override
  String get emptyStatePush3Title => 'ping&wink';

  @override
  String get emptyStatePush3Body => 'ontem você perdeu 47 vibes. hoje?';

  @override
  String get emptyStateNotificationEnabled =>
      'Notificações ativadas! Você vai saber quando as vibes aparecerem 🔔';

  @override
  String get emptyStateTapToClose => 'toque pra fechar';

  @override
  String emptyStateAfternoonReturningHours(int hours) {
    return 'aproximadamente $hours horas até a ignição 🚀';
  }

  @override
  String get vibeLabelBrainMode => 'Modo Focus';

  @override
  String get vibeLabelLatteBreak => 'Pausa Café';

  @override
  String get vibeLabelSportMode => 'Modo Gym';

  @override
  String get vibeLabelSoundLoop => 'Na Música';

  @override
  String get vibeLabelCityWalk => 'City Walk';

  @override
  String get vibeLabelContentMode => 'A Criar';

  @override
  String get vibeLabelChillNight => 'Noite Chill';

  @override
  String get vibeLabelPartyMode => 'Modo Festa';

  @override
  String get scanYourVibe => 'Fixa o teu vibe ⚡';

  @override
  String get pickYourMood =>
      'Escolhe o teu vibe e vê o que tá a rolar agora 👀';

  @override
  String waitMinutes(int minutes) {
    return 'Espera $minutes min ⏰';
  }

  @override
  String get swipeDownToMap => '↓ Desliza para ver o mapa';

  @override
  String get changeYourMood => 'Mudar o teu mood';

  @override
  String get swipeUp => 'Desliza para cima ↑';

  @override
  String get youAreNotAlone => 'Não estás sozinho!';

  @override
  String get you => 'TU';

  @override
  String get others => 'outros';

  @override
  String get days => 'dias';

  @override
  String streak(int days) {
    return '🔥 Streak: $days dias';
  }

  @override
  String get shareMyVibe => '📤 Partilhar o meu vibe';

  @override
  String get close => 'Fechar';

  @override
  String get happy => 'felizes';

  @override
  String get nearby => 'perto de ti';

  @override
  String get enableLocationSettings => 'Ativa localização nas definições';

  @override
  String get errorTryAgain => 'Erro, tenta outra vez';

  @override
  String get networkError => 'Erro de rede';

  @override
  String get missingConfiguration => 'Falta configuração';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'bué mood $emotion agora mesmo 💭 quem mais? vê aqui -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'O meu vibe no MoodMap! 🌟';

  @override
  String get pingErrorYourVibeExpired => 'O teu vibe expirou, põe um novo';

  @override
  String get pingSentSuccess => 'Ping enviado! ⚡ 60s para um Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'Espera $seconds seg';
  }

  @override
  String get pingSomeoneAlreadySent => 'Alguém já enviou um ping';

  @override
  String get pingPersonInSpark => 'Esta pessoa está num PW chat';

  @override
  String get pingThisVibeExpired => 'Este vibe já expirou';

  @override
  String get pingFailedToSend => 'Não deu para enviar';

  @override
  String get pingSendingError => 'Erro a enviar';

  @override
  String get pingCancelled => 'Ping cancelado';

  @override
  String get pingCancelledBySender => 'Ping cancelado pelo remetente';

  @override
  String get pingErrorConnecting => 'Erro a conectar com PW mate';

  @override
  String get pingErrorStartingChat => 'Erro a iniciar o chat';

  @override
  String get chatTimeNow => 'agora';

  @override
  String chatTimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String chatTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get distanceVeryClose => 'muito perto';

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
  String get birthYearTitle => 'o teu ano de nascimento';

  @override
  String get birthYearPrivacyText => 'privado • nunca mostrado';

  @override
  String get birthYearDefaultGeneration => 'Geração Cool ⭐';

  @override
  String get genLabel2012 => 'Miúdos iPad 📱';

  @override
  String get genLabel2011 => 'OG Minecraft ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'Gen Instagram 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'Miúdos TikTok 🎬';

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
  String get genLabel2000 => 'Miúdos Y2K 🌐';

  @override
  String get genLabel1999 => 'Gen Matrix 💊';

  @override
  String get genLabel1998 => 'Game Boy 🎮';

  @override
  String get genLabel1997 => 'Pokémon 🔴';

  @override
  String get genLabel1996 => 'Miúdos Internet 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'Era Friends ☕';

  @override
  String get genLabel1993 => 'Gen Sonic 💨';

  @override
  String get genLabel1992 => 'Dragon Ball 📺';

  @override
  String get genLabel1991 => 'Super Nintendo 🎮';

  @override
  String get genLabel1990 => 'Gen MTV 🎸';

  @override
  String get genLabel1989 => 'Era Nintendo 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'Miúdos VHS 📼';

  @override
  String get genLabel1986 => 'Gen Arcade 👾';

  @override
  String get genLabel1985 => 'Regresso ao Futuro ⏰';

  @override
  String get genLabel1984 => 'Miúdos Mac 🍎';

  @override
  String get genLabel1983 => 'Star Wars ⚔️';

  @override
  String get genLabel1982 => 'Gen E.T. 👽';

  @override
  String get genLabel1981 => 'Início MTV 📺';

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
  String get genLabel1975 => 'Gen Tubarão 🦈';

  @override
  String get genLabel1974 => 'Início Disco 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'Era Pong 🏓';

  @override
  String get genLabel1971 => 'Zeppelin 🎸';

  @override
  String get genLabel1970 => 'Gen Beatles 🎵';

  @override
  String get genLabel1969 => 'Lendas 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'Histórico';

  @override
  String get historyEmptyTitle => 'Ainda sem emoções';

  @override
  String get historyEmptySubtitle =>
      'Começa a partilhar os teus vibes\npara ver o teu histórico';

  @override
  String get historyMyEmotions => 'As minhas emoções';

  @override
  String get historyStatTotal => 'Total';

  @override
  String get historyStatDominant => 'Dominante';

  @override
  String get historyToday => 'Hoje';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => 'Tendências';

  @override
  String get trendsSubtitle => 'A recolher stats da cidade';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'É o teu próprio vibe';

  @override
  String get mapErrorNeedActiveVibeToPing =>
      'Precisas de um vibe ativo para enviar pings';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'Já tens um ping ativo ou o vibe não está disponível';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'Estás restrito por $time';
  }

  @override
  String get mapBanRestrictionLifted =>
      'Restrição levantada! Podes partilhar vibes outra vez';

  @override
  String mapSuccessVibeSent(int count) {
    return 'Vibe enviado! $count outros perto 🎉';
  }

  @override
  String get mapTutorialTapToSpark => 'toca num vibe • PW chat em 60s';

  @override
  String mapActivePingStatus(int seconds) {
    return 'Ping ativo (${seconds}s) - Toca para cancelar';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin =>
      'vê o que tá a bombar à tua volta agora';

  @override
  String get onboardingButtonLetsGo => 'bora lá';

  @override
  String get onboardingBadgeAge13Plus => 'só 13+';

  @override
  String get onboardingValueTitleInstantSparks => 'PW chat instantâneo';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'conecta em 60 seg';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'vibes hiperlocais';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => 'só 3km de raio';

  @override
  String get onboardingValueTitleNoProfiles => 'sem perfis';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'só momentos reais';

  @override
  String get onboardingButtonImReady => 'tou pronto';

  @override
  String get onboardingLocationTitle => 'desbloqueia a tua zona';

  @override
  String get onboardingLocationSubtitle => 'vê os moods num raio de 3km';

  @override
  String get onboardingLocationPrivacyTitle => 'privacidade primeiro';

  @override
  String get onboardingLocationPrivacyBullet1 => 'só quando a app está aberta';

  @override
  String get onboardingLocationPrivacyBullet2 =>
      'sem tracking em segundo plano';

  @override
  String get onboardingLocationPrivacyBullet3 => 'só vibes anónimos';

  @override
  String get onboardingButtonEnableRadar => 'ativar radar';

  @override
  String get onboardingButtonMaybeLater => 'talvez depois';

  @override
  String get onboardingNotificationTitle => 'não percas nenhum PW chat';

  @override
  String get onboardingNotificationSubtitle =>
      'recebe pings quando tiver movimento perto';

  @override
  String get onboardingNotificationFeature1 => 'pings instantâneos de vibers';

  @override
  String get onboardingNotificationFeature2 => 'lembretes diários de vibe';

  @override
  String get onboardingNotificationFeature3 => 'alertas de zonas hot';

  @override
  String get onboardingButtonTurnOnPings => 'ativar pings';

  @override
  String get onboardingButtonNotNow => 'agora não';

  @override
  String get onboardingLegalTitle => 'quase lá!';

  @override
  String get onboardingLegalAgeRequirement => 'tens de ter 13 anos ou mais';

  @override
  String get onboardingLegalAgeSubtitle => 'ping & wink é para teens e maiores';

  @override
  String get onboardingLegalConsent =>
      'ao continuar, confirmas que tens 13+ e aceitas os nossos';

  @override
  String get onboardingLegalTerms => 'termos';

  @override
  String get onboardingLegalAnd => ' e ';

  @override
  String get onboardingLegalPrivacyPolicy => 'política de privacidade';

  @override
  String get onboardingLegalSafetyFeature1 => 'só vibes anónimos';

  @override
  String get onboardingLegalSafetyFeature2 => 'bloqueio e report instantâneo';

  @override
  String get onboardingLegalSafetyFeature3 =>
      '20 min de timeout por mau comportamento';

  @override
  String get onboardingButtonImAge13AndAgree => 'tenho 13+ e aceito';

  @override
  String get onboardingButtonImUnder13 => 'tenho menos de 13';

  @override
  String get onboardingLocationDeniedTitle => 'vais perder todas as PW faíscas';

  @override
  String get onboardingLocationDeniedMessage =>
      'sem localização não podes:\n• ver quem está perto\n• enviar pings\n• receber winks\n• criar PW conexões';

  @override
  String get onboardingButtonGoBack => 'voltar';

  @override
  String get onboardingButtonExitApp => 'sair';

  @override
  String get onboardingNotificationDeniedTitle => 'vais perder toda a cena';

  @override
  String get onboardingNotificationDeniedMessage =>
      'sem notificações:\n• ninguém pode pingar-te\n• perdes as PW faíscas perto\n• zero conexões possíveis\n\nos nossos users ativam notificações';

  @override
  String get onboardingButtonLetMeReconsider => 'deixa-me pensar';

  @override
  String get onboardingButtonContinueAnyway => 'continuar na mesma';

  @override
  String get onboardingAgeDialogTitle => 'até já!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink é para users de 13 anos ou mais. volta quando cresceres!';

  @override
  String get onboardingButtonUnderstood => 'percebi';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'agora';

  @override
  String get onboardingNotificationExamplePing => 'novo ping a 230m';

  @override
  String get onboardingNotificationExampleMessage => 'alguém vibra contigo';

  @override
  String get onboardingMapNotification => 'alguém se ligou a 753m';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• só quando a app está aberta\n• sem tracking em segundo plano\n• só vibes anónimos';

  @override
  String get onboardingLocationDeniedFormatted =>
      'sem localização não podes:\n• ver quem está perto\n• enviar pings\n• receber winks\n• criar conexões';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'sem notificações:\n• ninguém pode pingar-te\n• perdes os vibes perto\n• zero conexões possíveis\n\nos nossos users ativam notificações';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'Conecta por emoções';

  @override
  String get settingsShareTitle => 'Partilha com amigos';

  @override
  String get settingsShareSubtitle => 'Convida outros a descobrir vibes';

  @override
  String get settingsSectionPreferences => 'Preferências';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionSupport => 'Suporte';

  @override
  String get settingsSectionDataManagement => 'Gestão de dados';

  @override
  String get settingsNotificationsTitle => 'Notificações';

  @override
  String get settingsNotificationsEnabled => 'Ativadas';

  @override
  String get settingsNotificationsDisabled => 'Desativadas';

  @override
  String get settingsMapThemeTitle => 'Tema do mapa';

  @override
  String get settingsMapThemeCyberpunk => 'Cyberpunk';

  @override
  String get settingsMapThemeMinimalist => 'Minimalista';

  @override
  String get settingsLocationModeTitle => 'Modo localização';

  @override
  String get settingsLocationModeSoft => 'Localização desviada, só por estilo';

  @override
  String get settingsLocationModeExact => 'O teu vibe mesmo onde acontece';

  @override
  String get settingsDeleteVibeTitle => 'Apagar o meu vibe';

  @override
  String get settingsDeleteVibeSubtitle => 'Remover a tua emoção do mapa';

  @override
  String get settingsPrivacyTitle => 'Política de privacidade';

  @override
  String get settingsPrivacySubtitle => 'Como protegemos os teus dados';

  @override
  String get settingsTermsTitle => 'Termos de uso';

  @override
  String get settingsTermsSubtitle => 'Regras para usar a app';

  @override
  String get settingsHelpTitle => 'Centro de ajuda';

  @override
  String get settingsHelpSubtitle => 'FAQ e guias';

  @override
  String get settingsContactTitle => 'Contacto';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'Eliminar a minha conta';

  @override
  String get settingsDeleteAccountSubtitle => 'Apagar todos os teus dados';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Só vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'ID dispositivo: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => 'Apagar o teu vibe?';

  @override
  String get settingsDeleteVibeDialogMessage =>
      'A tua emoção será removida do mapa';

  @override
  String get settingsVibeDeletedSuccess => 'O teu vibe foi apagado';

  @override
  String get settingsVibeDeleteError => 'Erro a apagar vibe';

  @override
  String get settingsNotificationWarningTitle => 'Atenção!';

  @override
  String get settingsNotificationWarningMessage =>
      'Se desativares as notificações, não vais poder receber PINGS de outros users.\n\nOs PW chats (conexões) serão impossíveis.\n\nTens a certeza que queres desativar?';

  @override
  String get settingsNotificationWarningCancel => 'Cancelar';

  @override
  String get settingsNotificationWarningDisable => 'Desativar na mesma';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ Notificações desativadas - Não vais receber pings';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ Notificações ativadas - Podes receber pings';

  @override
  String get settingsMapThemeCyberpunkActivated => 'Modo cyberpunk ativado 🌃';

  @override
  String get settingsMapThemeDayActivated => 'Modo dia ativado ☀️';

  @override
  String get settingsSoftModeEnabled =>
      'Modo soft! O teu vibe está desviado 🌊';

  @override
  String get settingsNormalModeEnabled => 'Modo normal! Localização exata 📍';

  @override
  String get settingsIdCopied => 'ID copiado';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ Eliminar conta';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'Esta ação é irreversível. Todas as tuas emoções e dados serão apagados para sempre.\n\nTens a certeza?';

  @override
  String get settingsDeleteAccountDialogDelete => 'Eliminar';

  @override
  String get settingsDeleteAccountError => 'Erro a eliminar conta';

  @override
  String get settingsModerationPanelTitle => '🔍 Painel de moderação';

  @override
  String get settingsModerationPanelSubtitle => 'Só para review da App Store';

  @override
  String get settingsModerationActiveBans => 'Bans ativos';

  @override
  String get settingsModerationReports => 'Reports';

  @override
  String get settingsModerationClearData => 'Limpar dados de teste';

  @override
  String get settingsModerationDataCleared => 'Dados de teste limpos';

  @override
  String get sparkConnectingToChat => 'A conectar ao PW chat...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => 'Terminado';

  @override
  String get sparkSendFirstMessage => 'Envia a primeira mensagem!';

  @override
  String get sparkWaitingForMate => 'À espera do PW mate...';

  @override
  String get sparkMessagePlaceholder => 'Mensagem...';

  @override
  String get sparkWaitForReply => 'Espera resposta...';

  @override
  String get sparkChatEndedPlaceholder => 'Chat terminado';

  @override
  String get sparkLeaveChat => 'Sair do PW chat?';

  @override
  String get sparkChatEndForBoth => 'O chat termina para ambos PW mates';

  @override
  String get sparkStay => 'Ficar';

  @override
  String get sparkLeave => 'Sair';

  @override
  String get sparkExtended => 'Extendido! +3 min ⚡';

  @override
  String get sparkWaitingForOther => 'À espera do PW mate...';

  @override
  String get sparkMaxExtensionsReached => 'Máximo de extensões alcançado';

  @override
  String get sparkFailedToExtend => 'Falha a estender';

  @override
  String get sparkFailedToSend => 'Falha a enviar';

  @override
  String get sparkMessageTooLong => 'Mensagem muito longa (máx 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'Erro a iniciar chat: $error';
  }

  @override
  String get sparkUserBanned => 'User banido por 7 minutos';

  @override
  String get sparkRestrictedForBanning => 'Foste restrito por banir em excesso';

  @override
  String get sparkReportSubmitted => 'Report enviado';

  @override
  String get sparkBehaviorRestriction =>
      'Foste restrito por comportamento inapropriado';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'ACENDE O MOMENTO';

  @override
  String trendsEmotionalPulse(String time) {
    return 'Pulso emocional $time';
  }

  @override
  String get trendsTimeMorning => 'esta manhã';

  @override
  String get trendsTimeAfternoon => 'esta tarde';

  @override
  String get trendsTimeEvening => 'esta noite';

  @override
  String get trendsTimeLateNight => 'madrugada';

  @override
  String get trendsActiveVibes => 'Vibes ativos';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => 'Emoção dominante';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% de PW mates';
  }

  @override
  String get trendsEmotionDistribution => 'Distribuição de emoções';

  @override
  String get trendsQuote1 => 'Cada emoção partilhada cria uma conexão ✨';

  @override
  String get trendsQuote2 => 'Juntos criamos o mapa de emoções 🗺️';

  @override
  String get trendsQuote3 => 'O teu vibe pode mudar o dia de alguém 💫';

  @override
  String get trendsQuote4 => 'Os PW chats começam com um simples ping ⚡';

  @override
  String get banOverlayTitle => 'Restrição temporária';

  @override
  String get banOverlayMessage =>
      'O teu PW mate achou a tua mensagem inapropriada';

  @override
  String get banOverlayRestrictionInfo =>
      'Não podes partilhar vibes durante este tempo';

  @override
  String get bottomNavMap => 'Mapa';

  @override
  String get bottomNavHistory => 'Histórico';

  @override
  String get bottomNavTrends => 'Tendências';

  @override
  String get bottomNavSettings => 'Definições';

  @override
  String get guidelinesTitle => 'Regras da comunidade';

  @override
  String get guidelinesRespectTitle => 'Sê respeitoso';

  @override
  String get guidelinesRespectSubtitle => 'Trata todos com boa onda';

  @override
  String get guidelinesNoHarassmentTitle => 'Sem assédio';

  @override
  String get guidelinesNoHarassmentSubtitle =>
      'Não envies mensagens inapropriadas';

  @override
  String get guidelinesKeepRealTitle => 'Sê real';

  @override
  String get guidelinesKeepRealSubtitle => 'Partilha só vibes genuínos';

  @override
  String get guidelinesHaveFunTitle => 'Diverte-te';

  @override
  String get guidelinesHaveFunSubtitle => 'Curte as PW conexões!';

  @override
  String get guidelinesViolationWarning =>
      'Violações podem resultar em restrições temporárias ou permanentes';

  @override
  String get guidelinesButtonUnderstand => 'Percebi';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'Dia $day - Mantém a tua streak!';
  }

  @override
  String get emotionSelectorTapYourVibe => 'TOCA NO TEU VIBE';

  @override
  String get emotionSelectorWhatsYourVibe => 'qual é o teu vibe agora?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count ativos agora';
  }

  @override
  String get miniBarSendNewPing => 'Envia um novo ping';

  @override
  String get miniBarPingActive => 'O teu ping está ativo';

  @override
  String get moderationBanTitle => 'Ban por 7 min';

  @override
  String get moderationBanSubtitle => 'Restringir temporariamente este user';

  @override
  String get moderationReportTitle => 'Reportar';

  @override
  String get moderationReportSubtitle => 'Reportar comportamento inapropriado';

  @override
  String get moderationEndChatTitle => 'Terminar chat';

  @override
  String get moderationEndChatSubtitle => 'Sair desta sessão PW';

  @override
  String get moderationReportDialogTitle => 'Reportar user';

  @override
  String get moderationReportReasonHarassment => 'Assédio';

  @override
  String get moderationReportReasonSpam => 'Spam';

  @override
  String get moderationReportReasonHateSpeech => 'Discurso de ódio';

  @override
  String get moderationReportReasonOther => 'Outro';

  @override
  String get moderationReportSendButton => 'Enviar report';

  @override
  String get pingBottomVibeTooFar => 'Vibe muito longe (máx 3km)';

  @override
  String get pingBottomVibeTooFarMessage =>
      'Vibe muito longe - máx 3km para ping';

  @override
  String get pingBottomTooFar => 'MUITO LONGE';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'muito perto';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get pingBottomTimeNow => 'agora';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get vibeAnimBrainEnergy => 'CABEÇA A MIL';

  @override
  String get vibeAnimCozy => 'VIBE: RELAX';

  @override
  String get vibeAnimSweatSlay => 'SUAR. ARRASAR. REPETIR';

  @override
  String get vibeAnimLostInBeat => 'PERDIDO NO BEAT';

  @override
  String get vibeAnimCityLights => 'LUZES DA CIDADE';

  @override
  String get vibeAnimLightsCameraVibes => 'LUZ. CÂMARA. VIBES.';

  @override
  String get vibeAnimEveningVibes => 'VIBES NOTURNOS';

  @override
  String get vibeAnimPartyMode => 'MODO: FESTA';

  @override
  String get vibeAnimSubBrainTime => 'Hora de pensar 🧠';

  @override
  String get vibeAnimSubCaffeine => 'Vibes de cafeína ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'Sem descanso 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'Volume: MAX 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'Explorador urbano 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'Criar e brilhar 📸';

  @override
  String get vibeAnimSubNightFlow => 'Flow noturno 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'Liberta o caos 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE FIXADO';

  @override
  String get vibeAnimDefaultSubMessage => 'Bora!';

  @override
  String get viralShareFailed => 'Falha a partilhar';

  @override
  String get viralShareTextNight =>
      'todos dormem. mas algo está a acontecer\npingandwink.com';

  @override
  String get viralShareTextEvening =>
      'a noite. a melhor altura\npingandwink.com';

  @override
  String get viralShareTextDefault =>
      'o que está a acontecer agora mesmo?\npingandwink.com';

  @override
  String get viralShareMainText => 'o que está a acontecer\nenquanto lês isto?';

  @override
  String get viralShareFindOut => 'descobre';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'partilhar →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate quer conectar';

  @override
  String get winkBannerWinkBack => 'WINK BACK';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Sim';

  @override
  String get commonNo => 'Não';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonDelete => 'Apagar';

  @override
  String get commonShare => 'Compartilhar';

  @override
  String get commonLoading => 'Carregando...';

  @override
  String get commonError => 'Erro';

  @override
  String get commonSuccess => 'Pronto';

  @override
  String get commonRetry => 'Tentar de novo';

  @override
  String get commonNext => 'Próximo';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonDone => 'Feito';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get emptyStateMorningStoryMain =>
      'a cidade ainda tá despertando, se espreguiçando devagar\ntodo mundo nos seus rituais matinais\ncafézinho, busão lotado, fingindo trampar\nmas eles ainda não sacaram:\nhoje à noite às 10h, esse mapa vira outra coisa completamente';

  @override
  String get emptyStateMorningStorySub =>
      'bota o lembrete agora, vai agradecer depois ⏰';

  @override
  String get emptyStateMorningCuriosityMain =>
      'você pegou o mapa na fase tranquila\ntipo balada ao meio-dia - vazia mas cheia de potencial\n3 manos checaram antes de você hoje\ntodos botaram lembrete pras 22h\ncoincidência? ou eles manjam de algo?';

  @override
  String get emptyStateMorningCuriositySub =>
      'a resposta se revela no pôr do sol 🌅';

  @override
  String get emptyStateMorningSocialMain =>
      'real da segunda de manhã:\ngeral fingindo que tá trabalhando agora\nplanilhas abertas, cabeça em outro lugar\nvocê é 1 de 7 que checou antes do almoço\nisso te faz especial, ou doido, ou os dois';

  @override
  String get emptyStateMorningSocialSub => 'cola às 22h pra descobrir qual';

  @override
  String emptyStateFridayMain(int hours) {
    return 'paradoxo da sexta à tarde:\ngeral já desligou mentalmente mas tá preso fisicamente\ncontando as horas pra liberdade ($hours faltando)\nàs 17h começa a metamorfose\nde zumbis corporativos pra guerreiros do rolê';
  }

  @override
  String get emptyStateFridaySub => 'chegou cedo pra testemunhar a parada 🦋';

  @override
  String get emptyStateAfternoonReturningMain =>
      'você sempre volta nesse horário\nprocurando algo que ainda não tá aqui... ainda\nteimosia ou loucura?\no universo tá ligado\ne recompensa quem tem paciência';

  @override
  String emptyStateAfternoonReturningSub(int hours) {
    return 'mais ou menos $hours horas até bombar 🚀';
  }

  @override
  String get emptyStateAfternoonFirstMain =>
      'às vezes rola às 14:47\nàs vezes às 18:13\nmas sempre acontece\na transformação de morto pra vivo\nde vazio pra elétrico';

  @override
  String get emptyStateAfternoonFirstSub =>
      'a pergunta é: você vai estar aqui quando rolar?';

  @override
  String get emptyStatePrimetimeFirstMain =>
      'bem-vindo à beira de algo massa\nem 23 minutos, esse mapa vazio explode\ncentenas de vibes aparecem tipo estrelas\ncada uma é alguém real, emoção real, momento real\nvocê chegou antes da galera';

  @override
  String get emptyStatePrimetimeFirstSub => 'isso é genialidade ou sorte ⚡';

  @override
  String get emptyStatePrimetimeReturnMain =>
      'o silêncio antes do caos\nvocê sabe o que vem aí\n22h bate diferente nesse mapa\nestresse do trampo vira energia de sexta\nassista acontecer ao vivo';

  @override
  String get emptyStatePrimetimeReturnSub =>
      'ou fecha o app e fica na neura pra sempre';

  @override
  String get emptyStateWeekendEveningMain =>
      'fenômeno de sábado à noite:\ngeral lá fora vivendo sua melhor vida\nou fingindo no stories\nmas você achou o pulso real da cidade\nemoções sem filtro, sem edição, sem censura';

  @override
  String get emptyStateWeekendEveningSub => 'atualiza em 5 minutos pra real 🌃';

  @override
  String get emptyStateWeekendMorningMain =>
      'a cidade tá de ressaca\njuntando os cacos da noite passada\nchecando os estragos, contando os arrependimentos\no mapa dorme até 14h\nmas quando acorda...';

  @override
  String get emptyStateWeekendMorningSub => 'o caos round 2 começa 🎭';

  @override
  String get emptyStateLateNightMain =>
      'clareza das 3 da manhã bate diferente\nquando o barulho para, a verdade aparece\nsó os reais tão acordados agora\ncompartilhando pensamentos das 3am\ncru, honesto, sem filtro';

  @override
  String get emptyStateLateNightSub => 'você não tá sozinho na madruga 🌙';

  @override
  String get emptyStatePush1Title => 'ping&wink';

  @override
  String get emptyStatePush1Body => 'o mapa tá acordando 👀';

  @override
  String get emptyStatePush2Title => 'ping&wink';

  @override
  String get emptyStatePush2Body => 'vibes no pico agora ⚡';

  @override
  String get emptyStatePush3Title => 'ping&wink';

  @override
  String get emptyStatePush3Body => 'ontem você perdeu 47 vibes. hoje?';

  @override
  String get emptyStateNotificationEnabled =>
      'Notificações ativadas! Você vai saber quando as vibes aparecerem 🔔';

  @override
  String get emptyStateTapToClose => 'toque pra fechar';

  @override
  String emptyStateAfternoonReturningHours(int hours) {
    return 'mais ou menos $hours horas até bombar 🚀';
  }

  @override
  String get vibeLabelBrainMode => 'Modo Foco';

  @override
  String get vibeLabelLatteBreak => 'Pausa Café';

  @override
  String get vibeLabelSportMode => 'Modo Treino';

  @override
  String get vibeLabelSoundLoop => 'No Som';

  @override
  String get vibeLabelCityWalk => 'Rolê';

  @override
  String get vibeLabelContentMode => 'Criando';

  @override
  String get vibeLabelChillNight => 'Noite Suave';

  @override
  String get vibeLabelPartyMode => 'Modo Festa';

  @override
  String get scanYourVibe => 'Marca teu vibe ⚡';

  @override
  String get pickYourMood => 'Escolhe teu mood e vê o que tá rolando agora 👀';

  @override
  String waitMinutes(int minutes) {
    return 'Espera $minutes min ⏰';
  }

  @override
  String get swipeDownToMap => '↓ Arrasta pra baixo pro mapa';

  @override
  String get changeYourMood => 'Mudar teu mood';

  @override
  String get swipeUp => 'Arrasta pra cima ↑';

  @override
  String get youAreNotAlone => 'Você não tá sozinho!';

  @override
  String get you => 'VOCÊ';

  @override
  String get others => 'outros';

  @override
  String get days => 'dias';

  @override
  String streak(int days) {
    return '🔥 Sequência: $days dias';
  }

  @override
  String get shareMyVibe => '📤 Compartilhar meu vibe';

  @override
  String get close => 'Fechar';

  @override
  String get happy => 'na vibe';

  @override
  String get nearby => 'perto de você';

  @override
  String get enableLocationSettings => 'Ativa a localização nas configs';

  @override
  String get errorTryAgain => 'Erro, tenta de novo';

  @override
  String get networkError => 'Problema na rede';

  @override
  String get missingConfiguration => 'Faltou configuração';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'meu mood $emotion agora 💭 quem mais? olha -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'Meu vibe no MoodMap! 🌟';

  @override
  String get pingErrorYourVibeExpired => 'Seu vibe expirou, coloca um novo';

  @override
  String get pingSentSuccess => 'Ping enviado! ⚡ 60s pra um Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'Espera $seconds seg';
  }

  @override
  String get pingSomeoneAlreadySent => 'Alguém já mandou ping';

  @override
  String get pingPersonInSpark => 'Essa pessoa já tá no PW chat';

  @override
  String get pingThisVibeExpired => 'Esse vibe já era';

  @override
  String get pingFailedToSend => 'Não conseguiu enviar';

  @override
  String get pingSendingError => 'Erro no envio';

  @override
  String get pingCancelled => 'Ping cancelado';

  @override
  String get pingCancelledBySender => 'Ping cancelado por quem mandou';

  @override
  String get pingErrorConnecting => 'Erro conectando com o PW mate';

  @override
  String get pingErrorStartingChat => 'Erro iniciando o chat';

  @override
  String get chatTimeNow => 'agora';

  @override
  String chatTimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String chatTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get distanceVeryClose => 'pertinho';

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
  String get birthYearTitle => 'teu ano de nascimento';

  @override
  String get birthYearPrivacyText => 'privado • ninguém vê';

  @override
  String get birthYearDefaultGeneration => 'Geração Top ⭐';

  @override
  String get genLabel2012 => 'Crianças iPad 📱';

  @override
  String get genLabel2011 => 'OG Minecraft ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'Geração Instagram 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'Crianças TikTok 🎬';

  @override
  String get genLabel2006 => 'Geração YouTube 🎮';

  @override
  String get genLabel2005 => 'Era Orkut 👍';

  @override
  String get genLabel2004 => 'Snapchat 👻';

  @override
  String get genLabel2003 => 'Era MSN 💬';

  @override
  String get genLabel2002 => 'Geração iPod 🎧';

  @override
  String get genLabel2001 => 'Harry Potter ⚡';

  @override
  String get genLabel2000 => 'Crianças Y2K 🌐';

  @override
  String get genLabel1999 => 'Geração Matrix 💊';

  @override
  String get genLabel1998 => 'Game Boy 🎮';

  @override
  String get genLabel1997 => 'Pokémon 🔴';

  @override
  String get genLabel1996 => 'Crianças Internet Discada 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'Era Friends ☕';

  @override
  String get genLabel1993 => 'Geração Sonic 💨';

  @override
  String get genLabel1992 => 'Cavaleiros do Zodíaco 📺';

  @override
  String get genLabel1991 => 'Super Nintendo 🎮';

  @override
  String get genLabel1990 => 'Geração MTV 🎸';

  @override
  String get genLabel1989 => 'Era Master System 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'Crianças VHS 📼';

  @override
  String get genLabel1986 => 'Geração Arcade 👾';

  @override
  String get genLabel1985 => 'De Volta pro Futuro ⏰';

  @override
  String get genLabel1984 => 'Crianças Mac 🍎';

  @override
  String get genLabel1983 => 'Star Wars ⚔️';

  @override
  String get genLabel1982 => 'Geração E.T. 👽';

  @override
  String get genLabel1981 => 'Início MTV 📺';

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
  String get genLabel1975 => 'Geração Tubarão 🦈';

  @override
  String get genLabel1974 => 'Início Disco 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'Era Pong 🏓';

  @override
  String get genLabel1971 => 'Zeppelin 🎸';

  @override
  String get genLabel1970 => 'Geração Beatles 🎵';

  @override
  String get genLabel1969 => 'Lendas 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'Histórico';

  @override
  String get historyEmptyTitle => 'Sem emoções ainda';

  @override
  String get historyEmptySubtitle =>
      'Começa a compartilhar teus vibes\npra ver teu histórico';

  @override
  String get historyMyEmotions => 'Minhas emoções';

  @override
  String get historyStatTotal => 'Total';

  @override
  String get historyStatDominant => 'Dominante';

  @override
  String get historyToday => 'Hoje';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => 'Tendências';

  @override
  String get trendsSubtitle => 'Chegando as stats da cidade';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'É teu próprio vibe';

  @override
  String get mapErrorNeedActiveVibeToPing =>
      'Precisa de um vibe ativo pra mandar ping';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'Já tem um ping ativo ou o vibe não tá disponível';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'Você tá restrito por $time';
  }

  @override
  String get mapBanRestrictionLifted =>
      'Restrição liberada! Pode compartilhar vibes de novo';

  @override
  String mapSuccessVibeSent(int count) {
    return 'Vibe enviado! $count outros por perto 🎉';
  }

  @override
  String get mapTutorialTapToSpark => 'toca num vibe • PW chat em 60s';

  @override
  String mapActivePingStatus(int seconds) {
    return 'Ping ativo (${seconds}s) - Toca pra cancelar';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin =>
      'vê o que tá rolando perto agora';

  @override
  String get onboardingButtonLetsGo => 'bora';

  @override
  String get onboardingBadgeAge13Plus => 'só 13+';

  @override
  String get onboardingValueTitleInstantSparks => 'PW chat na hora';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'conecta em 60 seg';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'vibes hiperlocais';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => 'só 2km de raio';

  @override
  String get onboardingValueTitleNoProfiles => 'sem perfis';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'só momentos reais';

  @override
  String get onboardingButtonImReady => 'tô pronto';

  @override
  String get onboardingLocationTitle => 'libera tua área';

  @override
  String get onboardingLocationSubtitle => 'vê os vibes num raio de 2km';

  @override
  String get onboardingLocationPrivacyTitle => 'privacidade primeiro';

  @override
  String get onboardingLocationPrivacyBullet1 => 'só quando o app tá aberto';

  @override
  String get onboardingLocationPrivacyBullet2 =>
      'sem rastreamento em background';

  @override
  String get onboardingLocationPrivacyBullet3 => 'só vibes anônimos';

  @override
  String get onboardingButtonEnableRadar => 'ativar radar';

  @override
  String get onboardingButtonMaybeLater => 'talvez depois';

  @override
  String get onboardingNotificationTitle => 'nunca perde um PW chat';

  @override
  String get onboardingNotificationSubtitle =>
      'recebe pings quando tiver movimento perto';

  @override
  String get onboardingNotificationFeature1 => 'pings instantâneos dos vibers';

  @override
  String get onboardingNotificationFeature2 => 'lembretes diários de vibe';

  @override
  String get onboardingNotificationFeature3 => 'alertas de zonas quentes';

  @override
  String get onboardingButtonTurnOnPings => 'ativar pings';

  @override
  String get onboardingButtonNotNow => 'agora não';

  @override
  String get onboardingLegalTitle => 'quase lá!';

  @override
  String get onboardingLegalAgeRequirement =>
      'você precisa ter 13 anos ou mais';

  @override
  String get onboardingLegalAgeSubtitle => 'ping & wink é pra teens e adultos';

  @override
  String get onboardingLegalConsent =>
      'continuando, você confirma ter 13+ e aceita nossos';

  @override
  String get onboardingLegalTerms => 'termos';

  @override
  String get onboardingLegalAnd => ' e ';

  @override
  String get onboardingLegalPrivacyPolicy => 'política de privacidade';

  @override
  String get onboardingLegalSafetyFeature1 => 'só vibes anônimos';

  @override
  String get onboardingLegalSafetyFeature2 =>
      'bloqueio e denúncia instantâneos';

  @override
  String get onboardingLegalSafetyFeature3 =>
      'timeout de 20 min por mal comportamento';

  @override
  String get onboardingButtonImAge13AndAgree => 'tenho 13+ e aceito';

  @override
  String get onboardingButtonImUnder13 => 'tenho menos de 13';

  @override
  String get onboardingLocationDeniedTitle => 'vai perder todas as PW faíscas';

  @override
  String get onboardingLocationDeniedMessage =>
      'sem localização você não pode:\n• ver quem tá perto\n• mandar pings\n• receber winks\n• criar PW faíscas';

  @override
  String get onboardingButtonGoBack => 'voltar';

  @override
  String get onboardingButtonExitApp => 'sair';

  @override
  String get onboardingNotificationDeniedTitle => 'vai perder tudo';

  @override
  String get onboardingNotificationDeniedMessage =>
      'sem notificação:\n• ninguém pode te pingar\n• perde as PW faíscas perto\n• zero conexões\n\nnossos users ativam notificações';

  @override
  String get onboardingButtonLetMeReconsider => 'deixa eu pensar';

  @override
  String get onboardingButtonContinueAnyway => 'continuar mesmo assim';

  @override
  String get onboardingAgeDialogTitle => 'até mais!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink é pra usuários de 13 anos ou mais. volta quando crescer!';

  @override
  String get onboardingButtonUnderstood => 'entendi';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'agora';

  @override
  String get onboardingNotificationExamplePing => 'novo ping a 230m';

  @override
  String get onboardingNotificationExampleMessage => 'alguém tá na tua vibe';

  @override
  String get onboardingMapNotification => 'alguém acendeu a 753m';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• só quando o app tá aberto\n• sem rastreamento em background\n• só vibes anônimos';

  @override
  String get onboardingLocationDeniedFormatted =>
      'sem localização você não pode:\n• ver quem tá perto\n• mandar pings\n• receber winks\n• criar faíscas';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'sem notificação:\n• ninguém pode te pingar\n• perde os vibes perto\n• zero conexões\n\nnossos users ativam notificações';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'Conecta por emoções';

  @override
  String get settingsShareTitle => 'Compartilha com os manos';

  @override
  String get settingsShareSubtitle => 'Chama a galera pra descobrir os vibes';

  @override
  String get settingsSectionPreferences => 'Preferências';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionSupport => 'Suporte';

  @override
  String get settingsSectionDataManagement => 'Gestão de dados';

  @override
  String get settingsNotificationsTitle => 'Notificações';

  @override
  String get settingsNotificationsEnabled => 'Ativadas';

  @override
  String get settingsNotificationsDisabled => 'Desativadas';

  @override
  String get settingsMapThemeTitle => 'Tema do mapa';

  @override
  String get settingsMapThemeCyberpunk => 'Cyberpunk';

  @override
  String get settingsMapThemeMinimalist => 'Minimalista';

  @override
  String get settingsLocationModeTitle => 'Modo localização';

  @override
  String get settingsLocationModeSoft => 'Localização deslocada, só pelo style';

  @override
  String get settingsLocationModeExact => 'Teu vibe exatamente onde você tá';

  @override
  String get settingsDeleteVibeTitle => 'Apagar meu vibe';

  @override
  String get settingsDeleteVibeSubtitle => 'Tirar tua emoção do mapa';

  @override
  String get settingsPrivacyTitle => 'Política de privacidade';

  @override
  String get settingsPrivacySubtitle => 'Como protegemos teus dados';

  @override
  String get settingsTermsTitle => 'Termos de uso';

  @override
  String get settingsTermsSubtitle => 'Regras pra usar o app';

  @override
  String get settingsHelpTitle => 'Central de ajuda';

  @override
  String get settingsHelpSubtitle => 'FAQ e guias';

  @override
  String get settingsContactTitle => 'Contato';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'Deletar minha conta';

  @override
  String get settingsDeleteAccountSubtitle => 'Apagar todos os teus dados';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Só vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'ID do dispositivo: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => 'Apagar teu vibe?';

  @override
  String get settingsDeleteVibeDialogMessage => 'Tua emoção vai sumir do mapa';

  @override
  String get settingsVibeDeletedSuccess => 'Teu vibe foi apagado';

  @override
  String get settingsVibeDeleteError => 'Erro apagando vibe';

  @override
  String get settingsNotificationWarningTitle => 'Atenção!';

  @override
  String get settingsNotificationWarningMessage =>
      'Se desativar as notificações, não vai poder receber PINGS de outros.\n\nOs PW chats (conexões) vão ficar impossíveis.\n\nQuer desativar mesmo?';

  @override
  String get settingsNotificationWarningCancel => 'Cancelar';

  @override
  String get settingsNotificationWarningDisable => 'Desativar mesmo assim';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ Notificações desativadas - Não vai receber nenhum ping';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ Notificações ativadas - Pode receber pings';

  @override
  String get settingsMapThemeCyberpunkActivated => 'Modo cyberpunk ativado 🌃';

  @override
  String get settingsMapThemeDayActivated => 'Modo dia ativado ☀️';

  @override
  String get settingsSoftModeEnabled => 'Modo soft! Teu vibe tá deslocado 🌊';

  @override
  String get settingsNormalModeEnabled => 'Modo normal! Localização exata 📍';

  @override
  String get settingsIdCopied => 'ID copiado';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ Deletar conta';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'Essa ação é irreversível. Todas as tuas emoções e dados vão ser apagados pra sempre.\n\nCerteza?';

  @override
  String get settingsDeleteAccountDialogDelete => 'Deletar';

  @override
  String get settingsDeleteAccountError => 'Erro deletando conta';

  @override
  String get settingsModerationPanelTitle => '🔍 Painel de moderação';

  @override
  String get settingsModerationPanelSubtitle => 'Só pra review da App Store';

  @override
  String get settingsModerationActiveBans => 'Bans ativos';

  @override
  String get settingsModerationReports => 'Denúncias';

  @override
  String get settingsModerationClearData => 'Limpar dados de teste';

  @override
  String get settingsModerationDataCleared => 'Dados de teste limpos';

  @override
  String get sparkConnectingToChat => 'Conectando ao PW chat...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => 'Acabou';

  @override
  String get sparkSendFirstMessage => 'Manda a primeira mensagem!';

  @override
  String get sparkWaitingForMate => 'Esperando o PW mate...';

  @override
  String get sparkMessagePlaceholder => 'Mensagem...';

  @override
  String get sparkWaitForReply => 'Espera a resposta...';

  @override
  String get sparkChatEndedPlaceholder => 'Chat acabou';

  @override
  String get sparkLeaveChat => 'Sair do PW chat?';

  @override
  String get sparkChatEndForBoth => 'O chat acaba pros dois PW mates';

  @override
  String get sparkStay => 'Ficar';

  @override
  String get sparkLeave => 'Sair';

  @override
  String get sparkExtended => 'Estendido! +3 min ⚡';

  @override
  String get sparkWaitingForOther => 'Esperando o PW mate...';

  @override
  String get sparkMaxExtensionsReached => 'Máximo de extensões atingido';

  @override
  String get sparkFailedToExtend => 'Falha ao estender';

  @override
  String get sparkFailedToSend => 'Falha ao enviar';

  @override
  String get sparkMessageTooLong => 'Mensagem muito longa (máx 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'Erro iniciando chat: $error';
  }

  @override
  String get sparkUserBanned => 'Usuário banido por 7 minutos';

  @override
  String get sparkRestrictedForBanning => 'Você tá restrito por banir demais';

  @override
  String get sparkReportSubmitted => 'Denúncia enviada';

  @override
  String get sparkBehaviorRestriction =>
      'Você tá restrito por comportamento inadequado';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'ACENDE O MOMENTO';

  @override
  String trendsEmotionalPulse(String time) {
    return 'Pulso emocional $time';
  }

  @override
  String get trendsTimeMorning => 'de manhã';

  @override
  String get trendsTimeAfternoon => 'à tarde';

  @override
  String get trendsTimeEvening => 'à noite';

  @override
  String get trendsTimeLateNight => 'de madrugada';

  @override
  String get trendsActiveVibes => 'Vibes ativos';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => 'Emoção dominante';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% dos PW mates';
  }

  @override
  String get trendsEmotionDistribution => 'Distribuição das emoções';

  @override
  String get trendsQuote1 => 'Cada emoção compartilhada cria uma conexão ✨';

  @override
  String get trendsQuote2 => 'Juntos criamos o mapa de emoções 🗺️';

  @override
  String get trendsQuote3 => 'Teu vibe pode mudar o dia de alguém 💫';

  @override
  String get trendsQuote4 => 'PW chats começam com um simples ping ⚡';

  @override
  String get banOverlayTitle => 'Restrição temporária';

  @override
  String get banOverlayMessage => 'Teu PW mate achou tua mensagem inadequada';

  @override
  String get banOverlayRestrictionInfo =>
      'Não pode compartilhar vibes durante esse tempo';

  @override
  String get bottomNavMap => 'Mapa';

  @override
  String get bottomNavHistory => 'Histórico';

  @override
  String get bottomNavTrends => 'Tendências';

  @override
  String get bottomNavSettings => 'Configs';

  @override
  String get guidelinesTitle => 'Regras da comunidade';

  @override
  String get guidelinesRespectTitle => 'Seja respeitoso';

  @override
  String get guidelinesRespectSubtitle => 'Trata todo mundo numa boa';

  @override
  String get guidelinesNoHarassmentTitle => 'Sem assédio';

  @override
  String get guidelinesNoHarassmentSubtitle =>
      'Não manda mensagens inadequadas';

  @override
  String get guidelinesKeepRealTitle => 'Seja real';

  @override
  String get guidelinesKeepRealSubtitle => 'Compartilha só vibes autênticos';

  @override
  String get guidelinesHaveFunTitle => 'Se divirta';

  @override
  String get guidelinesHaveFunSubtitle => 'Curte as PW faíscas!';

  @override
  String get guidelinesViolationWarning =>
      'Violações podem resultar em restrições temporárias ou permanentes';

  @override
  String get guidelinesButtonUnderstand => 'Entendi';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'Dia $day - Mantém a sequência!';
  }

  @override
  String get emotionSelectorTapYourVibe => 'TOCA TEU VIBE';

  @override
  String get emotionSelectorWhatsYourVibe => 'qual é teu vibe agora?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count ativos agora';
  }

  @override
  String get miniBarSendNewPing => 'Manda um novo ping';

  @override
  String get miniBarPingActive => 'Teu ping tá ativo';

  @override
  String get moderationBanTitle => 'Ban por 7 min';

  @override
  String get moderationBanSubtitle => 'Restringir temporariamente esse user';

  @override
  String get moderationReportTitle => 'Denunciar';

  @override
  String get moderationReportSubtitle => 'Denunciar comportamento inadequado';

  @override
  String get moderationEndChatTitle => 'Terminar chat';

  @override
  String get moderationEndChatSubtitle => 'Sair dessa sessão PW';

  @override
  String get moderationReportDialogTitle => 'Denunciar usuário';

  @override
  String get moderationReportReasonHarassment => 'Assédio';

  @override
  String get moderationReportReasonSpam => 'Spam';

  @override
  String get moderationReportReasonHateSpeech => 'Discurso de ódio';

  @override
  String get moderationReportReasonOther => 'Outro';

  @override
  String get moderationReportSendButton => 'Enviar denúncia';

  @override
  String get pingBottomVibeTooFar => 'Vibe muito longe (máx 3km)';

  @override
  String get pingBottomVibeTooFarMessage =>
      'Vibe muito longe - máx 3km pra ping';

  @override
  String get pingBottomTooFar => 'MUITO LONGE';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'pertinho';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get pingBottomTimeNow => 'agora';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '${hours}h';
  }

  @override
  String get vibeAnimBrainEnergy => 'CÉREBRO FRITANDO';

  @override
  String get vibeAnimCozy => 'VIBE: RELAX';

  @override
  String get vibeAnimSweatSlay => 'SUAR. VENCER. REPETIR';

  @override
  String get vibeAnimLostInBeat => 'PERDIDO NO BEAT';

  @override
  String get vibeAnimCityLights => 'LUZES DA CIDADE';

  @override
  String get vibeAnimLightsCameraVibes => 'LUZ. CÂMERA. VIBES.';

  @override
  String get vibeAnimEveningVibes => 'VIBES NOTURNAS';

  @override
  String get vibeAnimPartyMode => 'MODO: FESTA';

  @override
  String get vibeAnimSubBrainTime => 'Hora de pensar 🧠';

  @override
  String get vibeAnimSubCaffeine => 'Vibes de cafeína ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'Sem folga 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'Volume: MÁXIMO 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'Explorador urbano 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'Criar e brilhar 📸';

  @override
  String get vibeAnimSubNightFlow => 'Flow noturno 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'Solta o caos 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE MARCADO';

  @override
  String get vibeAnimDefaultSubMessage => 'Bora!';

  @override
  String get viralShareFailed => 'Falha ao compartilhar';

  @override
  String get viralShareTextNight =>
      'todo mundo dormindo. mas algo tá rolando\npingandwink.com';

  @override
  String get viralShareTextEvening =>
      'a noite. o melhor momento\npingandwink.com';

  @override
  String get viralShareTextDefault =>
      'o que tá rolando agora?\npingandwink.com';

  @override
  String get viralShareMainText => 'o que tá rolando\nenquanto você lê isso?';

  @override
  String get viralShareFindOut => 'descobre';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'compartilhar →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate quer conectar';

  @override
  String get winkBannerWinkBack => 'WINK DE VOLTA';
}
