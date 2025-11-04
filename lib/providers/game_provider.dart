import 'package:flutter/material.dart';
import '../models/game_result_model.dart';
import '../config/app_constants.dart';

class GameProvider extends ChangeNotifier {
  int _currentScore = 0;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  bool _isGameActive = false;
  String _difficulty = 'normal';
  DateTime? _gameStartTime;

  int get currentScore => _currentScore;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get correctAnswers => _correctAnswers;
  bool get isGameActive => _isGameActive;

  void startGame(String difficulty) {
    _difficulty = difficulty;
    _currentScore = 0;
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _isGameActive = true;
    _gameStartTime = DateTime.now();
    notifyListeners();
  }

  void answerQuestion(bool isCorrect, int timeRemaining) {
    if (isCorrect) {
      _correctAnswers++;
      int baseScore = AppConstants.baseScorePerQuestion;
      if (_difficulty == AppConstants.difficultyHard) {
        baseScore *= AppConstants.hardModeMultiplier;
      }
      _currentScore += baseScore + (timeRemaining * AppConstants.timeBonusPerSecond);
    } else {
      _wrongAnswers++;
    }
    _currentQuestionIndex++;
    notifyListeners();
  }

  GameResultModel endGame(int totalQuestions) {
    _isGameActive = false;
    final totalTime = _gameStartTime != null
        ? DateTime.now().difference(_gameStartTime!).inSeconds
        : 0;

    final result = GameResultModel(
      score: _currentScore,
      totalQuestions: totalQuestions,
      correctAnswers: _correctAnswers,
      wrongAnswers: _wrongAnswers,
      difficulty: _difficulty,
      completedAt: DateTime.now(),
      totalTimeSeconds: totalTime,
    );
    notifyListeners();
    return result;
  }
}
