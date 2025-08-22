import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/report.dart';
import '../provider/reportProvider.dart';
import 'Edit.dart';
import 'categoryDropdown.dart';
import 'reportCard.dart';

class ReportFeedPage extends ConsumerStatefulWidget {
  const ReportFeedPage({super.key});

  @override
  ConsumerState<ReportFeedPage> createState() => _ReportFeedPageState();
}

class _ReportFeedPageState extends ConsumerState<ReportFeedPage> {
  String? selectedCategory;
  String? selectedStatus;
  String selectedSort = "Latest";

  List<ReportModel> getFilteredReports(List<ReportModel> reports) {
    var filtered = reports;

    if (selectedCategory != null) {
      filtered = filtered.where((r) => r.category == selectedCategory).toList();
    }
    if (selectedStatus != null) {
      filtered = filtered.where((r) => r.status == selectedStatus).toList();
    }

    filtered.sort((a, b) =>
    selectedSort == "Latest"
        ? b.timestamp.compareTo(a.timestamp)
        : a.timestamp.compareTo(b.timestamp));

    return filtered;
  }

  void clearFilters() {
    setState(() {
      selectedCategory = null;
      selectedStatus = null;
      selectedSort = "Latest";
    });
  }

  void toggleFollow(ReportModel report) {
    ref.read(reportListProvider.notifier).toggleFollow(report);
  }

  void openDetailModal(ReportModel report) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: SingleChildScrollView(
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(report.userAvatarUrl),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(report.userName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("🌱 ${report.ecoPoints} EcoPoints",
                                style: const TextStyle(color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => toggleFollow(report),
                        style: TextButton.styleFrom(
                          backgroundColor: report.isFollowed
                              ? Colors.green.shade100
                              : Colors.green.shade50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          foregroundColor: Colors.green,
                        ),
                        child: Text(report.isFollowed ? "Following" : "Follow"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Image.memory(report.imageBytes, fit: BoxFit.cover),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text(report.category),
                        avatar: Text(report.categoryIcon),
                        backgroundColor: Colors.grey.shade100,
                      ),
                      Chip(
                        label: Text(report.status),
                        avatar: Text(report.statusEmoji),
                        backgroundColor: Colors.grey.shade100,
                      ),
                      Chip(
                        label: Text("📍 ${report.lat.toStringAsFixed(3)}, ${report.long.toStringAsFixed(3)}"),
                        backgroundColor: Colors.grey.shade100,
                      ),
                      Chip(
                        label: Text("🕒 ${report.timestamp.toLocal().toString().split('.')[0]}"),
                        backgroundColor: Colors.grey.shade100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(report.notes, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(reportListProvider);
    final filteredReports = getFilteredReports(reports);
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("EcoPulse"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 24 : 16, vertical: isWide ? 16 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Report Feed",
                      style: TextStyle(
                          fontSize: isWide ? 28 : 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(
                    "Explore environmental issues reported by the community. Like, comment, and help build a cleaner future.",
                    style: TextStyle(
                        fontSize: isWide ? 15 : 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: isWide ? 200 : screenWidth * 0.4,
                        child: CategoryDropdown(
                          selected: selectedCategory,
                          onChanged: (val) => setState(() => selectedCategory = val),
                        ),
                      ),
                      SizedBox(
                        width: isWide ? 200 : screenWidth * 0.4,
                        child: StatusDropdown(
                          selected: selectedStatus,
                          onChanged: (val) => setState(() => selectedStatus = val),
                        ),
                      ),
                      SizedBox(
                        width: isWide ? 200 : screenWidth * 0.4,
                        child: SortDropdown(
                          selected: selectedSort,
                          onChanged: (val) => setState(() => selectedSort = val),
                        ),
                      ),
                      TextButton(onPressed: clearFilters, child: const Text("Clear")),
                    ],
                  ),
                  const SizedBox(height: 24),
                  filteredReports.isEmpty
                      ? Center(child: Text("No reports found."))
                      : SizedBox(
                    height: isWide ? 520 : 420,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredReports.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        final report = filteredReports[index];
                        return SizedBox(
                          width: isWide ? 400 : screenWidth * 0.8,
                          child: ReportCard(
                            report: report,
                            onLike: () {
                              ref.read(reportListProvider.notifier).likeReport(report);
                            },
                            onEdit: () {
                              showDialog(
                                context: context,
                                builder: (_) => EditReportDialog(report: report),
                              );
                            },
                            onDelete: () {
                              ref.read(reportListProvider.notifier).removeReport(report);
                            },
                            onFollowToggle: () => toggleFollow(report),
                            onViewDetail: () => openDetailModal(report),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.green.shade200,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              children: const [
                Text("© 2025 EcoPulse", style: TextStyle(color: Colors.white)),
                SizedBox(height: 4),
                Text("Building a cleaner future together",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
