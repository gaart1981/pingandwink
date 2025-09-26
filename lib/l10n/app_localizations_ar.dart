// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonOk => 'حسناً';

  @override
  String get commonYes => 'نعم';

  @override
  String get commonNo => 'لا';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonShare => 'مشاركة';

  @override
  String get commonLoading => 'جاري التحميل...';

  @override
  String get commonError => 'حصل خطأ';

  @override
  String get commonSuccess => 'تم بنجاح!';

  @override
  String get commonRetry => 'حاول مرة تانية';

  @override
  String get commonNext => 'التالي';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonSkip => 'تخطي';

  @override
  String get commonDone => 'انتهى';

  @override
  String get commonContinue => 'استمر';

  @override
  String get commonConfirm => 'متأكد؟';

  @override
  String get emptyStateMorningStoryMain =>
      'المدينة لا تزال تستيقظ، تتمدد ببطء\nالجميع في طقوسهم الصباحية\nقهوة، تنقل، التظاهر بالعمل\nلكن إليك ما لا يعرفونه بعد:\nالليلة في الساعة 7 مساءً، هذه الخريطة تتحول تماماً';

  @override
  String get emptyStateMorningStorySub =>
      'اضبط المنبه الآن، اشكر نفسك لاحقاً ⏰';

  @override
  String get emptyStateMorningCuriosityMain =>
      'وصلت للخريطة في مرحلتها الهادئة\nمثل نادي ليلي ظهراً - فارغ لكن مليء بالإمكانات\n3 أشخاص تفقدوا قبلك اليوم\nكلهم وضعوا تذكيرات للـ 7 مساءً\nصدفة؟ أم يعرفون شيئاً؟';

  @override
  String get emptyStateMorningCuriositySub => 'الجواب يكشف نفسه عند الغروب 🌅';

  @override
  String get emptyStateMorningSocialMain =>
      'حقيقة صباح الاثنين:\nالجميع يتظاهر بالعمل الآن\nجداول البيانات مفتوحة، العقول في مكان آخر\nأنت 1 من 7 أشخاص تفقدوا قبل الظهر\nهذا يجعلك مميزاً، أو مجنوناً، أو كليهما';

  @override
  String get emptyStateMorningSocialSub => 'ارجع الساعة 7 مساءً لتكتشف أيهما';

  @override
  String emptyStateFridayMain(int hours) {
    return 'مفارقة عصر الجمعة:\nالجميع منفصل ذهنياً لكن محاصر جسدياً\nيعدون الساعات حتى الحرية ($hours متبقية)\nعند الـ 5 مساءً يبدأ التحول\nمن زومبي العمل إلى محاربي نهاية الأسبوع';
  }

  @override
  String get emptyStateFridaySub => 'وصلت مبكراً لتشهد ذلك 🦋';

  @override
  String get emptyStateAfternoonReturningMain =>
      'تستمر بالعودة في هذا الوقت\nتبحث عن شيء ليس هنا... بعد\nإصرار أم جنون؟\nالكون يراقب\nويكافئ الصبر';

  @override
  String emptyStateAfternoonReturningSub(int hours) {
    return 'تقريباً $hours ساعات حتى الإشعال 🚀';
  }

  @override
  String get emptyStateAfternoonFirstMain =>
      'أحياناً يحدث الساعة 2:47 مساءً\nأحياناً الساعة 6:13 مساءً\nلكنه يحدث دائماً\nالتحول من ميت إلى حي\nمن فارغ إلى كهربائي';

  @override
  String get emptyStateAfternoonFirstSub =>
      'السؤال هو: هل ستكون هنا عندما يحدث؟';

  @override
  String get emptyStatePrimetimeFirstMain =>
      'مرحباً بك على حافة شيء كبير\nبعد 23 دقيقة، هذه الخريطة الفارغة تنفجر\nمئات الذبذبات تظهر كالنجوم\nكل واحدة شخص حقيقي، عاطفة حقيقية، لحظة حقيقية\nأنت هنا قبل الحشد';

  @override
  String get emptyStatePrimetimeFirstSub => 'هذا إما عبقرية أو حظ ⚡';

  @override
  String get emptyStatePrimetimeReturnMain =>
      'صمت ما قبل اللعبة قبل العاصفة\nأنت تعرف ما قادم\nالـ 7 مساءً تضرب بشكل مختلف على هذه الخريطة\nضغط العمل يتحول إلى طاقة نهاية الأسبوع\nشاهده يحدث في الوقت الفعلي';

  @override
  String get emptyStatePrimetimeReturnSub => 'أو أغلق التطبيق وتساءل إلى الأبد';

  @override
  String get emptyStateWeekendEveningMain =>
      'ظاهرة ليلة السبت:\nالجميع هناك يعيش أفضل حياته\nأو يتظاهر على الإنستغرام\nلكنك وجدت نبض المدينة الحقيقي\nعواطف غير مفلترة، غير محررة، غير مراقبة';

  @override
  String get emptyStateWeekendEveningSub => 'حدّث بعد 5 دقائق للحقيقة 🌃';

  @override
  String get emptyStateWeekendMorningMain =>
      'المدينة مخمورة\nتجمع ببطء الليلة الماضية\nتفحص الأضرار، تعد الندم\nالخريطة تنام حتى 2 مساءً\nلكن عندما تستيقظ...';

  @override
  String get emptyStateWeekendMorningSub => 'يبدأ الفوضى الجولة 2 🎭';

  @override
  String get emptyStateLateNightMain =>
      'وضوح الـ 2 صباحاً يضرب بشكل مختلف\nعندما يتوقف الضجيج، تظهر الحقيقة\nفقط الحقيقيون مستيقظون الآن\nيشاركون أفكار الـ 3 صباحاً\nخام، صادق، غير مفلتر';

  @override
  String get emptyStateLateNightSub => 'لست وحيداً في الظلام 🌙';

  @override
  String get emptyStatePush1Title => 'ping&wink';

  @override
  String get emptyStatePush1Body => 'الخريطة تستيقظ 👀';

  @override
  String get emptyStatePush2Title => 'ping&wink';

  @override
  String get emptyStatePush2Body => 'ذروة الذبذبات الآن ⚡';

  @override
  String get emptyStatePush3Title => 'ping&wink';

  @override
  String get emptyStatePush3Body => 'بالأمس فاتتك 47 ذبذبة. اليوم؟';

  @override
  String get emptyStateNotificationEnabled =>
      'الإشعارات مفعلة! ستعرف عندما تظهر الذبذبات 🔔';

  @override
  String get emptyStateTapToClose => 'اضغط للإغلاق';

  @override
  String emptyStateAfternoonReturningHours(int hours) {
    return 'تقريباً $hours ساعات حتى الإشعال 🚀';
  }

  @override
  String get vibeLabelBrainMode => 'وضع التركيز';

  @override
  String get vibeLabelLatteBreak => 'استراحة قهوة';

  @override
  String get vibeLabelSportMode => 'وضع الرياضة';

  @override
  String get vibeLabelSoundLoop => 'في الموسيقى';

  @override
  String get vibeLabelCityWalk => 'جولة بالمدينة';

  @override
  String get vibeLabelContentMode => 'وضع المحتوى';

  @override
  String get vibeLabelChillNight => 'ليلة هادية';

  @override
  String get vibeLabelPartyMode => 'وضع الحفلة';

  @override
  String get scanYourVibe => 'حدد vibe بتاعك ⚡';

  @override
  String get pickYourMood => 'اختار مودك وشوف إيه اللي بيحصل دلوقتي 👀';

  @override
  String waitMinutes(int minutes) {
    return 'استنى $minutes دقيقة ⏰';
  }

  @override
  String get swipeDownToMap => '↓ اسحب لتحت عشان تشوف الخريطة';

  @override
  String get changeYourMood => 'غير مودك';

  @override
  String get swipeUp => 'اسحب لفوق ↑';

  @override
  String get youAreNotAlone => 'مش لوحدك!';

  @override
  String get you => 'انت';

  @override
  String get others => 'غيرك';

  @override
  String get days => 'يوم';

  @override
  String streak(int days) {
    return '🔥 السلسلة: $days يوم';
  }

  @override
  String get shareMyVibe => '📤 شارك vibe بتاعي';

  @override
  String get close => 'إغلاق';

  @override
  String get happy => 'سعيد';

  @override
  String get nearby => 'قريب';

  @override
  String get enableLocationSettings => 'فعّل الموقع من الإعدادات';

  @override
  String get errorTryAgain => 'خطأ، جرب تاني';

  @override
  String get networkError => 'مشكلة في الشبكة';

  @override
  String get missingConfiguration => 'الإعدادات ناقصة';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return 'حاسس بـ $emotion دلوقتي 💭 مين تاني؟ شوف -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'vibe بتاعي على MoodMap! 🌟';

  @override
  String get pingErrorYourVibeExpired => 'vibe بتاعك انتهى، حط واحد جديد';

  @override
  String get pingSentSuccess => 'ping اتبعت! ⚡ 60 ثانية للـ Wink';

  @override
  String pingWaitSeconds(int seconds) {
    return 'استنى $seconds ثانية';
  }

  @override
  String get pingSomeoneAlreadySent => 'حد بعت ping قبلك';

  @override
  String get pingPersonInSpark => 'الشخص ده في PW chat دلوقتي';

  @override
  String get pingThisVibeExpired => 'vibe ده انتهى';

  @override
  String get pingFailedToSend => 'مش قادر يتبعت';

  @override
  String get pingSendingError => 'خطأ في الإرسال';

  @override
  String get pingCancelled => 'ping اتلغى';

  @override
  String get pingCancelledBySender => 'المرسل لغى ping';

  @override
  String get pingErrorConnecting => 'مش قادر يتصل بـ PW mate';

  @override
  String get pingErrorStartingChat => 'خطأ في بدء المحادثة';

  @override
  String get chatTimeNow => 'دلوقتي';

  @override
  String chatTimeMinutes(int minutes) {
    return '$minutesد';
  }

  @override
  String chatTimeHours(int hours) {
    return '$hoursس';
  }

  @override
  String get distanceVeryClose => 'قريب أوي';

  @override
  String distanceMeters(int meters) {
    return '$metersم';
  }

  @override
  String distanceKilometers(String km) {
    return '$kmكم';
  }

  @override
  String get sparkDefaultAlias1 => 'PW mate 1';

  @override
  String get sparkDefaultAlias2 => 'PW mate 2';

  @override
  String get birthYearTitle => 'سنة ميلادك';

  @override
  String get birthYearPrivacyText => 'خاص • محدش هيشوفه';

  @override
  String get birthYearDefaultGeneration => 'جيل رائع ⭐';

  @override
  String get genLabel2012 => 'جيل الآيباد 📱';

  @override
  String get genLabel2011 => 'أساطير Minecraft ⛏️';

  @override
  String get genLabel2010 => 'Angry Birds 🦅';

  @override
  String get genLabel2009 => 'جيل إنستجرام 📸';

  @override
  String get genLabel2008 => 'Musical.ly 🎵';

  @override
  String get genLabel2007 => 'أطفال TikTok 🎬';

  @override
  String get genLabel2006 => 'جيل YouTube 🎮';

  @override
  String get genLabel2005 => 'عصر Facebook 👍';

  @override
  String get genLabel2004 => 'Snapchat 👻';

  @override
  String get genLabel2003 => 'زمن الماسنجر 💬';

  @override
  String get genLabel2002 => 'جيل iPod 🎧';

  @override
  String get genLabel2001 => 'عشاق هاري بوتر ⚡';

  @override
  String get genLabel2000 => 'أطفال Y2K 🌐';

  @override
  String get genLabel1999 => 'جيل Matrix 💊';

  @override
  String get genLabel1998 => 'Game Boy 🎮';

  @override
  String get genLabel1997 => 'Pokémon 🔴';

  @override
  String get genLabel1996 => 'أطفال الإنترنت 💻';

  @override
  String get genLabel1995 => 'Windows 95 🪟';

  @override
  String get genLabel1994 => 'عصر Friends ☕';

  @override
  String get genLabel1993 => 'جيل Sonic 💨';

  @override
  String get genLabel1992 => 'سبيستون 📺';

  @override
  String get genLabel1991 => 'أطفال الألعاب 🎮';

  @override
  String get genLabel1990 => 'جيل MTV 🎸';

  @override
  String get genLabel1989 => 'عصر Nintendo 🕹️';

  @override
  String get genLabel1988 => 'Walkman 🎧';

  @override
  String get genLabel1987 => 'أطفال VHS 📼';

  @override
  String get genLabel1986 => 'جيل الأتاري 👾';

  @override
  String get genLabel1985 => 'العودة للمستقبل ⏰';

  @override
  String get genLabel1984 => 'أطفال Mac 🍎';

  @override
  String get genLabel1983 => 'Star Wars ⚔️';

  @override
  String get genLabel1982 => 'جيل E.T. 👽';

  @override
  String get genLabel1981 => 'بداية MTV 📺';

  @override
  String get genLabel1980 => 'Pac-Man 👾';

  @override
  String get genLabel1979 => 'عصر الديسكو 🪩';

  @override
  String get genLabel1978 => 'Space Invaders 🚀';

  @override
  String get genLabel1977 => 'Star Wars الأصلي 🌟';

  @override
  String get genLabel1976 => 'Punk Rock 🎸';

  @override
  String get genLabel1975 => 'جيل Jaws 🦈';

  @override
  String get genLabel1974 => 'بداية الديسكو 💃';

  @override
  String get genLabel1973 => 'Pink Floyd 🌈';

  @override
  String get genLabel1972 => 'عصر Pong 🏓';

  @override
  String get genLabel1971 => 'Led Zeppelin 🎸';

  @override
  String get genLabel1970 => 'جيل Beatles 🎵';

  @override
  String get genLabel1969 => 'الأساطير 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => 'السجل';

  @override
  String get historyEmptyTitle => 'مفيش مشاعر لسه';

  @override
  String get historyEmptySubtitle => 'ابدأ شارك مودك\nعشان تشوف السجل';

  @override
  String get historyMyEmotions => 'مشاعري';

  @override
  String get historyStatTotal => 'المجموع';

  @override
  String get historyStatDominant => 'الأكثر';

  @override
  String get historyToday => 'النهاردة';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => 'الترندات';

  @override
  String get trendsSubtitle => 'إحصائيات المدينة بتتحمل';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => 'ده vibe بتاعك انت';

  @override
  String get mapErrorNeedActiveVibeToPing => 'محتاج vibe نشط عشان تبعت ping';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      'عندك ping نشط بالفعل أو vibe مش متاح';

  @override
  String mapBanRestrictionMessage(String time) {
    return 'انت محظور لمدة $time';
  }

  @override
  String get mapBanRestrictionLifted => 'الحظر اتشال! تقدر تشارك vibes تاني';

  @override
  String mapSuccessVibeSent(int count) {
    return 'vibe اتبعت! $count ناس تانية قريبة 🎉';
  }

  @override
  String get mapTutorialTapToSpark =>
      'دوس على vibe حد • هتحصل على PW chat في 60 ثانية';

  @override
  String mapActivePingStatus(int seconds) {
    return 'ping نشط ($secondsث) - دوس عشان تلغي';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin => 'شوف إيه اللي بيحصل حواليك';

  @override
  String get onboardingButtonLetsGo => 'يلا بينا';

  @override
  String get onboardingBadgeAge13Plus => '13+ بس';

  @override
  String get onboardingValueTitleInstantSparks => 'PW chat فوري';

  @override
  String get onboardingValueSubtitleConnect60Sec => 'اتصل في 60 ثانية';

  @override
  String get onboardingValueTitleHyperlocalVibes => 'vibes محلية جداً';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => '3 كم بس';

  @override
  String get onboardingValueTitleNoProfiles => 'مفيش بروفايلات';

  @override
  String get onboardingValueSubtitleJustPureMoments => 'لحظات حقيقية بس';

  @override
  String get onboardingButtonImReady => 'أنا جاهز';

  @override
  String get onboardingLocationTitle => 'افتح منطقتك';

  @override
  String get onboardingLocationSubtitle => 'شوف المود في دايرة 3 كم';

  @override
  String get onboardingLocationPrivacyTitle => 'الخصوصية أولاً';

  @override
  String get onboardingLocationPrivacyBullet1 => 'بس لما التطبيق يكون مفتوح';

  @override
  String get onboardingLocationPrivacyBullet2 => 'مفيش تتبع في الخلفية';

  @override
  String get onboardingLocationPrivacyBullet3 => 'vibes مجهولة بس';

  @override
  String get onboardingButtonEnableRadar => 'فعّل الرادار';

  @override
  String get onboardingButtonMaybeLater => 'بعدين';

  @override
  String get onboardingNotificationTitle => 'متفوتش أي PW chat';

  @override
  String get onboardingNotificationSubtitle =>
      'هتوصلك ping لما يكون فيه حاجة مثيرة قريبة';

  @override
  String get onboardingNotificationFeature1 => 'ping فوري لما حد يعمل vibe';

  @override
  String get onboardingNotificationFeature2 => 'تذكيرات vibe يومية';

  @override
  String get onboardingNotificationFeature3 => 'تنبيهات الأماكن النشطة';

  @override
  String get onboardingButtonTurnOnPings => 'فعّل pings';

  @override
  String get onboardingButtonNotNow => 'مش دلوقتي';

  @override
  String get onboardingLegalTitle => 'كده تقريباً!';

  @override
  String get onboardingLegalAgeRequirement => 'لازم تكون 13 سنة أو أكبر';

  @override
  String get onboardingLegalAgeSubtitle => 'ping & wink للمراهقين وأكبر';

  @override
  String get onboardingLegalConsent =>
      'بالضغط على استمرار، بتأكد إن عمرك 13+ وموافق على';

  @override
  String get onboardingLegalTerms => 'الشروط';

  @override
  String get onboardingLegalAnd => ' و ';

  @override
  String get onboardingLegalPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get onboardingLegalSafetyFeature1 => 'vibes مجهولة بس';

  @override
  String get onboardingLegalSafetyFeature2 => 'حظر وإبلاغ فوري';

  @override
  String get onboardingLegalSafetyFeature3 => 'إيقاف 20 دقيقة للسلوك السيء';

  @override
  String get onboardingButtonImAge13AndAgree => 'عندي 13+ وموافق';

  @override
  String get onboardingButtonImUnder13 => 'عندي أقل من 13';

  @override
  String get onboardingLocationDeniedTitle => 'هتفوتك كل PW sparks';

  @override
  String get onboardingLocationDeniedMessage =>
      'من غير الموقع، مش هتقدر:\n• تشوف مين قريب\n• تبعت ping\n• تاخد wink\n• PW spark connections';

  @override
  String get onboardingButtonGoBack => 'ارجع';

  @override
  String get onboardingButtonExitApp => 'اخرج من التطبيق';

  @override
  String get onboardingNotificationDeniedTitle => 'هتفوتك كل المتعة';

  @override
  String get onboardingNotificationDeniedMessage =>
      'من غير الإشعارات:\n• محدش هيقدر يبعتلك ping\n• هتفوتك PW sparks القريبة\n• صفر اتصالات\n\nالمستخدمين بتوعنا بيفعلوا الإشعارات';

  @override
  String get onboardingButtonLetMeReconsider => 'خليني أفكر تاني';

  @override
  String get onboardingButtonContinueAnyway => 'كمل برضه';

  @override
  String get onboardingAgeDialogTitle => 'نتقابل بعدين!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink للمستخدمين 13 سنة وأكبر. ارجع لما تكبر!';

  @override
  String get onboardingButtonUnderstood => 'فهمت';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => 'دلوقتي';

  @override
  String get onboardingNotificationExamplePing => 'ping جديد على بعد 230م';

  @override
  String get onboardingNotificationExampleMessage => 'حد بنفس vibe بتاعك';

  @override
  String get onboardingMapNotification => 'حد عمل spark على بعد 753م';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• بس لما التطبيق يكون مفتوح\n• مفيش تتبع في الخلفية\n• vibes مجهولة بس';

  @override
  String get onboardingLocationDeniedFormatted =>
      'من غير الموقع، مش هتقدر:\n• تشوف مين قريب\n• تبعت ping\n• تاخد wink\n• spark connections';

  @override
  String get onboardingNotificationDeniedFormatted =>
      'من غير الإشعارات:\n• محدش هيقدر يبعتلك ping\n• هتفوتك vibes القريبة\n• صفر اتصالات\n\nالمستخدمين بتوعنا بيفعلوا الإشعارات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => 'اتواصل بالمشاعر';

  @override
  String get settingsShareTitle => 'شارك مع أصحابك';

  @override
  String get settingsShareSubtitle => 'عزم الناس يكتشفوا vibes';

  @override
  String get settingsSectionPreferences => 'التفضيلات';

  @override
  String get settingsSectionLegal => 'قانوني';

  @override
  String get settingsSectionSupport => 'الدعم';

  @override
  String get settingsSectionDataManagement => 'إدارة البيانات';

  @override
  String get settingsNotificationsTitle => 'الإشعارات';

  @override
  String get settingsNotificationsEnabled => 'مفعلة';

  @override
  String get settingsNotificationsDisabled => 'مغلقة';

  @override
  String get settingsMapThemeTitle => 'ثيم الخريطة';

  @override
  String get settingsMapThemeCyberpunk => 'Cyberpunk';

  @override
  String get settingsMapThemeMinimalist => 'بسيط';

  @override
  String get settingsLocationModeTitle => 'وضع الموقع';

  @override
  String get settingsLocationModeSoft => 'الموقع يتحرك شوية، للأناقة';

  @override
  String get settingsLocationModeExact => 'vibe بتاعك بالظبط مكان ما يحصل';

  @override
  String get settingsDeleteVibeTitle => 'احذف vibe بتاعي';

  @override
  String get settingsDeleteVibeSubtitle => 'شيل مشاعرك من الخريطة';

  @override
  String get settingsPrivacyTitle => 'سياسة الخصوصية';

  @override
  String get settingsPrivacySubtitle => 'إزاي بنحمي بياناتك';

  @override
  String get settingsTermsTitle => 'شروط الخدمة';

  @override
  String get settingsTermsSubtitle => 'قواعد استخدام التطبيق';

  @override
  String get settingsHelpTitle => 'مركز المساعدة';

  @override
  String get settingsHelpSubtitle => 'الأسئلة والأدلة';

  @override
  String get settingsContactTitle => 'اتصل بينا';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => 'احذف حسابي';

  @override
  String get settingsDeleteAccountSubtitle => 'امسح كل بياناتك';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Just Vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return 'ID الجهاز: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => 'احذف vibe بتاعك؟';

  @override
  String get settingsDeleteVibeDialogMessage => 'مشاعرك هتتشال من الخريطة';

  @override
  String get settingsVibeDeletedSuccess => 'vibe بتاعك اتحذف';

  @override
  String get settingsVibeDeleteError => 'خطأ في حذف vibe';

  @override
  String get settingsNotificationWarningTitle => 'انتبه!';

  @override
  String get settingsNotificationWarningMessage =>
      'لو قفلت الإشعارات، مش هتقدر تستقبل PINGS من المستخدمين التانيين.\n\nPW chats (الاتصالات) مش هتشتغل.\n\nمتأكد عايز تقفلها؟';

  @override
  String get settingsNotificationWarningCancel => 'إلغاء';

  @override
  String get settingsNotificationWarningDisable => 'قفل برضه';

  @override
  String get settingsNotificationsDisabledMessage =>
      '⚠️ الإشعارات مقفولة - مش هتستقبل أي ping';

  @override
  String get settingsNotificationsEnabledMessage =>
      '✅ الإشعارات شغالة - تقدر تستقبل pings';

  @override
  String get settingsMapThemeCyberpunkActivated => 'وضع Cyberpunk شغال 🌃';

  @override
  String get settingsMapThemeDayActivated => 'وضع النهار شغال ☀️';

  @override
  String get settingsSoftModeEnabled =>
      'الوضع الناعم شغال! vibe بتاعك اتحرك 🌊';

  @override
  String get settingsNormalModeEnabled => 'الوضع العادي شغال! موقع دقيق 📍';

  @override
  String get settingsIdCopied => 'ID اتنسخ';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ حذف الحساب';

  @override
  String get settingsDeleteAccountDialogMessage =>
      'العملية دي مش هتتراجع. كل مشاعرك وبياناتك هتتحذف للأبد.\n\nمتأكد؟';

  @override
  String get settingsDeleteAccountDialogDelete => 'احذف';

  @override
  String get settingsDeleteAccountError => 'خطأ في حذف الحساب';

  @override
  String get settingsModerationPanelTitle => '🔍 لوحة الإشراف';

  @override
  String get settingsModerationPanelSubtitle => 'لمراجعة App Store بس';

  @override
  String get settingsModerationActiveBans => 'الحظر النشط';

  @override
  String get settingsModerationReports => 'البلاغات';

  @override
  String get settingsModerationClearData => 'امسح بيانات الاختبار';

  @override
  String get settingsModerationDataCleared => 'بيانات الاختبار اتمسحت';

  @override
  String get sparkConnectingToChat => 'بيتصل بـ PW chat...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => 'انتهى';

  @override
  String get sparkSendFirstMessage => 'ابعت أول رسالة!';

  @override
  String get sparkWaitingForMate => 'مستني PW mate...';

  @override
  String get sparkMessagePlaceholder => 'رسالة...';

  @override
  String get sparkWaitForReply => 'استنى الرد...';

  @override
  String get sparkChatEndedPlaceholder => 'المحادثة انتهت';

  @override
  String get sparkLeaveChat => 'تسيب PW chat؟';

  @override
  String get sparkChatEndForBoth => 'المحادثة هتنتهي للاتنين';

  @override
  String get sparkStay => 'اقعد';

  @override
  String get sparkLeave => 'اطلع';

  @override
  String get sparkExtended => 'اتمدت! +3 دقائق ⚡';

  @override
  String get sparkWaitingForOther => 'مستني PW mate...';

  @override
  String get sparkMaxExtensionsReached => 'وصلت للحد الأقصى من التمديدات';

  @override
  String get sparkFailedToExtend => 'فشل التمديد';

  @override
  String get sparkFailedToSend => 'فشل الإرسال';

  @override
  String get sparkMessageTooLong => 'الرسالة طويلة أوي (أقصى 199)';

  @override
  String sparkErrorInitializing(String error) {
    return 'خطأ في بدء المحادثة: $error';
  }

  @override
  String get sparkUserBanned => 'المستخدم محظور 7 دقائق';

  @override
  String get sparkRestrictedForBanning => 'انت محظور بسبب الحظر المفرط';

  @override
  String get sparkReportSubmitted => 'البلاغ اتبعت';

  @override
  String get sparkBehaviorRestriction => 'انت محظور بسبب سلوك غير لائق';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => 'ولّع اللحظة';

  @override
  String trendsEmotionalPulse(String time) {
    return 'النبض العاطفي $time';
  }

  @override
  String get trendsTimeMorning => 'الصبح ده';

  @override
  String get trendsTimeAfternoon => 'بعد الضهر';

  @override
  String get trendsTimeEvening => 'الليلة دي';

  @override
  String get trendsTimeLateNight => 'آخر الليل';

  @override
  String get trendsActiveVibes => 'Vibes نشطة';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => 'المشاعر السائدة';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% من PW mates';
  }

  @override
  String get trendsEmotionDistribution => 'توزيع المشاعر';

  @override
  String get trendsQuote1 => 'كل مشاعر متشاركة بتخلق اتصال ✨';

  @override
  String get trendsQuote2 => 'مع بعض بنعمل خريطة المشاعر 🗺️';

  @override
  String get trendsQuote3 => 'vibe بتاعك ممكن يغير يوم حد 💫';

  @override
  String get trendsQuote4 => 'PW chats بتبدأ بـ ping بسيط ⚡';

  @override
  String get banOverlayTitle => 'قيد مؤقت';

  @override
  String get banOverlayMessage => 'PW mate بتاعك شاف رسالتك غير مناسبة';

  @override
  String get banOverlayRestrictionInfo => 'مش هتقدر تشارك vibes خلال الوقت ده';

  @override
  String get bottomNavMap => 'الخريطة';

  @override
  String get bottomNavHistory => 'السجل';

  @override
  String get bottomNavTrends => 'الترندات';

  @override
  String get bottomNavSettings => 'الإعدادات';

  @override
  String get guidelinesTitle => 'قواعد المجتمع';

  @override
  String get guidelinesRespectTitle => 'كن محترماً';

  @override
  String get guidelinesRespectSubtitle => 'عامل الكل بلطف';

  @override
  String get guidelinesNoHarassmentTitle => 'لا للمضايقات';

  @override
  String get guidelinesNoHarassmentSubtitle => 'متبعتش رسائل غير لائقة';

  @override
  String get guidelinesKeepRealTitle => 'كن حقيقي';

  @override
  String get guidelinesKeepRealSubtitle => 'شارك vibes حقيقية بس';

  @override
  String get guidelinesHaveFunTitle => 'استمتع';

  @override
  String get guidelinesHaveFunSubtitle => 'استمتع باتصالات PW!';

  @override
  String get guidelinesViolationWarning =>
      'المخالفات ممكن تؤدي لقيود مؤقتة أو دائمة';

  @override
  String get guidelinesButtonUnderstand => 'فهمت';

  @override
  String emotionSelectorStreakDay(int day) {
    return 'يوم $day - حافظ على السلسلة!';
  }

  @override
  String get emotionSelectorTapYourVibe => 'دوس على VIBE بتاعك';

  @override
  String get emotionSelectorWhatsYourVibe => 'إيه vibe بتاعك دلوقتي؟';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count نشط دلوقتي';
  }

  @override
  String get miniBarSendNewPing => 'ابعت ping جديد';

  @override
  String get miniBarPingActive => 'ping بتاعك نشط';

  @override
  String get moderationBanTitle => 'حظر 7 دقائق';

  @override
  String get moderationBanSubtitle => 'قيد المستخدم ده مؤقتاً';

  @override
  String get moderationReportTitle => 'بلاغ';

  @override
  String get moderationReportSubtitle => 'بلغ عن سلوك غير لائق';

  @override
  String get moderationEndChatTitle => 'إنهاء المحادثة';

  @override
  String get moderationEndChatSubtitle => 'اطلع من جلسة PW دي';

  @override
  String get moderationReportDialogTitle => 'بلغ عن المستخدم';

  @override
  String get moderationReportReasonHarassment => 'مضايقة';

  @override
  String get moderationReportReasonSpam => 'سبام';

  @override
  String get moderationReportReasonHateSpeech => 'خطاب كراهية';

  @override
  String get moderationReportReasonOther => 'غير ذلك';

  @override
  String get moderationReportSendButton => 'ابعت البلاغ';

  @override
  String get pingBottomVibeTooFar => 'Vibe بعيد أوي (أقصى 3كم)';

  @override
  String get pingBottomVibeTooFarMessage => 'Vibe بعيد - أقصى 3كم للـ ping';

  @override
  String get pingBottomTooFar => 'بعيد أوي';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => 'قريب أوي';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '$metersم';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '$kmكم';
  }

  @override
  String get pingBottomTimeNow => 'دلوقتي';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '$minutesد';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '$hoursس';
  }

  @override
  String get vibeAnimBrainEnergy => 'قوة عقلية';

  @override
  String get vibeAnimCozy => 'VIBE: مرتاح';

  @override
  String get vibeAnimSweatSlay => 'عرق. فوز. كرر';

  @override
  String get vibeAnimLostInBeat => 'ضايع في الإيقاع';

  @override
  String get vibeAnimCityLights => 'أضواء المدينة';

  @override
  String get vibeAnimLightsCameraVibes => 'أضواء. كاميرا. VIBES.';

  @override
  String get vibeAnimEveningVibes => 'أجواء المساء';

  @override
  String get vibeAnimPartyMode => 'وضع الحفلة: شغال';

  @override
  String get vibeAnimSubBrainTime => 'وقت التفكير 🧠';

  @override
  String get vibeAnimSubCaffeine => 'أجواء القهوة ☕';

  @override
  String get vibeAnimSubNoDaysOff => 'مفيش إجازات 🔥';

  @override
  String get vibeAnimSubVolumeMax => 'الصوت: أقصى 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => 'مستكشف المدينة 🌃';

  @override
  String get vibeAnimSubCreateGlow => 'ابدع واتألق 📸';

  @override
  String get vibeAnimSubNightFlow => 'إيقاع الليل 🌙';

  @override
  String get vibeAnimSubUnleashChaos => 'اطلق الفوضى 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE محدد';

  @override
  String get vibeAnimDefaultSubMessage => 'يلا نبدأ!';

  @override
  String get viralShareFailed => 'فشلت المشاركة';

  @override
  String get viralShareTextNight =>
      'الكل نايم. بس في حاجة بتحصل\npingandwink.com';

  @override
  String get viralShareTextEvening => 'بالليل. أحسن وقت\npingandwink.com';

  @override
  String get viralShareTextDefault => 'إيه اللي بيحصل دلوقتي؟\npingandwink.com';

  @override
  String get viralShareMainText => 'إيه اللي بيحصل\nوانت بتقرأ ده؟';

  @override
  String get viralShareFindOut => 'اكتشف';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => 'شارك →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate عايز يتواصل';

  @override
  String get winkBannerWinkBack => 'WINK BACK';
}
