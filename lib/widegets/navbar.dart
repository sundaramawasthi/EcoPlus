import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/appTheame.dart';
import '../core/responsive.dart';
import '../feed/ReportFeed.dart';
import '../provider/UI.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = Responsive.isMobile(context);
    final menuOpen = ref.watch(menuOpenProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Icon(Icons.eco, color: AppTheme.primary, size: 28),
              const SizedBox(width: 8),
              Text("EcoPulse",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppTheme.primary)),
            ],
          ),
          const Spacer(),
          if (!isMobile) ...[
            _NavItem("Home", onTap: () {}),
            _NavItem("Features", onTap: () {}),
            _NavItem("Impact", onTap: () {}),
            _NavItem("Community", onTap: () {}),
            _NavItem("About Us", onTap: () {}),
            _NavItem("Report Feed", onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportFeedPage()),
              );
            }),
            const SizedBox(width: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.primary)),
              onPressed: () {},
              child: const Text("Login",
                  style: TextStyle(color: AppTheme.primary)),
            ),
          ],
          if (isMobile)
            IconButton(
              icon: Icon(menuOpen ? Icons.close : Icons.menu,
                  color: AppTheme.primary),
              onPressed: () =>
              ref.read(menuOpenProvider.notifier).state = !menuOpen,
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _NavItem(this.label, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
