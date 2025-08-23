import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/appTheame.dart';
import '../core/responsive.dart';
import '../feed/ReportFeed.dart';
import '../login and signup/login.dart';
import '../provider/UI.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = Responsive.isMobile(context);
    final menuOpen = ref.watch(menuOpenProvider);

    void closeMenu() {
      if (isMobile) ref.read(menuOpenProvider.notifier).state = false;
    }

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

              if (!isMobile) ...[
                _NavItem("Home", onTap: () {}),
                SizedBox(width: 10,),
                _NavItem("Features", onTap: () {}),
                SizedBox(width: 10,),
                _NavItem("Contact us", onTap: () {}),
                SizedBox(width: 10,),
                _NavItem("Community", onTap: () {}),
                SizedBox(width: 10,),
                _NavItem("About Us", onTap: () {}),
                SizedBox(width: 10,),
                _NavItem("Report Feed", onTap: () {}),
                const SizedBox(width: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppTheme.primary),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  child: const Text("Login",
                      style: TextStyle(color: AppTheme.primary)),
                ),
              ],

              if (isMobile)
                IconButton(
                  icon: Icon(menuOpen ? Icons.close : Icons.menu,
                      color: AppTheme.primary),
                  onPressed: () {
                    ref.read(menuOpenProvider.notifier).state = !menuOpen;
                  },
                ),
            ],
          ),
        ),

        /// Mobile dropdown menu
        if (isMobile && menuOpen)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NavItem("Home", onTap: closeMenu),
                _NavItem("Features", onTap: closeMenu),
                _NavItem("Impact", onTap: closeMenu),
                _NavItem("Community", onTap: closeMenu),
                _NavItem("About Us", onTap: closeMenu),
                _NavItem("Report Feed", onTap: closeMenu),
                const SizedBox(height: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppTheme.primary),
                  ),
                  onPressed: () {
                    closeMenu();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  child: const Text("Login",
                      style: TextStyle(color: AppTheme.primary)),
                ),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
