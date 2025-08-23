import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../profile/user_model.dart';
import '../profile/user_provider.dart';

/// Main User Profile Page
class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    final unlockedBadges = user.getUnlockedBadges();

    return Scaffold(
      appBar: AppBar(title: const Text("EcoProfile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                CircleAvatar(
                  radius: isMobile ? 40 : 50,
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
                const SizedBox(height: 12),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Joined ${user.joinedDate}",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.tagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),

                // Impact Snapshot
                isMobile
                    ? _buildSnapshotColumn(user, unlockedBadges.length)
                    : _buildSnapshotRow(user, unlockedBadges.length),

                const SizedBox(height: 32),

                // Leaderboard
                _buildLeaderboard(user),

                const SizedBox(height: 32),

                // Badges
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Earned Badges",
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: unlockedBadges.map((b) => BadgeCard(b)).toList(),
                ),

                const SizedBox(height: 32),

                // Activity
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: user.activities.map((a) => ActivityItem(a)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Snapshot Row (Web)
  Widget _buildSnapshotRow(UserModel user, int badgeCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ImpactStat("Reports Submitted", user.reportsSubmitted.toString()),
        _ImpactStat("Areas Saved", user.areasSaved.toString()),
        _ImpactStat("New Badges", badgeCount.toString()),
        _ImpactStat("Avg. Rating", user.averageRating.toStringAsFixed(1)),
      ],
    );
  }

  // Snapshot Column (Mobile)
  Widget _buildSnapshotColumn(UserModel user, int badgeCount) {
    return Column(
      children: [
        _ImpactStat("Reports Submitted", user.reportsSubmitted.toString()),
        const SizedBox(height: 12),
        _ImpactStat("Areas Saved", user.areasSaved.toString()),
        const SizedBox(height: 12),
        _ImpactStat("New Badges", badgeCount.toString()),
        const SizedBox(height: 12),
        _ImpactStat("Avg. Rating", user.averageRating.toStringAsFixed(1)),
      ],
    );
  }

  // Leaderboard
  Widget _buildLeaderboard(UserModel user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "EcoPoints & Leaderboard",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LeaderboardStat(label: "EcoPoints", value: user.ecoPoints.toString()),
              _LeaderboardStat(label: "Rank", value: "#${user.leaderboardRank}"),
            ],
          ),
        ],
      ),
    );
  }
}

// Supporting widgets

class _ImpactStat extends StatelessWidget {
  final String label;
  final String value;

  const _ImpactStat(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _LeaderboardStat extends StatelessWidget {
  final String label;
  final String value;

  const _LeaderboardStat({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

// BadgeCard
class BadgeCard extends StatelessWidget {
  final UserBadge badge;
  const BadgeCard(this.badge, {super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isMobile ? double.infinity : 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: badge.title,
            child: Icon(_getIcon(badge.title), color: Colors.green, size: 32),
          ),
          const SizedBox(height: 8),
          Text(badge.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text(badge.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains("legend")) return Icons.workspace_premium;
    if (t.contains("guardian")) return Icons.shield;
    if (t.contains("protector")) return Icons.public;
    if (t.contains("helper")) return Icons.handshake;
    return Icons.verified;
  }
}

// Activity Item
class ActivityItem extends StatelessWidget {
  final Activity activity;
  const ActivityItem(this.activity, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.check_circle_outline, color: Colors.green),
      title: Text(activity.message),
      subtitle: Text(activity.time),
    );
  }
}
