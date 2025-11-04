class QuestionModel {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswer;
  final String category;
  final String difficulty;
  final String? verse;
  final String? explanation;

  QuestionModel({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.category,
    required this.difficulty,
    this.verse,
    this.explanation,
  });

  bool isCorrect(int selectedAnswer) => selectedAnswer == correctAnswer;
  String get correctAnswerText => options[correctAnswer];
}