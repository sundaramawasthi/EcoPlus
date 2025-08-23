import 'package:flutter/material.dart';
import '../profile/user_model.dart';

class BadgeCard extends StatelessWidget {
  final UserBadge badge; // Use your UserBadge class
  const BadgeCard(this.badge, {super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isMobile ? double.infinity : 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: badge.title,
            child: Icon(
              _getIcon(badge.title),
              color: Colors.green,
              size: isMobile ? 28 : 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            badge.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 14 : 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            badge.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 10 : 12,
              color: Colors.grey.shade700,
            ),
          ),
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
    return Icons.verified; // default icon
  }
}
