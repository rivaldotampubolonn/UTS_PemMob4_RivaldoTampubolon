class AppConstants {

  static const String appName = 'Valor of Scripture';
  static const String appTagline = 'Rise as a Knight of Faith';
  static const String version = '1.0.0';


  static const int questionsPerQuiz = 10;
  static const int timePerQuestionSeconds = 30;
  static const int baseScorePerQuestion = 100;
  static const int hardModeMultiplier = 2;
  static const int timeBonusPerSecond = 5;


  static const Map<String, int> rankThresholds = {
    'Recruit': 0,
    'Squire': 500,
    'Knight': 1000,
    'Veteran Knight': 2000,
    'Elite Knight': 5000,
    'Master Knight': 10000,
    'Legendary Knight': 20000,
    'Divine Paladin': 50000,
  };


  static const String difficultyEasy = 'easy';
  static const String difficultyNormal = 'normal';
  static const String difficultyHard = 'hard';


  static const String categoryOldTestament = 'Perjanjian Lama';
  static const String categoryNewTestament = 'Perjanjian Baru';
  static const String categoryGospels = 'Injil';
  static const String categoryProphets = 'Nabi-nabi';
  static const String categoryWisdom = 'Hikmat';
  static const String categoryHistory = 'Sejarah';


  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration fadeAnimationDuration = Duration(milliseconds: 500);
  static const Duration slideAnimationDuration = Duration(milliseconds: 300);


  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;


  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;


  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;


  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  static const double iconSizeXXL = 64.0;


  static const String keyThemeMode = 'theme_mode';
  static const String keyUsername = 'username';
  static const String keyTotalScore = 'total_score';
  static const String keyGamesPlayed = 'games_played';
  static const String keyBestScore = 'best_score';
  static const String keyCurrentRank = 'current_rank';
}