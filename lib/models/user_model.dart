class UserModel {
  final String username;
  final int totalScore;
  final int gamesPlayed;
  final int bestScore;
  final String rank;
  final DateTime? lastPlayed;

  UserModel({
    required this.username,
    required this.totalScore,
    required this.gamesPlayed,
    required this.bestScore,
    required this.rank,
    this.lastPlayed,
  });

  UserModel copyWith({
    String? username,
    int? totalScore,
    int? gamesPlayed,
    int? bestScore,
    String? rank,
    DateTime? lastPlayed,
  }) {
    return UserModel(
      username: username ?? this.username,
      totalScore: totalScore ?? this.totalScore,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      bestScore: bestScore ?? this.bestScore,
      rank: rank ?? this.rank,
      lastPlayed: lastPlayed ?? this.lastPlayed,
    );
  }
}