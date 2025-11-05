import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../config/app_constants.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    username: 'Knight',
    totalScore: 0,
    gamesPlayed: 0,
    bestScore: 0,
    rank: 'Cadet',
  );

  UserModel get user => _user;

  UserProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _user = UserModel(
        username: prefs.getString(AppConstants.keyUsername) ?? 'Knight',
        totalScore: prefs.getInt(AppConstants.keyTotalScore) ?? 0,
        gamesPlayed: prefs.getInt(AppConstants.keyGamesPlayed) ?? 0,
        bestScore: prefs.getInt(AppConstants.keyBestScore) ?? 0,
        rank: prefs.getString(AppConstants.keyCurrentRank) ?? 'Cadet',
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<void> _saveUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUsername, _user.username);
      await prefs.setInt(AppConstants.keyTotalScore, _user.totalScore);
      await prefs.setInt(AppConstants.keyGamesPlayed, _user.gamesPlayed);
      await prefs.setInt(AppConstants.keyBestScore, _user.bestScore);
      await prefs.setString(AppConstants.keyCurrentRank, _user.rank);
    } catch (e) {
      debugPrint('Error saving user: $e');
    }
  }

  Future<void> updateUsername(String name) async {
    _user = _user.copyWith(username: name);
    notifyListeners();
    await _saveUserData();
  }

  Future<void> addGameResult(int score) async {
    final newTotalScore = _user.totalScore + score;
    final newGamesPlayed = _user.gamesPlayed + 1;
    final newBestScore = score > _user.bestScore ? score : _user.bestScore;
    final newRank = _calculateRank(newTotalScore);

    _user = _user.copyWith(
      totalScore: newTotalScore,
      gamesPlayed: newGamesPlayed,
      bestScore: newBestScore,
      rank: newRank,
      lastPlayed: DateTime.now(),
    );
    notifyListeners();
    await _saveUserData();
  }

  String _calculateRank(int totalScore) {
    String currentRank = 'Cadet';
    AppConstants.rankThresholds.forEach((rank, threshold) {
      if (totalScore >= threshold) currentRank = rank;
    });
    return currentRank;
  }

  Map<String, dynamic> getNextRankInfo() {
    final ranks = AppConstants.rankThresholds.entries.toList();
    final currentIndex = ranks.indexWhere((e) => e.key == _user.rank);

    if (currentIndex == -1 || currentIndex >= ranks.length - 1) {
      return {'nextRank': 'Max Rank', 'scoreNeeded': 0, 'progress': 1.0};
    }

    final nextRank = ranks[currentIndex + 1];
    final currentThreshold = ranks[currentIndex].value;
    final nextThreshold = nextRank.value;
    final progress = (_user.totalScore - currentThreshold) / (nextThreshold - currentThreshold);

    return {
      'nextRank': nextRank.key,
      'scoreNeeded': nextThreshold - _user.totalScore,
      'progress': progress.clamp(0.0, 1.0),
    };
  }

  Future<void> resetProgress() async {
    _user = UserModel(
      username: _user.username, // Keep username
      totalScore: 0,
      gamesPlayed: 0,
      bestScore: 0,
      rank: 'Cadet',
    );
    notifyListeners();
    await _saveUserData();
  }
}