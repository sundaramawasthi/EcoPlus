import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/appTheame.dart';
import '../core/responsive.dart';
import '../feed/ReportFeed.dart';
import '../provider/UI.dart';
import 'mapview.dart'; // ✅ Import your Map View page

class NavBarhome extends ConsumerWidget {
  const NavBarhome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = Responsive.isMobile(context);
    final menuOpen = ref.watch(menuOpenProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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

              // Desktop Nav Items
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
                _NavItem("Map View", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapViewPage()),
                  );
                }),
              ],

              // Mobile Burger Icon
              if (isMobile)
                IconButton(
                  icon: Icon(menuOpen ? Icons.close : Icons.menu,
                      color: AppTheme.primary),
                  onPressed: () => ref.read(menuOpenProvider.notifier).state = !menuOpen,
                ),
            ],
          ),
        ),

        // Mobile Nav Items (Collapsed List)
        if (isMobile && menuOpen)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                _NavItem("Map View", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapViewPage()),
                  );
                }),
              ],
            ),
          ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
