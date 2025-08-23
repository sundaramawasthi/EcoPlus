import 'package:flutter/material.dart';

class ActivityTable extends StatelessWidget {
  const ActivityTable({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    final activities = [
      ["Food Bank", "GoodHeart Org", "75kg", "2025-08-19"],
      ["Green Store", "Local Shelter", "20kg", "2025-08-18"],
      ["Donation Drive", "Youth Volunteers", "150kg", "2025-08-17"],
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Activities",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            /// Mobile Layout (Vertical List)
            if (isMobile)
              Column(
                children: activities.map((activity) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Donor: ${activity[0]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Receiver: ${activity[1]}"),
                        Text("Quantity: ${activity[2]}"),
                        Text("Date: ${activity[3]}"),
                      ],
                    ),
                  );
                }).toList(),
              ),

            /// Desktop Layout (Table)
            if (!isMobile)
              DataTable(
                columns: const [
                  DataColumn(label: Text("Donor")),
                  DataColumn(label: Text("Receiver")),
                  DataColumn(label: Text("Quantity")),
                  DataColumn(label: Text("Date")),
                ],
                rows: activities
                    .map(
                      (e) => DataRow(cells: [
                    DataCell(Text(e[0])),
                    DataCell(Text(e[1])),
                    DataCell(Text(e[2])),
                    DataCell(Text(e[3])),
                  ]),
                )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
