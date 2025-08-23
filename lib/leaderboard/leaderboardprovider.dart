import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../profile/user_model.dart';

final leaderboardProvider =
StateNotifierProvider<LeaderboardNotifier, List<UserModel>>((ref) {
  return LeaderboardNotifier();
});

class LeaderboardNotifier extends StateNotifier<List<UserModel>> {
  LeaderboardNotifier() : super([]);

  /// Add new user if not already present (case-insensitive)
  void addUser(UserModel user) {
    final alreadyExists = state.any(
          (u) => u.name.toLowerCase() == user.name.toLowerCase(),
    );

    if (!alreadyExists) {
      state = [...state, user];
      _updateRankings();
    }
  }

  /// Update EcoPoints; add if user not present
  void updateUserPoints(String name, int ecoPoints) {
    bool found = false;

    final updated = state.map((user) {
      if (user.name.toLowerCase() == name.toLowerCase()) {
        found = true;
        return user.copyWith(ecoPoints: ecoPoints);
      }
      return user;
    }).toList();

    if (!found) {
      updated.add(
        UserModel(
          name: name,
          avatarUrl: 'https://i.pravatar.cc/150?u=$name',
          joinedDate: 'Unknown',
          tagline: '',
          reportsSubmitted: 0,
          areasSaved: 0,
          badgesEarned: 0,
          averageRating: 0,
          ecoPoints: ecoPoints,
          leaderboardRank: 0,
          badges: [],
          activities: [],
        ),
      );
    }

    state = updated;
    _updateRankings();
  }

  /// Recalculate ranks based on ecoPoints
  void _updateRankings() {
    final sorted = [...state]..sort((a, b) => b.ecoPoints.compareTo(a.ecoPoints));

    state = [
      for (int i = 0; i < sorted.length; i++)
        sorted[i].copyWith(leaderboardRank: i + 1),
    ];
  }

  /// Optional: refresh manually
  void refresh() {
    _updateRankings();
  }

  /// Optional: remove user by name
  void removeUser(String name) {
    state = state.where((u) => u.name.toLowerCase() != name.toLowerCase()).toList();
    _updateRankings();
  }

  /// Optional: clear all (reset)
  void clearLeaderboard() {
    state = [];
  }
}
