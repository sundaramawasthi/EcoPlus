import 'package:ecopulse/foodrescue/stat_card.dart';
import 'package:flutter/material.dart';

import 'active table.dart';
import 'chart.dart';

class FoodRescueDashboard extends StatelessWidget {
  const FoodRescueDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Rescue Impact & Operations'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO STATS
            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Our Collective Impact",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Together, we’re making a significant difference..."),
                    SizedBox(height: 20),
                    Text(
                      "1,254,890 Meals Saved",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ACTION CARDS
            isMobile
                ? Column(
              children: [
                StatCard(
                  icon: Icons.fastfood,
                  title: "Offer Surplus Food",
                  description: "Submit extra food from your kitchen or event.",
                  buttonText: "Post Donation",
                ),
                const SizedBox(height: 16),
                StatCard(
                  icon: Icons.volunteer_activism,
                  title: "Donate Available Donations",
                  description: "Help transport and donate listed food donations.",
                  buttonText: "Find Food",
                ),
              ],
            )
                : Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.fastfood,
                    title: "Offer Surplus Food",
                    description: "Submit extra food from your kitchen or event.",
                    buttonText: "Post Donation",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    icon: Icons.volunteer_activism,
                    title: "Donate Available Donations",
                    description: "Help transport and donate listed food donations.",
                    buttonText: "Find Food",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ACTIVITY TABLE
            const ActivityTable(),

            const SizedBox(height: 24),

            // CHARTS
            isMobile
                ? Column(
              children: const [
                MealsOverTimeChart(),
                SizedBox(height: 16),
                DonationCategoryChart(),
              ],
            )
                : Row(
              children: const [
                Expanded(child: MealsOverTimeChart()),
                SizedBox(width: 16),
                Expanded(child: DonationCategoryChart()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
