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
    rank: 'Recruit',
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
        rank: prefs.getString(AppConstants.keyCurrentRank) ?? 'Recruit',
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user data: $e');
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
      debugPrint('Error saving user data: $e');
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
    String currentRank = 'Recruit';

    AppConstants.rankThresholds.forEach((rank, threshold) {
      if (totalScore >= threshold) {
        currentRank = rank;
      }
    });

    return currentRank;
  }

  Map<String, dynamic> getNextRankInfo() {
    final ranks = AppConstants.rankThresholds.entries.toList();
    final currentRankIndex = ranks.indexWhere((e) => e.key == _user.rank);

    if (currentRankIndex == -1 || currentRankIndex >= ranks.length - 1) {
      return {
        'nextRank': 'Max Rank',
        'scoreNeeded': 0,
        'progress': 1.0,
      };
    }

    final nextRank = ranks[currentRankIndex + 1];
    final currentThreshold = ranks[currentRankIndex].value;
    final nextThreshold = nextRank.value;
    final scoreNeeded = nextThreshold - _user.totalScore;
    final progress = (_user.totalScore - currentThreshold) /
        (nextThreshold - currentThreshold);

    return {
      'nextRank': nextRank.key,
      'scoreNeeded': scoreNeeded,
      'progress': progress.clamp(0.0, 1.0),
    };
  }

  Future<void> resetUserData() async {
    _user = UserModel(
      username: 'Knight',
      totalScore: 0,
      gamesPlayed: 0,
      bestScore: 0,
      rank: 'Recruit',
    );
    notifyListeners();
    await _saveUserData();
  }
}