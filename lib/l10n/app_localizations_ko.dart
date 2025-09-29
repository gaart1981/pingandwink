// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get commonCancel => '취소';

  @override
  String get commonClose => '닫기';

  @override
  String get commonOk => '확인';

  @override
  String get commonYes => '응';

  @override
  String get commonNo => '아니';

  @override
  String get commonSave => '저장';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonShare => '공유';

  @override
  String get commonLoading => '로딩중...';

  @override
  String get commonError => '에러났어';

  @override
  String get commonSuccess => '성공!';

  @override
  String get commonRetry => '다시 시도';

  @override
  String get commonNext => '다음';

  @override
  String get commonBack => '뒤로';

  @override
  String get commonSkip => '건너뛰기';

  @override
  String get commonDone => '완료';

  @override
  String get commonContinue => '계속';

  @override
  String get commonConfirm => '확실해?';

  @override
  String get chatBlockedMessage =>
      'Cannot share personal information or inappropriate content';

  @override
  String get mapEmptyHintFridayTime =>
      '지금 비어있나요? 정상이에요! 😊 피크 시간은 오후 6-10시, 모두가 활동하는 시간이죠 🌃';

  @override
  String get vibeLabelBrainMode => '공부 모드';

  @override
  String get vibeLabelLatteBreak => '카페 타임';

  @override
  String get vibeLabelSportMode => '운동 중';

  @override
  String get vibeLabelSoundLoop => '음악 속';

  @override
  String get vibeLabelCityWalk => '산책 중';

  @override
  String get vibeLabelContentMode => '콘텐츠 제작';

  @override
  String get vibeLabelChillNight => '칠링 나이트';

  @override
  String get vibeLabelPartyMode => '파티 모드';

  @override
  String get scanYourVibe => '네 vibe 설정해 ⚡';

  @override
  String get pickYourMood => '기분 선택하고 지금 뭐 하는지 봐 👀';

  @override
  String waitMinutes(int minutes) {
    return '$minutes분 기다려 ⏰';
  }

  @override
  String get swipeDownToMap => '↓ 아래로 스와이프해서 지도 봐';

  @override
  String get changeYourMood => '기분 바꾸기';

  @override
  String get swipeUp => '위로 스와이프 ↑';

  @override
  String get youAreNotAlone => '너 혼자가 아니야!';

  @override
  String get you => '너';

  @override
  String get others => '명 더';

  @override
  String get days => '일';

  @override
  String streak(int days) {
    return '🔥 연속: $days일';
  }

  @override
  String get shareMyVibe => '📤 내 vibe 공유';

  @override
  String get close => '닫기';

  @override
  String get happy => '행복';

  @override
  String get nearby => '근처';

  @override
  String get enableLocationSettings => '설정에서 위치 켜줘';

  @override
  String get errorTryAgain => '에러, 다시 해봐';

  @override
  String get networkError => '네트워크 에러';

  @override
  String get missingConfiguration => '설정 누락';

  @override
  String shareMessage(String emotion, String emotionName, int nearbyCount,
      int streakDays, int happinessPercent) {
    return '지금 진짜 $emotion 느끼는 중 💭 또 누구? 체크 -> moodmap.cloud  #MoodMap #VibeCheck';
  }

  @override
  String get shareSubject => 'MoodMap에서 내 vibe! 🌟';

  @override
  String get pingErrorYourVibeExpired => '네 vibe 만료됐어, 새로 놓아';

  @override
  String get pingSentSuccess => 'Ping 보냈어! ⚡ Wink까지 60초';

  @override
  String pingWaitSeconds(int seconds) {
    return '$seconds초 기다려';
  }

  @override
  String get pingSomeoneAlreadySent => '누가 이미 ping 보냈어';

  @override
  String get pingPersonInSpark => '이 사람 PW chat 중이야';

  @override
  String get pingThisVibeExpired => '이 vibe 만료됐어';

  @override
  String get pingFailedToSend => '보내기 실패';

  @override
  String get pingSendingError => '전송 에러';

  @override
  String get pingCancelled => 'Ping 취소됨';

  @override
  String get pingCancelledBySender => '보낸 사람이 ping 취소함';

  @override
  String get pingErrorConnecting => 'PW mate 연결 에러';

  @override
  String get pingErrorStartingChat => '채팅 시작 에러';

  @override
  String get chatTimeNow => '지금';

  @override
  String chatTimeMinutes(int minutes) {
    return '$minutes분';
  }

  @override
  String chatTimeHours(int hours) {
    return '$hours시간';
  }

  @override
  String get distanceVeryClose => '완전 가까움';

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
  String get birthYearTitle => '태어난 년도';

  @override
  String get birthYearPrivacyText => '비공개 • 아무도 못 봄';

  @override
  String get birthYearDefaultGeneration => '쿨한 세대 ⭐';

  @override
  String get genLabel2012 => '아이패드 키즈 📱';

  @override
  String get genLabel2011 => '마크 OG ⛏️';

  @override
  String get genLabel2010 => '앵그리버드 🦅';

  @override
  String get genLabel2009 => '인스타 세대 📸';

  @override
  String get genLabel2008 => '뮤지컬리 🎵';

  @override
  String get genLabel2007 => '틱톡 키즈 🎬';

  @override
  String get genLabel2006 => '유튜브 세대 🎮';

  @override
  String get genLabel2005 => '페북 시대 👍';

  @override
  String get genLabel2004 => '스냅챗 👻';

  @override
  String get genLabel2003 => '싸이월드 시대 💬';

  @override
  String get genLabel2002 => '아이팟 세대 🎧';

  @override
  String get genLabel2001 => '해리포터 팬 ⚡';

  @override
  String get genLabel2000 => 'Y2K 키즈 🌐';

  @override
  String get genLabel1999 => '매트릭스 세대 💊';

  @override
  String get genLabel1998 => '게임보이 🎮';

  @override
  String get genLabel1997 => '포켓몬 🔴';

  @override
  String get genLabel1996 => 'PC통신 키즈 💻';

  @override
  String get genLabel1995 => '윈도우95 🪟';

  @override
  String get genLabel1994 => '프렌즈 시대 ☕';

  @override
  String get genLabel1993 => '소닉 세대 💨';

  @override
  String get genLabel1992 => '서울 올림픽 📺';

  @override
  String get genLabel1991 => '슈퍼패미컴 🎮';

  @override
  String get genLabel1990 => 'MTV 세대 🎸';

  @override
  String get genLabel1989 => '닌텐도 시대 🕹️';

  @override
  String get genLabel1988 => '워크맨 🎧';

  @override
  String get genLabel1987 => 'VHS 키즈 📼';

  @override
  String get genLabel1986 => '오락실 세대 👾';

  @override
  String get genLabel1985 => '백투더퓨처 ⏰';

  @override
  String get genLabel1984 => '맥 키즈 🍎';

  @override
  String get genLabel1983 => '스타워즈 ⚔️';

  @override
  String get genLabel1982 => 'E.T. 세대 👽';

  @override
  String get genLabel1981 => 'MTV 시작 📺';

  @override
  String get genLabel1980 => '팩맨 👾';

  @override
  String get genLabel1979 => '디스코 시대 🪩';

  @override
  String get genLabel1978 => '스페이스 인베이더 🚀';

  @override
  String get genLabel1977 => '스타워즈 OG 🌟';

  @override
  String get genLabel1976 => '펑크 록 🎸';

  @override
  String get genLabel1975 => '죠스 세대 🦈';

  @override
  String get genLabel1974 => '디스코 시작 💃';

  @override
  String get genLabel1973 => '핑크 플로이드 🌈';

  @override
  String get genLabel1972 => '퐁 시대 🏓';

  @override
  String get genLabel1971 => '레드 제플린 🎸';

  @override
  String get genLabel1970 => '비틀즈 세대 🎵';

  @override
  String get genLabel1969 => '레전드 👑';

  @override
  String get birthYear1969Plus => '1969+';

  @override
  String get historyTitle => '히스토리';

  @override
  String get historyEmptyTitle => '아직 감정 없어';

  @override
  String get historyEmptySubtitle => '기분 공유 시작해\n히스토리 보려면';

  @override
  String get historyMyEmotions => '내 감정들';

  @override
  String get historyStatTotal => '전체';

  @override
  String get historyStatDominant => '제일 많은';

  @override
  String get historyToday => '오늘';

  @override
  String historyTimeFormat(String date, String time) {
    return '$date • $time';
  }

  @override
  String historyTodayFormat(String today, String time) {
    return '$today • $time';
  }

  @override
  String get trendsTitle => '트렌드';

  @override
  String get trendsSubtitle => '도시 통계 모으는 중';

  @override
  String get trendsEmoji => '📊';

  @override
  String get mapToastYourOwnVibe => '이건 네 vibe야';

  @override
  String get mapErrorNeedActiveVibeToPing => 'ping 보내려면 활성 vibe 필요해';

  @override
  String get mapErrorAlreadyHavePingOrUnavailable =>
      '이미 활성 ping 있거나 vibe 사용 불가';

  @override
  String mapBanRestrictionMessage(String time) {
    return '$time 동안 제한됨';
  }

  @override
  String get mapBanRestrictionLifted => '제한 풀렸어! 다시 vibe 공유 가능';

  @override
  String mapSuccessVibeSent(int count) {
    return 'Vibe 보냈어! 근처에 $count명 더 있어 🎉';
  }

  @override
  String get mapTutorialTapToSpark => '누군가의 vibe 탭 • 60초 안에 PW chat';

  @override
  String mapActivePingStatus(int seconds) {
    return '활성 ping ($seconds초) - 취소하려면 탭';
  }

  @override
  String get onboardingTitlePingWink => 'ping & wink';

  @override
  String get onboardingSubtitleSeeWhatsPoppin => '주변에 뭐 일어나는지 봐';

  @override
  String get onboardingButtonLetsGo => '가보자고';

  @override
  String get onboardingBadgeAge13Plus => '13세 이상만';

  @override
  String get onboardingValueTitleInstantSparks => '즉시 PW chat';

  @override
  String get onboardingValueSubtitleConnect60Sec => '60초 안에 연결';

  @override
  String get onboardingValueTitleHyperlocalVibes => '완전 로컬 vibe';

  @override
  String get onboardingValueSubtitleOnly2kmRadius => '반경 3km만';

  @override
  String get onboardingValueTitleNoProfiles => '프로필 없음';

  @override
  String get onboardingValueSubtitleJustPureMoments => '순수한 순간만';

  @override
  String get onboardingButtonImReady => '준비됐어';

  @override
  String get onboardingLocationTitle => '네 지역 열어';

  @override
  String get onboardingLocationSubtitle => '3km 안의 무드 봐';

  @override
  String get onboardingLocationPrivacyTitle => '프라이버시 우선';

  @override
  String get onboardingLocationPrivacyBullet1 => '앱 열었을 때만';

  @override
  String get onboardingLocationPrivacyBullet2 => '백그라운드 추적 없음';

  @override
  String get onboardingLocationPrivacyBullet3 => '익명 vibe만';

  @override
  String get onboardingButtonEnableRadar => '레이더 켜기';

  @override
  String get onboardingButtonMaybeLater => '나중에';

  @override
  String get onboardingNotificationTitle => 'PW chat 놓치지 마';

  @override
  String get onboardingNotificationSubtitle => '근처 핫한 곳 있으면 ping 받아';

  @override
  String get onboardingNotificationFeature1 => '누가 vibe하면 즉시 ping';

  @override
  String get onboardingNotificationFeature2 => '매일 vibe 리마인더';

  @override
  String get onboardingNotificationFeature3 => '핫스팟 알림';

  @override
  String get onboardingButtonTurnOnPings => 'ping 켜기';

  @override
  String get onboardingButtonNotNow => '지금 말고';

  @override
  String get onboardingLegalTitle => '거의 다 됐어!';

  @override
  String get onboardingLegalAgeRequirement => '13세 이상이어야 해';

  @override
  String get onboardingLegalAgeSubtitle => 'ping & wink는 청소년 이상용';

  @override
  String get onboardingLegalConsent => '계속하면 13세 이상이고 동의한다는 거야';

  @override
  String get onboardingLegalTerms => '이용약관';

  @override
  String get onboardingLegalAnd => ' & ';

  @override
  String get onboardingLegalPrivacyPolicy => '개인정보처리방침';

  @override
  String get onboardingLegalSafetyFeature1 => '익명 vibe만';

  @override
  String get onboardingLegalSafetyFeature2 => '즉시 차단 & 신고';

  @override
  String get onboardingLegalSafetyFeature3 => '나쁜 행동에 20분 타임아웃';

  @override
  String get onboardingButtonImAge13AndAgree => '13세 이상이고 동의해';

  @override
  String get onboardingButtonImUnder13 => '13세 미만이야';

  @override
  String get onboardingLocationDeniedTitle => '모든 PW sparks 놓칠 거야';

  @override
  String get onboardingLocationDeniedMessage =>
      '위치 없으면 못해:\n• 누가 근처인지 못 봐\n• ping 못 보내\n• wink 못 받아\n• PW spark 연결';

  @override
  String get onboardingButtonGoBack => '돌아가기';

  @override
  String get onboardingButtonExitApp => '앱 나가기';

  @override
  String get onboardingNotificationDeniedTitle => '모든 재미 놓칠 거야';

  @override
  String get onboardingNotificationDeniedMessage =>
      '알림 없으면:\n• 아무도 ping 못 보내\n• 근처 PW sparks 놓쳐\n• 연결 제로\n\n우리 유저들은 알림 켜';

  @override
  String get onboardingButtonLetMeReconsider => '다시 생각해볼게';

  @override
  String get onboardingButtonContinueAnyway => '그래도 계속';

  @override
  String get onboardingAgeDialogTitle => '나중에 봐!';

  @override
  String get onboardingAgeDialogMessage =>
      'ping & wink는 13세 이상 유저용. 나이 되면 돌아와!';

  @override
  String get onboardingButtonUnderstood => '알겠어';

  @override
  String get onboardingNotificationExampleTitle => 'ping & wink';

  @override
  String get onboardingNotificationExampleNow => '지금';

  @override
  String get onboardingNotificationExamplePing => '230m 떨어진 곳 새 ping';

  @override
  String get onboardingNotificationExampleMessage => '누가 너랑 같은 vibe';

  @override
  String get onboardingMapNotification => '누가 753m 떨어진 곳에서 spark';

  @override
  String get onboardingLocationPrivacyFormatted =>
      '• 앱 열었을 때만\n• 백그라운드 추적 없음\n• 익명 vibe만';

  @override
  String get onboardingLocationDeniedFormatted =>
      '위치 없으면 못해:\n• 누가 근처인지 못 봐\n• ping 못 보내\n• wink 못 받아\n• spark 연결';

  @override
  String get onboardingNotificationDeniedFormatted =>
      '알림 없으면:\n• 아무도 ping 못 보내\n• 근처 vibe 놓쳐\n• 연결 제로\n\n우리 유저들은 알림 켜';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsAppName => 'Ping&Wink';

  @override
  String get settingsAppTagline => '감정으로 연결';

  @override
  String get settingsShareTitle => '친구랑 공유';

  @override
  String get settingsShareSubtitle => '다른 사람도 vibe 발견하게 초대';

  @override
  String get settingsSectionPreferences => '환경설정';

  @override
  String get settingsSectionLegal => '법적';

  @override
  String get settingsSectionSupport => '지원';

  @override
  String get settingsSectionDataManagement => '데이터 관리';

  @override
  String get settingsNotificationsTitle => '알림';

  @override
  String get settingsNotificationsEnabled => '켜짐';

  @override
  String get settingsNotificationsDisabled => '꺼짐';

  @override
  String get settingsMapThemeTitle => '지도 테마';

  @override
  String get settingsMapThemeCyberpunk => '사이버펑크';

  @override
  String get settingsMapThemeMinimalist => '미니멀';

  @override
  String get settingsLocationModeTitle => '위치 모드';

  @override
  String get settingsLocationModeSoft => '위치 살짝 이동, 스타일용';

  @override
  String get settingsLocationModeExact => '네 vibe 정확한 위치';

  @override
  String get settingsDeleteVibeTitle => '내 vibe 삭제';

  @override
  String get settingsDeleteVibeSubtitle => '지도에서 감정 제거';

  @override
  String get settingsPrivacyTitle => '개인정보처리방침';

  @override
  String get settingsPrivacySubtitle => '데이터 보호 방법';

  @override
  String get settingsTermsTitle => '이용약관';

  @override
  String get settingsTermsSubtitle => '앱 사용 규칙';

  @override
  String get settingsHelpTitle => '도움말 센터';

  @override
  String get settingsHelpSubtitle => 'FAQ 및 가이드';

  @override
  String get settingsContactTitle => '연락처';

  @override
  String get settingsContactEmail => 'hello@pingandwink.com';

  @override
  String get settingsDeleteAccountTitle => '계정 삭제';

  @override
  String get settingsDeleteAccountSubtitle => '모든 데이터 지우기';

  @override
  String get settingsFooterTagline => 'Ping & Wink - Just Vibes';

  @override
  String get settingsFooterCopyright => '© 2025 Ping and Wink';

  @override
  String settingsDeviceIdPrefix(String id) {
    return '기기 ID: $id...';
  }

  @override
  String get settingsDeleteVibeDialogTitle => '네 vibe 삭제?';

  @override
  String get settingsDeleteVibeDialogMessage => '감정이 지도에서 제거돼';

  @override
  String get settingsVibeDeletedSuccess => '네 vibe 삭제됨';

  @override
  String get settingsVibeDeleteError => 'vibe 삭제 에러';

  @override
  String get settingsNotificationWarningTitle => '주의!';

  @override
  String get settingsNotificationWarningMessage =>
      '알림 끄면 다른 유저한테 PING 못 받아.\n\nPW chats (연결) 못 해.\n\n진짜 끌래?';

  @override
  String get settingsNotificationWarningCancel => '취소';

  @override
  String get settingsNotificationWarningDisable => '그래도 끄기';

  @override
  String get settingsNotificationsDisabledMessage => '⚠️ 알림 꺼짐 - ping 안 받아';

  @override
  String get settingsNotificationsEnabledMessage => '✅ 알림 켜짐 - ping 받을 수 있어';

  @override
  String get settingsMapThemeCyberpunkActivated => '사이버펑크 모드 활성화 🌃';

  @override
  String get settingsMapThemeDayActivated => '낮 모드 활성화 ☀️';

  @override
  String get settingsSoftModeEnabled => '소프트 모드 켜짐! vibe 이동됨 🌊';

  @override
  String get settingsNormalModeEnabled => '일반 모드 켜짐! 정확한 위치 📍';

  @override
  String get settingsIdCopied => 'ID 복사됨';

  @override
  String get settingsDeleteAccountDialogTitle => '⚠️ 계정 삭제';

  @override
  String get settingsDeleteAccountDialogMessage =>
      '되돌릴 수 없어. 모든 감정과 데이터가 영구 삭제돼.\n\n확실해?';

  @override
  String get settingsDeleteAccountDialogDelete => '삭제';

  @override
  String get settingsDeleteAccountError => '계정 삭제 에러';

  @override
  String get settingsModerationPanelTitle => '🔍 관리자 패널';

  @override
  String get settingsModerationPanelSubtitle => '앱스토어 리뷰용만';

  @override
  String get settingsModerationActiveBans => '활성 차단';

  @override
  String get settingsModerationReports => '신고';

  @override
  String get settingsModerationClearData => '테스트 데이터 지우기';

  @override
  String get settingsModerationDataCleared => '테스트 데이터 지워짐';

  @override
  String get sparkConnectingToChat => 'PW chat 연결 중...';

  @override
  String get sparkChatTitle => 'PW Chat';

  @override
  String get sparkChatEnded => '종료';

  @override
  String get sparkSendFirstMessage => '첫 메시지 보내!';

  @override
  String get sparkWaitingForMate => 'PW mate 기다리는 중...';

  @override
  String get sparkMessagePlaceholder => '메시지...';

  @override
  String get sparkWaitForReply => '답장 기다려...';

  @override
  String get sparkChatEndedPlaceholder => '채팅 종료';

  @override
  String get sparkLeaveChat => 'PW chat 나갈래?';

  @override
  String get sparkChatEndForBoth => '둘 다 채팅 끝나';

  @override
  String get sparkStay => '있어';

  @override
  String get sparkLeave => '나가';

  @override
  String get sparkExtended => '연장! +3분 ⚡';

  @override
  String get sparkWaitingForOther => 'PW mate 기다리는 중...';

  @override
  String get sparkMaxExtensionsReached => '최대 연장 도달';

  @override
  String get sparkFailedToExtend => '연장 실패';

  @override
  String get sparkFailedToSend => '전송 실패';

  @override
  String get sparkMessageTooLong => '메시지 너무 길어 (최대 199)';

  @override
  String sparkErrorInitializing(String error) {
    return '채팅 시작 에러: $error';
  }

  @override
  String get sparkUserBanned => '유저 7분 차단';

  @override
  String get sparkRestrictedForBanning => '과도한 차단으로 제한됨';

  @override
  String get sparkReportSubmitted => '신고 제출됨';

  @override
  String get sparkBehaviorRestriction => '부적절한 행동으로 제한됨';

  @override
  String get splashTitlePing => 'PING';

  @override
  String get splashTitleAmpersand => '&';

  @override
  String get splashTitleWink => 'WINK';

  @override
  String get splashTagline => '순간을 SPARK해';

  @override
  String trendsEmotionalPulse(String time) {
    return '감정 펄스 $time';
  }

  @override
  String get trendsTimeMorning => '오늘 아침';

  @override
  String get trendsTimeAfternoon => '오늘 오후';

  @override
  String get trendsTimeEvening => '오늘 저녁';

  @override
  String get trendsTimeLateNight => '늦은 밤';

  @override
  String get trendsActiveVibes => '활성 vibe';

  @override
  String get trendsSparkers => 'PW mates';

  @override
  String get trendsDominantEmotion => '지배적 감정';

  @override
  String trendsPercentOfSparkers(int percent) {
    return '$percent% PW mates';
  }

  @override
  String get trendsEmotionDistribution => '감정 분포';

  @override
  String get trendsQuote1 => '공유된 모든 감정이 연결을 만들어 ✨';

  @override
  String get trendsQuote2 => '함께 감정 지도를 만들어 🗺️';

  @override
  String get trendsQuote3 => '네 vibe가 누군가의 하루를 바꿀 수 있어 💫';

  @override
  String get trendsQuote4 => 'PW chat은 간단한 ping으로 시작해 ⚡';

  @override
  String get banOverlayTitle => '일시 제한';

  @override
  String get banOverlayMessage => 'PW mate가 메시지 부적절하다고 함';

  @override
  String get banOverlayRestrictionInfo => '이 시간 동안 vibe 공유 못해';

  @override
  String get bottomNavMap => '지도';

  @override
  String get bottomNavHistory => '히스토리';

  @override
  String get bottomNavTrends => '트렌드';

  @override
  String get bottomNavSettings => '설정';

  @override
  String get guidelinesTitle => '커뮤니티 가이드라인';

  @override
  String get guidelinesRespectTitle => '존중해';

  @override
  String get guidelinesRespectSubtitle => '모두에게 친절하게';

  @override
  String get guidelinesNoHarassmentTitle => '괴롭힘 금지';

  @override
  String get guidelinesNoHarassmentSubtitle => '부적절한 메시지 보내지 마';

  @override
  String get guidelinesKeepRealTitle => '진짜가 되어';

  @override
  String get guidelinesKeepRealSubtitle => '진짜 vibe만 공유';

  @override
  String get guidelinesHaveFunTitle => '재밌게 놀아';

  @override
  String get guidelinesHaveFunSubtitle => 'PW 연결 즐겨!';

  @override
  String get guidelinesViolationWarning => '위반하면 일시적 또는 영구 제한 받을 수 있어';

  @override
  String get guidelinesButtonUnderstand => '이해했어';

  @override
  String emotionSelectorStreakDay(int day) {
    return '$day일째 - 연속 유지해!';
  }

  @override
  String get emotionSelectorTapYourVibe => '네 VIBE 탭해';

  @override
  String get emotionSelectorWhatsYourVibe => '지금 vibe 뭐야?';

  @override
  String emotionSelectorActiveNow(int count) {
    return '$count명 활성';
  }

  @override
  String get miniBarSendNewPing => '새 ping 보내';

  @override
  String get miniBarPingActive => '네 ping 활성';

  @override
  String get moderationBanTitle => '7분 차단';

  @override
  String get moderationBanSubtitle => '이 유저 일시 제한';

  @override
  String get moderationReportTitle => '신고';

  @override
  String get moderationReportSubtitle => '부적절한 행동 신고';

  @override
  String get moderationEndChatTitle => '채팅 종료';

  @override
  String get moderationEndChatSubtitle => '이 PW 세션 나가기';

  @override
  String get moderationReportDialogTitle => '유저 신고';

  @override
  String get moderationReportReasonHarassment => '괴롭힘';

  @override
  String get moderationReportReasonSpam => '스팸';

  @override
  String get moderationReportReasonHateSpeech => '혐오 발언';

  @override
  String get moderationReportReasonOther => '기타';

  @override
  String get moderationReportSendButton => '신고 보내기';

  @override
  String get pingBottomVibeTooFar => 'Vibe 너무 멀어 (최대 3km)';

  @override
  String get pingBottomVibeTooFarMessage => 'Vibe 너무 멀어 - ping 최대 3km';

  @override
  String get pingBottomTooFar => '너무 멀어';

  @override
  String get pingBottomPing => 'PING';

  @override
  String get pingBottomDistanceVeryClose => '완전 가까움';

  @override
  String pingBottomDistanceMeters(int meters) {
    return '${meters}m';
  }

  @override
  String pingBottomDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get pingBottomTimeNow => '지금';

  @override
  String pingBottomTimeMinutes(int minutes) {
    return '$minutes분';
  }

  @override
  String pingBottomTimeHours(int hours) {
    return '$hours시간';
  }

  @override
  String get vibeAnimBrainEnergy => '빅 브레인 에너지';

  @override
  String get vibeAnimCozy => 'VIBE: 아늑';

  @override
  String get vibeAnimSweatSlay => '땀. 승리. 반복';

  @override
  String get vibeAnimLostInBeat => '비트에 빠짐';

  @override
  String get vibeAnimCityLights => '도시의 불빛';

  @override
  String get vibeAnimLightsCameraVibes => '라이트. 카메라. VIBES.';

  @override
  String get vibeAnimEveningVibes => '저녁 VIBES';

  @override
  String get vibeAnimPartyMode => '파티 모드: ON';

  @override
  String get vibeAnimSubBrainTime => '브레인 타임 🧠';

  @override
  String get vibeAnimSubCaffeine => '카페인 vibes ☕';

  @override
  String get vibeAnimSubNoDaysOff => '쉬는 날 없어 🔥';

  @override
  String get vibeAnimSubVolumeMax => '볼륨: MAX 🎧';

  @override
  String get vibeAnimSubUrbanExplorer => '도시 탐험가 🌃';

  @override
  String get vibeAnimSubCreateGlow => '창작 & 빛나기 📸';

  @override
  String get vibeAnimSubNightFlow => '나이트 플로우 🌙';

  @override
  String get vibeAnimSubUnleashChaos => '카오스 해방 🎉';

  @override
  String get vibeAnimDefaultMessage => 'VIBE 설정됨';

  @override
  String get vibeAnimDefaultSubMessage => '가보자고!';

  @override
  String get viralShareFailed => '공유 실패';

  @override
  String get viralShareTextNight => '다들 자. 근데 뭔가 일어나고 있어\npingandwink.com';

  @override
  String get viralShareTextEvening => '저녁. 최고의 시간\npingandwink.com';

  @override
  String get viralShareTextDefault => '지금 뭐 일어나고 있지?\npingandwink.com';

  @override
  String get viralShareMainText => '이거 읽는 동안\n뭐 일어나고 있지?';

  @override
  String get viralShareFindOut => '알아봐';

  @override
  String get viralShareLogo => 'ping&wink';

  @override
  String get viralShareButton => '공유 →';

  @override
  String winkBannerPing(String distance) {
    return 'PING $distance';
  }

  @override
  String get winkBannerSparkmateWants => 'PW mate가 연결하고 싶어해';

  @override
  String get winkBannerWinkBack => 'WINK BACK';
}
