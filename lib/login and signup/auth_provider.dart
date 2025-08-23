import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../profile/user_model.dart';

class AuthNotifier extends StateNotifier<UserModel?> {
  AuthNotifier() : super(null);

  /// Simulated login/signup
  void login(String email, String password) {
    state = UserModel(
      name: "EcoWarrior Emily",
      avatarUrl: "https://i.pravatar.cc/150?img=5",
      joinedDate: "January 2024",
      tagline: "A force for change!",
      reportsSubmitted: 128,
      areasSaved: 530,
      badgesEarned: 14,
      averageRating: 6.7,
      ecoPoints: 15234,
      leaderboardRank: 345,
      badges: [
        UserBadge("First Reporter", "Submitted your first report"),
        UserBadge("Water Guardian", "Reported water pollution 5 times"),
        UserBadge("Planet Saver", "Saved 10+ areas from damage"),
        UserBadge("Climate Champion", "Active for 6+ months"),
        UserBadge("Community Builder", "5 followers gained"),
      ],
      activities: [
        Activity("You submitted a report on Plastic Waste", "2 hours ago"),
        Activity("You earned the Planet Saver badge", "1 day ago"),
        Activity("You saved a polluted area", "3 days ago"),
        Activity("You followed EcoWarrior123", "5 days ago"),
      ],
    );
  }

  /// Simulated logout
  void logout() {
    state = null;
  }
}

/// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>(
      (ref) => AuthNotifier(),
);
