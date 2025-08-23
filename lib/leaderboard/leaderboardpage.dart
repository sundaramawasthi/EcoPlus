import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'leaderboardprovider.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboard = ref.watch(leaderboardProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(title: const Text("Leaderboard")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: isMobile
            ? ListView.builder(
          itemCount: leaderboard.length,
          itemBuilder: (context, index) {
            return _buildLeaderboardTile(leaderboard[index], index);
          },
        )
            : Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: GridView.builder(
              itemCount: leaderboard.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return _buildLeaderboardTile(leaderboard[index], index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardTile(user, int index) {
    final rank = index + 1;
    String rankEmoji = '';
    if (rank == 1) rankEmoji = '🥇';
    else if (rank == 2) rankEmoji = '🥈';
    else if (rank == 3) rankEmoji = '🥉';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("EcoPoints: ${user.ecoPoints}"),
        trailing: Text(
          "$rankEmoji #${user.leaderboardRank}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
