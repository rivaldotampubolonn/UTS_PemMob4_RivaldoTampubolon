import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../data/questions_data.dart';

class QuestionProvider extends ChangeNotifier {
  List<QuestionModel> _questions = [];
  int _currentIndex = 0;

  List<QuestionModel> get questions => _questions;
  QuestionModel? get currentQuestion => _questions.isEmpty ? null : _questions[_currentIndex];
  int get currentIndex => _currentIndex;
  bool get hasMoreQuestions => _currentIndex < _questions.length - 1;
  int get totalQuestions => _questions.length;

  void loadQuestions(String difficulty, int count) {
    _questions.clear();
    _currentIndex = 0;
    final allQuestions = QuestionsData.getQuestionsByDifficulty(difficulty);
    allQuestions.shuffle();
    _questions = allQuestions.take(count).toList();
    notifyListeners();
  }

  void nextQuestion() {
    if (hasMoreQuestions) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void reset() {
    _currentIndex = 0;
    _questions.clear();
    notifyListeners();
  }
}