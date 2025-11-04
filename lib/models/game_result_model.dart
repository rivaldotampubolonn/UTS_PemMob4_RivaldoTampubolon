class GameResultModel {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final String difficulty;
  final DateTime completedAt;
  final int totalTimeSeconds;

  GameResultModel({
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.difficulty,
    required this.completedAt,
    required this.totalTimeSeconds,
  });

  double get accuracy {
    if (totalQuestions == 0) return 0.0;
    return (correctAnswers / totalQuestions) * 100;
  }

  String get performanceRating {
    if (accuracy >= 90) return 'Legendary';
    if (accuracy >= 80) return 'Excellent';
    if (accuracy >= 70) return 'Great';
    if (accuracy >= 60) return 'Good';
    if (accuracy >= 50) return 'Fair';
    return 'Keep Training';
  }
}