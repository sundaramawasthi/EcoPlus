import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MealsOverTimeChart extends StatelessWidget {
  const MealsOverTimeChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            const Text(
              "Meals Saved Over Time",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: isMobile ? 1.2 : 2.0,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 1500,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, _) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Day ${value.toInt()}",
                                style: const TextStyle(fontSize: 10)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, _) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.green,
                      dotData: FlDotData(show: true),
                      spots: const [
                        FlSpot(1, 100),
                        FlSpot(2, 300),
                        FlSpot(3, 600),
                        FlSpot(4, 1000),
                        FlSpot(5, 1300),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonationCategoryChart extends StatelessWidget {
  const DonationCategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            const Text(
              "Donation Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: isMobile ? 1.2 : 1.6,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      color: Colors.green,
                      title: "Produce",
                      titleStyle: const TextStyle(fontSize: 12),
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.orange,
                      title: "Bakery",
                      titleStyle: const TextStyle(fontSize: 12),
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.blue,
                      title: "Packaged",
                      titleStyle: const TextStyle(fontSize: 12),
                    ),
                    PieChartSectionData(
                      value: 10,
                      color: Colors.teal,
                      title: "Dairy",
                      titleStyle: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
