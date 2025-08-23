/// 📦 User model
class UserModel {
  final String name;
  final String avatarUrl;
  final String joinedDate;
  final String tagline;
  final int reportsSubmitted;
  final int areasSaved;
  final int badgesEarned;
  final double averageRating;
  final int ecoPoints;
  final int leaderboardRank;
  final List<UserBadge> badges;
  final List<Activity> activities;

  UserModel({
    required this.name,
    required this.avatarUrl,
    required this.joinedDate,
    required this.tagline,
    required this.reportsSubmitted,
    required this.areasSaved,
    required this.badgesEarned,
    required this.averageRating,
    required this.ecoPoints,
    required this.leaderboardRank,
    required this.badges,
    required this.activities,
  });

  /// ✅ CopyWith for updates
  UserModel copyWith({
    String? name,
    String? avatarUrl,
    String? joinedDate,
    String? tagline,
    int? reportsSubmitted,
    int? areasSaved,
    int? badgesEarned,
    double? averageRating,
    int? ecoPoints,
    int? leaderboardRank,
    List<UserBadge>? badges,
    List<Activity>? activities,
  }) {
    return UserModel(
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      joinedDate: joinedDate ?? this.joinedDate,
      tagline: tagline ?? this.tagline,
      reportsSubmitted: reportsSubmitted ?? this.reportsSubmitted,
      areasSaved: areasSaved ?? this.areasSaved,
      badgesEarned: badgesEarned ?? this.badgesEarned,
      averageRating: averageRating ?? this.averageRating,
      ecoPoints: ecoPoints ?? this.ecoPoints,
      leaderboardRank: leaderboardRank ?? this.leaderboardRank,
      badges: badges ?? this.badges,
      activities: activities ?? this.activities,
    );
  }

  /// 🏅 Badge logic based on ecoPoints
  List<UserBadge> getUnlockedBadges() {
    List<UserBadge> unlocked = [];

    if (ecoPoints >= 100) {
      unlocked.add(UserBadge("First Steps", "Earned 100+ EcoPoints"));
    }
    if (ecoPoints >= 500) {
      unlocked.add(UserBadge("Eco Helper", "Earned 500+ EcoPoints"));
    }
    if (ecoPoints >= 1000) {
      unlocked.add(UserBadge("Planet Protector", "Earned 1,000+ EcoPoints"));
    }
    if (ecoPoints >= 5000) {
      unlocked.add(UserBadge("Green Guardian", "Earned 5,000+ EcoPoints"));
    }
    if (ecoPoints >= 10000) {
      unlocked.add(UserBadge("Eco Legend", "Earned 10,000+ EcoPoints"));
    }

    return unlocked;
  }
}

/// 🏅 UserBadge class (renamed from Badge)
class UserBadge {
  final String title;
  final String description;

  UserBadge(this.title, this.description);
}

/// 📋 Activity log item
class Activity {
  final String message;
  final String time;

  Activity(this.message, this.time);
}
