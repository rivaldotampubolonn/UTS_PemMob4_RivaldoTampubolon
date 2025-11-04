class AppConstants {
  static const String appName = 'Valor of Scripture';
  static const String appTagline = 'Rise as a Knight of Faith';

  // Quiz Settings
  static const int questionsPerQuiz = 10;
  static const int timePerQuestionSeconds = 30;
  static const int baseScorePerQuestion = 100;
  static const int hardModeMultiplier = 2;
  static const int timeBonusPerSecond = 5;

  // Attack on Titan Inspired Ranks
  static const Map<String, int> rankThresholds = {
    'Cadet': 0,
    'Scout': 500,
    'Garrison Soldier': 1000,
    'Squad Leader': 2000,
    'Section Commander': 5000,
    'Commander': 10000,
    'Humanity\'s Shield': 20000,
    'The Last Vanguard': 50000,
  };

  // Difficulty Levels
  static const String difficultyEasy = 'easy';
  static const String difficultyNormal = 'normal';
  static const String difficultyHard = 'hard';

  // Animation Durations
  static const Duration splashDuration = Duration(seconds: 3);

  // Spacing
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;

  // SharedPreferences Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyUsername = 'username';
  static const String keyTotalScore = 'total_score';
  static const String keyGamesPlayed = 'games_played';
  static const String keyBestScore = 'best_score';
  static const String keyCurrentRank = 'current_rank';
}