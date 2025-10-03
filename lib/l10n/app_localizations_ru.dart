// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonOk => 'ОК';

  @override
  String get commonYes => 'Да';

  @override
  String get commonNo => 'Нет';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonShare => 'Поделиться';

  @override
  String get commonLoading => 'Загрузка...';

  @override
  String get commonError => 'Ошибка';

  @override
  String get commonSuccess => 'Готово';

  @override
  String get commonRetry => 'Ещё раз';

  @override
  String get commonNext => 'Далее';

  @override
  String get commonBack => 'Назад';

  @override
  String get commonSkip => 'Пропустить';

  @override
  String get commonDone => 'Готово';

  @override
  String get commonContinue => 'Продолжить';

  @override
  String get commonConfirm => 'Подтвердить';

  @override
  String get chatBlockedMessage =>
      'Cannot share personal information or inappropriate content';

  @override
  String get mapEmptyHintFridayTime =>
      'Пусто сейчас? Это нормально! 😊 Пик активности вечером, когда все онлайн 🌃';

  @override
  String get vibeLabelBrainMode => 'Фокус';

  @override
  String get vibeLabelLatteBreak => 'Кофе-тайм';

  @override
  String get vibeLabelSportMode => 'Спорт';

  @override
  String get vibeLabelSoundLoop => 'Музыка';

  @override
  String get vibeLabelCityWalk => 'На районе';

  @override
  String get vibeLabelContentMode => 'Контент';

  @override
  String get vibeLabelChillNight => 'Чилл';

  @override
  String get vibeLabelPartyMode => 'Движ';

  @override
  String get scanYourVibe => 'Зафиксируй вайб ⚡';

  @override
  String get pickYourMood =>
      'Выбери настроение и смотри, что происходит сейчас 👀';

  @override
  String waitMinutes(int minutes) {
    return 'Подожди $minutes мин ⏰';
  }

  @override
  String get swipeDownToMap => '↓ Свайпни вниз к карте';

  @override
  String get changeYourMood => 'Изменить настроение';

  @override
  String get swipeUp => 'Свайпни вверх ↑';

  @override
  String get youAreNotAlone => 'Ты не один!';

  @override
  String get you => 'ТЫ';

  @override
  String get others => 'человек';

  @override
  String get days => 'дней';

  @override
  String streak(int days) {
    return '🔥 Серия: $days дн.';
  }

  @override
  String get shareMyVibe => '📤 Поделиться вайбом';

  @override
  String get close => 'Закрыть';

  @override
  String get happy => 'кайфуют';

  @override
  String get nearby => 'рядом';

  @override
  String get enableLocationSettings => 'Включи геолокацию в настройках';

  @override
  String get errorTryAgain => 'Ошибка, попробуй ещё';

  @override
  String get networkError => 'Проблема с сетью';

  @override
  String get missingConfiguration => 'Нет настроек';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'чувствую $emotion прям сейчас 💭 кто ещё? чекни -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'Мой вайб на MoodMap! 🌟';

  @override
  String get pingErrorYourVibeExpired => 'Твой вайб истёк, поставь новый';

  @override
  String get pingSentSuccess => 'Ping отправлен! ⚡ 60 сек на Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'Подожди $seconds сек';
  }

  @override
  String get pingSomeoneAlreadySent => 'Кто-то уже отправил ping';

  @override
  String get pingPersonInSpark => 'Человек уже в PW чате';

  @override
  String get pingThisVibeExpired => 'Этот вайб уже истёк';

  @override
  String get pingFailedToSend => 'Не удалось отправить';

  @override
  String get pingSendingError => 'Ошибка отправки';

  @override
  String get pingCancelled => 'Ping отменён';

  @override
  String get pingCancelledBySender => 'Ping отменён отправителем';

  @override
  String get pingErrorConnecting => 'Ошибка соединения с PW mate';

  @override
  String get pingErrorStartingChat => 'Ошибка запуска чата';

  @override
  String get chatTimeNow => 'сейчас';

  @override
  String chatTimeMinutes(int minutes) {
    return '$minutesм';
  }

  @override
  String chatTimeHours(int hours) {
    return '$hoursч';
  }

  @override
  String get distanceVeryClose => 'очень близко';

  @override
  String distanceMeters(int meters) {
    return '$metersм';
  }

  @override
  String distanceKilometers(String km) {
    return '$kmкм';
  }

  @override
  String get sparkDefaultAlias1 => 'PW mate 1';

  @override
  String get sparkDefaultAlias2 => 'PW mate 2';

  @override
  String get birthYearTitle => 'твой год рождения';

  @override
  String get birthYearPrivacyText => 'приватно • никому не покажем';

  @override
  String get birthYearDefaultGeneration => 'Крутое поколение ⭐';

  @override
  String get genLabel2012 => 'Дети iPad 📱';

  @override
  String get genLabel2011 => 'OG Minecraft ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'Поколение Instagram 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'Дети TikTok 🎬';

  @override
  String get genLabel2006 => 'Поколение YouTube 🎮';

  @override
  String get genLabel2005 => 'Эра Facebook 👍';

  @override
  String get genLabel2004 => 'Snapchat 👻';

  @override
  String get genLabel2003 => 'Эра ICQ 💬';

  @override
  String get genLabel2002 => 'Поколение iPod 🎧';

  @override
  String get genLabel2001 => 'Поттероманы ⚡';

  @override
  String get genLabel2000 => 'Дети Y2K 🌐';

  @override
  String get genLabel1999 => 'Поколение Matrix 💊';

  @override
  String get genLabel1998 => 'Game Boy 🎮';

  @override
  String get genLabel1997 => 'Pokémon 🔴';

  @override
  String get genLabel1996 => 'Дети Dial-Up 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'Эра Друзей ☕';

  @override
  String get genLabel1993 => 'Поколение Sonic 💨';

  @override
  String get genLabel1992 => 'Cartoon Network 📺';

  @override
  String get genLabel1991 => 'Дети Dendy 🎮';

  @override
  String get genLabel1990 => 'Поколение MTV 🎸';

  @override
  String get genLabel1989 => 'Эра Тетрис 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'Дети VHS 📼';

  @override
  String get genLabel1986 => 'Поколение Arcade 👾';

  @override
  String get genLabel1985 => 'Эра BTTF ⏰';

  @override
  String get genLabel1984 => 'Дети Mac 🍎';

  @override
  String get genLabel1983 => 'Star Wars ⚔️';

  @override
  String get genLabel1982 => 'Поколение E.T. 👽';

  @override
  String get genLabel1981 => 'Старт MTV 📺';

  @override
  String get genLabel1980 => 'Pac-Man 👾';

  @override
  String get genLabel1979 => 'Эра Диско 🪩';

  @override
  String get genLabel1978 => 'Space Invaders 🚀';

  @override
  String get genLabel1977 => 'Star Wars OG 🌟';

  @override
  String get genLabel1976 => 'Punk Rock 🎸';

  @override
  String get genLabel1975 => 'Поколение Jaws 🦈';

  @override
  String get genLabel1974 => 'Старт Диско 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'Эра Pong 🏓';

  @override
  String get genLabel1971 => 'Zeppelin 🎸';

  @override
  String get genLabel1970 => 'Поколение Beatles 🎵';

  @override
  String get genLabel1969 => 'Легенды 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'История';

  @override
  String get historyEmptyTitle => 'Пока пусто';

  @override
  String get historyEmptySubtitle =>
      'Начни делиться вайбами\nчтобы увидеть историю';

  @override
  String get historyMyEmotions => 'Мои эмоции';

  @override
  String get historyStatTotal => 'Всего';

  @override
  String get historyStatDominant => 'Главная';

  @override
  String get historyToday => 'Сегодня';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => 'Тренды';

  @override
  String get trendsSubtitle => 'Статистика города собирается';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'Это твой вайб';

  @override
  String get mapErrorNeedActiveVibeToPing =>
      'Нужен активный вайб для отправки ping';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'У тебя уже есть активный ping или вайб недоступен';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'Ты ограничен на $time';
  }

  @override
  String get mapBanRestrictionLifted =>
      'Ограничение снято! Можешь снова делиться вайбами';

  @override
  String mapSuccessVibeSent(int count) {
    return 'Вайб отправлен! Ещё $count рядом 🎉';
  }

  @override
  String get mapTutorialTapToSpark => 'тапни на вайб • получи PW чат за 60 сек';

  @override
  String mapActivePingStatus(int seconds) {
    return 'Активный ping ($secondsс) - Тапни для отмены';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin =>
      'смотри что происходит рядом прям сейчас';

  @override
  String get onboardingButtonLetsGo => 'погнали';

  @override
  String get onboardingBadgeAge13Plus => '13+ только';

  @override
  String get onboardingValueTitleInstantSparks => 'мгновенный PW чат';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'коннект за 60 сек';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'гиперлокальные вайбы';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => 'только те кто недалеко';

  @override
  String get onboardingValueTitleNoProfiles => 'никаких профилей';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'только настоящие вайбы';

  @override
  String get onboardingButtonImReady => 'я готов';

  @override
  String get onboardingLocationTitle => 'открой свой район';

  @override
  String get onboardingLocationSubtitle => 'смотри вайбы вокруг тебя';

  @override
  String get onboardingLocationPrivacyTitle => 'приватность важна';

  @override
  String get onboardingLocationPrivacyBullet1 =>
      'только когда приложение открыто';

  @override
  String get onboardingLocationPrivacyBullet2 => 'без фонового отслеживания';

  @override
  String get onboardingLocationPrivacyBullet3 => 'только анонимные вайбы';

  @override
  String get onboardingButtonEnableRadar => 'включить радар';

  @override
  String get onboardingButtonMaybeLater => 'может позже';

  @override
  String get onboardingNotificationTitle => 'не пропусти PW чат';

  @override
  String get onboardingNotificationSubtitle => 'получай пинги когда рядом движ';

  @override
  String get onboardingNotificationFeature1 => 'мгновенные пинги от вайберов';

  @override
  String get onboardingNotificationFeature2 => 'ежедневные напоминания о вайбе';

  @override
  String get onboardingNotificationFeature3 => 'посказки об активных местах';

  @override
  String get onboardingButtonTurnOnPings => 'включить пинги';

  @override
  String get onboardingButtonNotNow => 'не сейчас';

  @override
  String get onboardingLegalTitle => 'почти готово!';

  @override
  String get onboardingLegalAgeRequirement => 'тебе должно быть 13 или больше';

  @override
  String get onboardingLegalAgeSubtitle =>
      'ping & wink для подростков и старше';

  @override
  String get onboardingLegalConsent =>
      'нажимая продолжить, ты подтверждаешь что тебе 13+ и соглашаешься с';

  @override
  String get onboardingLegalTerms => 'условиями';

  @override
  String get onboardingLegalAnd => ' и ';

  @override
  String get onboardingLegalPrivacyPolicy => 'политикой приватности';

  @override
  String get onboardingLegalSafetyFeature1 => 'только анонимные вайбы';

  @override
  String get onboardingLegalSafetyFeature2 => 'мгновенная блокировка и репорты';

  @override
  String get onboardingLegalSafetyFeature3 =>
      'таймаут 20 мин за плохое поведение';

  @override
  String get onboardingButtonImAge13AndAgree => 'мне 13+ и я согласен';

  @override
  String get onboardingButtonImUnder13 => 'мне меньше 13';

  @override
  String get onboardingLocationDeniedTitle => 'пропустишь все PW искры';

  @override
  String get onboardingLocationDeniedMessage =>
      'без геолокации не сможешь:\n• видеть кто рядом\n• отправлять пинги\n• получать винки\n• создавать PW искры';

  @override
  String get onboardingButtonGoBack => 'назад';

  @override
  String get onboardingButtonExitApp => 'выйти';

  @override
  String get onboardingNotificationDeniedTitle => 'пропустишь весь движ';

  @override
  String get onboardingNotificationDeniedMessage =>
      'без уведомлений:\n• никто не сможет пингануть\n• пропустишь PW искры рядом\n• ноль коннектов\n\nнаши пользователи включают уведомления';

  @override
  String get onboardingButtonLetMeReconsider => 'дай подумать';

  @override
  String get onboardingButtonContinueAnyway => 'продолжить всё равно';

  @override
  String get onboardingAgeDialogTitle => 'увидимся позже!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink для пользователей 13 лет и старше. возвращайся когда подрастёшь!';

  @override
  String get onboardingButtonUnderstood => 'понятно';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'сейчас';

  @override
  String get onboardingNotificationExamplePing => 'новый пинг 1230м';

  @override
  String get onboardingNotificationExampleMessage => 'кто-то вайбит с тобой';

  @override
  String get onboardingMapNotification => 'кто-то активен в 753м';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• только когда приложение открыто\n• без фонового отслеживания\n• только анонимные вайбы';

  @override
  String get onboardingLocationDeniedFormatted =>
      'без геолокации не сможешь:\n• видеть кто рядом\n• отправлять пинги\n• получать винки\n• создавать искры';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'без уведомлений:\n• никто не сможет пингануть\n• пропустишь вайбы рядом\n• ноль коннектов\n\nнаши пользователи включают уведомления';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'Коннект через эмоции';

  @override
  String get settingsShareTitle => 'Поделись с друзьями';

  @override
  String get settingsShareSubtitle => 'Пригласи других открыть вайбы';

  @override
  String get settingsSectionPreferences => 'Настройки';

  @override
  String get settingsSectionLegal => 'Правовое';

  @override
  String get settingsSectionSupport => 'Поддержка';

  @override
  String get settingsSectionDataManagement => 'Управление данными';

  @override
  String get settingsNotificationsTitle => 'Уведомления';

  @override
  String get settingsNotificationsEnabled => 'Включены';

  @override
  String get settingsNotificationsDisabled => 'Выключены';

  @override
  String get settingsMapThemeTitle => 'Тема карты';

  @override
  String get settingsMapThemeCyberpunk => 'Киберпанк';

  @override
  String get settingsMapThemeMinimalist => 'Минимализм';

  @override
  String get settingsLocationModeTitle => 'Режим локации';

  @override
  String get settingsLocationModeSoft => 'Локация сдвинута, просто для стиля';

  @override
  String get settingsLocationModeExact => 'Твой вайб точно там где ты';

  @override
  String get settingsDeleteVibeTitle => 'Удалить мой вайб';

  @override
  String get settingsDeleteVibeSubtitle => 'Убрать твою эмоцию с карты';

  @override
  String get settingsPrivacyTitle => 'Политика приватности';

  @override
  String get settingsPrivacySubtitle => 'Как мы защищаем твои данные';

  @override
  String get settingsTermsTitle => 'Условия использования';

  @override
  String get settingsTermsSubtitle => 'Правила использования приложения';

  @override
  String get settingsHelpTitle => 'Центр помощи';

  @override
  String get settingsHelpSubtitle => 'FAQ и гайды';

  @override
  String get settingsContactTitle => 'Контакт';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'Удалить аккаунт';

  @override
  String get settingsDeleteAccountSubtitle => 'Стереть все твои данные';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Просто вайбы';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'ID устройства: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => 'Удалить твой вайб?';

  @override
  String get settingsDeleteVibeDialogMessage => 'Твоя эмоция исчезнет с карты';

  @override
  String get settingsVibeDeletedSuccess => 'Твой вайб удалён';

  @override
  String get settingsVibeDeleteError => 'Ошибка удаления вайба';

  @override
  String get settingsNotificationWarningTitle => 'Внимание!';

  @override
  String get settingsNotificationWarningMessage =>
      'Если выключишь уведомления, не сможешь получать ПИНГИ от других.\n\nPW чаты (коннекты) будут недоступны.\n\nТочно выключить?';

  @override
  String get settingsNotificationWarningCancel => 'Отмена';

  @override
  String get settingsNotificationWarningDisable => 'Всё равно выключить';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ Уведомления выключены - Не получишь никаких пингов';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ Уведомления включены - Можешь получать пинги';

  @override
  String get settingsMapThemeCyberpunkActivated =>
      'Режим киберпанк активирован 🌃';

  @override
  String get settingsMapThemeDayActivated => 'Дневной режим активирован ☀️';

  @override
  String get settingsSoftModeEnabled => 'Soft режим! Твой вайб сдвинут 🌊';

  @override
  String get settingsNormalModeEnabled => 'Обычный режим! Точная локация 📍';

  @override
  String get settingsIdCopied => 'ID скопирован';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ Удалить аккаунт';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'Это действие необратимо. Все твои эмоции и данные будут удалены навсегда.\n\nТы уверен?';

  @override
  String get settingsDeleteAccountDialogDelete => 'Удалить';

  @override
  String get settingsDeleteAccountError => 'Ошибка удаления аккаунта';

  @override
  String get settingsModerationPanelTitle => '🔍 Панель модерации';

  @override
  String get settingsModerationPanelSubtitle => 'Только для проверки App Store';

  @override
  String get settingsModerationActiveBans => 'Активные баны';

  @override
  String get settingsModerationReports => 'Репорты';

  @override
  String get settingsModerationClearData => 'Очистить тестовые данные';

  @override
  String get settingsModerationDataCleared => 'Тестовые данные очищены';

  @override
  String get sparkConnectingToChat => 'Подключаемся к PW чату...';

  @override
  String get sparkChatTitle => 'PW Чат';

  @override
  String get sparkChatEnded => 'Завершён';

  @override
  String get sparkSendFirstMessage => 'Отправь первое сообщение!';

  @override
  String get sparkWaitingForMate => 'Жду PW mate...';

  @override
  String get sparkMessagePlaceholder => 'Сообщение...';

  @override
  String get sparkWaitForReply => 'Жди ответа...';

  @override
  String get sparkChatEndedPlaceholder => 'Чат завершён';

  @override
  String get sparkLeaveChat => 'Покинуть PW чат?';

  @override
  String get sparkChatEndForBoth => 'Чат завершится для обоих PW mates';

  @override
  String get sparkStay => 'Остаться';

  @override
  String get sparkLeave => 'Выйти';

  @override
  String get sparkExtended => 'Продлено! +3 мин ⚡';

  @override
  String get sparkWaitingForOther => 'Жду PW mate...';

  @override
  String get sparkMaxExtensionsReached => 'Максимум продлений';

  @override
  String get sparkFailedToExtend => 'Не удалось продлить';

  @override
  String get sparkFailedToSend => 'Не удалось отправить';

  @override
  String get sparkMessageTooLong => 'Сообщение слишком длинное (макс 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'Ошибка инициализации чата: $error';
  }

  @override
  String get sparkUserBanned => 'Пользователь забанен на 7 минут';

  @override
  String get sparkRestrictedForBanning => 'Ты ограничен за частые баны';

  @override
  String get sparkReportSubmitted => 'Жалоба отправлена';

  @override
  String get sparkBehaviorRestriction =>
      'Ты ограничен за неподобающее поведение';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'ЗАЖГИ МОМЕНТ';

  @override
  String trendsEmotionalPulse(String time) {
    return 'Эмоциональный пульс $time';
  }

  @override
  String get trendsTimeMorning => 'этим утром';

  @override
  String get trendsTimeAfternoon => 'днём';

  @override
  String get trendsTimeEvening => 'вечером';

  @override
  String get trendsTimeLateNight => 'поздней ночью';

  @override
  String get trendsActiveVibes => 'Активные вайбы';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => 'Главная эмоция';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% PW mates';
  }

  @override
  String get trendsEmotionDistribution => 'Распределение эмоций';

  @override
  String get trendsQuote1 => 'Каждая эмоция создаёт связь ✨';

  @override
  String get trendsQuote2 => 'Вместе мы создаём карту эмоций 🗺️';

  @override
  String get trendsQuote3 => 'Твой вайб может изменить чей-то день 💫';

  @override
  String get trendsQuote4 => 'PW чаты начинаются с простого пинга ⚡';

  @override
  String get banOverlayTitle => 'Временное ограничение';

  @override
  String get banOverlayMessage => 'Твой PW mate счёл сообщение неуместным';

  @override
  String get banOverlayRestrictionInfo =>
      'Ты не можешь делиться вайбами в это время';

  @override
  String get bottomNavMap => 'Карта';

  @override
  String get bottomNavHistory => 'История';

  @override
  String get bottomNavTrends => 'Тренды';

  @override
  String get bottomNavSettings => 'Настройки';

  @override
  String get guidelinesTitle => 'Правила сообщества';

  @override
  String get guidelinesRespectTitle => 'Будь уважительным';

  @override
  String get guidelinesRespectSubtitle => 'Относись ко всем с добротой';

  @override
  String get guidelinesNoHarassmentTitle => 'Никаких домогательств';

  @override
  String get guidelinesNoHarassmentSubtitle =>
      'Не отправляй неуместные сообщения';

  @override
  String get guidelinesKeepRealTitle => 'Будь настоящим';

  @override
  String get guidelinesKeepRealSubtitle => 'Делись только искренними вайбами';

  @override
  String get guidelinesHaveFunTitle => 'Веселись';

  @override
  String get guidelinesHaveFunSubtitle => 'Наслаждайся PW искрами!';

  @override
  String get guidelinesViolationWarning =>
      'Нарушения могут привести к временным или постоянным ограничениям';

  @override
  String get guidelinesButtonUnderstand => 'Понятно';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'День $day - Держи серию!';
  }

  @override
  String get emotionSelectorTapYourVibe => 'ТАПНИ СВОЙ ВАЙБ';

  @override
  String get emotionSelectorWhatsYourVibe => 'какой вайб прям сейчас?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count активно сейчас';
  }

  @override
  String get miniBarSendNewPing => 'Отправь новый пинг';

  @override
  String get miniBarPingActive => 'Твой пинг активен';

  @override
  String get moderationBanTitle => 'Бан на 7 мин';

  @override
  String get moderationBanSubtitle => 'Временно ограничить пользователя';

  @override
  String get moderationReportTitle => 'Пожаловаться';

  @override
  String get moderationReportSubtitle => 'Сообщить о неподобающем поведении';

  @override
  String get moderationEndChatTitle => 'Завершить чат';

  @override
  String get moderationEndChatSubtitle => 'Покинуть эту PW сессию';

  @override
  String get moderationReportDialogTitle => 'Жалоба на пользователя';

  @override
  String get moderationReportReasonHarassment => 'Домогательства';

  @override
  String get moderationReportReasonSpam => 'Спам';

  @override
  String get moderationReportReasonHateSpeech => 'Язык вражды';

  @override
  String get moderationReportReasonOther => 'Другое';

  @override
  String get moderationReportSendButton => 'Отправить жалобу';

  @override
  String get pingBottomVibeTooFar => 'Вайб слишком далеко';

  @override
  String get pingBottomVibeTooFarMessage => 'Вайб вне зоны пинга';

  @override
  String get pingBottomTooFar => 'ДАЛЕКО';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'очень близко';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '$metersм';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '$kmкм';
  }

  @override
  String get pingBottomTimeNow => 'сейчас';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '$minutesмин';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '$hoursч';
  }

  @override
  String get vibeAnimBrainEnergy => 'МОЗГИ КИПЯТ';

  @override
  String get vibeAnimCozy => 'ВАЙБ: УЮТ';

  @override
  String get vibeAnimSweatSlay => 'КРОСС ФИТ ЗАРЯЖАЕТ';

  @override
  String get vibeAnimLostInBeat => 'ПОТЕРЯН В БИТЕ';

  @override
  String get vibeAnimCityLights => 'ГОРОД ЖИВЕТ';

  @override
  String get vibeAnimLightsCameraVibes => 'СВЕТ. КАМЕРА. ВАЙБЫ.';

  @override
  String get vibeAnimEveningVibes => 'ВЕЧЕРНИЙ ВАЙБ';

  @override
  String get vibeAnimPartyMode => 'РЕЖИМ: ДВИ́Ж';

  @override
  String get vibeAnimSubBrainTime => 'Время думать 🧠';

  @override
  String get vibeAnimSubCaffeine => 'Кофейный вайб ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'Без выходных 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'Громкость: МАКС 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'Исследую город 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'Творю и свечусь 📸';

  @override
  String get vibeAnimSubNightFlow => 'Ночной флоу 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'Выпусти хаос 🎉';

  @override
  String get vibeAnimDefaultMessage => 'ВАЙБ УСТАНОВЛЕН';

  @override
  String get vibeAnimDefaultSubMessage => 'Погнали!';

  @override
  String get viralShareFailed => 'Не удалось поделиться';

  @override
  String get viralShareTextNight =>
      'все спят. но что-то происходит\npingandwink.com';

  @override
  String get viralShareTextEvening => 'вечер. лучшее время\npingandwink.com';

  @override
  String get viralShareTextDefault =>
      'что происходит прямо сейчас?\npingandwink.com';

  @override
  String get viralShareMainText => 'что происходит\nпока ты это читаешь?';

  @override
  String get viralShareFindOut => 'узнай';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'поделиться →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate хочет коннект';

  @override
  String get winkBannerWinkBack => 'WINK НАЗАД';
}
