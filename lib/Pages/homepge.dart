import 'package:ecopulse/Pages/reportpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/appTheame.dart';
import '../core/responsive.dart';
import '../provider/UI.dart';
import '../widegets/footer.dart';
import '../widegets/navbar.dart';
import '../widegets/ssection-title.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuOpen = ref.watch(menuOpenProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const NavBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      _HeroSection(),
                      SizedBox(height: 60),
                      _FeaturesSection(),
                      SizedBox(height: 60),
                      _ImpactSection(),
                      SizedBox(height: 60),
                      _SuccessStorySection(),
                      SizedBox(height: 60),
                      _CTASection(),
                      Footer(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 🔹 Mobile Drawer
          if (menuOpen && Responsive.isMobile(context))
            Positioned.fill(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    _DrawerItem("Home"),
                    _DrawerItem("Features"),
                    _DrawerItem("Impact"),
                    _DrawerItem("Community"),
                    _DrawerItem("About Us"),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary),
                      onPressed: () {},
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  const _DrawerItem(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
    );
  }
}

// 🔹 HERO
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppTheme.lightBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: isMobile
          ? Column(
        children: [
          _HeroText(),
          const SizedBox(height: 30),
          _HeroImage(),
        ],
      )
          : Row(
        children: [
          Expanded(child: _HeroText()),
          const SizedBox(width: 40),
          Expanded(child: _HeroImage()),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your Voice for a",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Colors.black87)),
        Text("Healthier Planet",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold, color: AppTheme.primary)),
        const SizedBox(height: 20),
        const Text(
          "Report environmental issues, track progress, and earn rewards for your contributions toward a cleaner, greener world.",
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          ),
          // 👇 navigate to ReportPage
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReportPage()),
            );
          },
          child: const Text("Report an Issue",
              style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: const Center(child: Text("📊 Illustration")),
      ),
    );
  }
}

// 🔹 FEATURES
class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (width < 1000) crossAxisCount = 2;
    if (width < 600) crossAxisCount = 1;

    return Column(
      children: [
        const SectionTitle("Empowering Environmental Action"),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.4,
            children: const [
              _FeatureCard(
                  icon: Icons.report,
                  title: "Report Problems",
                  desc: "Capture and share environmental issues easily."),
              _FeatureCard(
                  icon: Icons.track_changes,
                  title: "Track Your Impact",
                  desc: "See how your actions contribute to real change."),
              _FeatureCard(
                  icon: Icons.emoji_events,
                  title: "Earn Eco Rewards",
                  desc: "Gain points, badges, and recognition."),
              _FeatureCard(
                  icon: Icons.groups,
                  title: "Join the Community",
                  desc: "Be part of a global eco movement."),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _FeatureCard(
      {required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppTheme.primary, size: 40),
            const SizedBox(height: 16),
            Text(title,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(desc, style: const TextStyle(fontSize: 14, height: 1.4)),
          ],
        ),
      ),
    );
  }
}

// 🔹 IMPACT
class _ImpactSection extends StatelessWidget {
  const _ImpactSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAF9),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Column(
        children: const [
          SectionTitle("Our Impact in Numbers"),
          SizedBox(height: 30),
          Wrap(
            spacing: 30,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _ImpactCard(value: "5000+", label: "Issues Reported"),
              _ImpactCard(value: "10K+", label: "Meals Saved"),
              _ImpactCard(value: "2000T+", label: "CO₂ Reduced"),
            ],
          )
        ],
      ),
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final String value;
  final String label;

  const _ImpactCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary)),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 SUCCESS STORY
class _SuccessStorySection extends StatelessWidget {
  const _SuccessStorySection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SectionTitle("Success Story Spotlight"),
          const SizedBox(height: 20),
          Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: isMobile
                  ? Column(
                children: const [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=5"),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "“EcoPulse empowered my community to take action! Reporting issues was simple, and seeing them resolved was inspiring.” \n\n- Sarah, Community Leader",
                    style: TextStyle(fontSize: 15, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
                  : Row(
                children: const [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=5"),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "“EcoPulse empowered my community to take action! Reporting issues was simple, and seeing them resolved was inspiring.” \n\n- Sarah, Community Leader",
                      style: TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 CTA
class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const SectionTitle("Ready to Make a Difference?"),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            onPressed: () {
              // 👇 Navigate to ReportPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportPage()),
              );
            },
            child: const Text("Get Started",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
