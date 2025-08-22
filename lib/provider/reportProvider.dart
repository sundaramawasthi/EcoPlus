import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/commentmodel.dart';
import '../model/report.dart';

final reportListProvider =
StateNotifierProvider<ReportListNotifier, List<ReportModel>>(
      (ref) => ReportListNotifier(),
);

class ReportListNotifier extends StateNotifier<List<ReportModel>> {
  ReportListNotifier() : super([]);

  /// Add a fully constructed report model
  void addReportModel(ReportModel report) {
    if (!state.contains(report)) {
      state = [report, ...state];
    }
  }

  /// Create and add a report from individual fields
  void createReport({
    required double lat,
    required double long,
    required String category,
    required String notes,
    required String status,
    required Uint8List imageBytes,
    required DateTime timestamp,
    String userName = "EcoUser",
    String userAvatarUrl = "",
    int ecoPoints = 50,
    bool isFollowed = false,
  }) {
    final newReport = ReportModel(
      lat: lat,
      long: long,
      category: category,
      notes: notes,
      status: status,
      imageBytes: imageBytes,
      timestamp: timestamp,
      userName: userName,
      userAvatarUrl: userAvatarUrl.isNotEmpty
          ? userAvatarUrl
          : "https://api.dicebear.com/6.x/thumbs/svg?seed=$userName",
      ecoPoints: ecoPoints,
      isFollowed: isFollowed,
    );

    state = [newReport, ...state];
  }

  /// Remove a report
  void removeReport(ReportModel report) {
    state = state.where((r) => r != report).toList();
  }

  /// Generic method to update a single report immutably
  void _updateReport(
      ReportModel report, ReportModel Function(ReportModel) update) {
    state = state.map((r) => r == report ? update(r) : r).toList();
  }

  /// Like a report
  void likeReport(ReportModel report) {
    _updateReport(report, (r) => r.copyWith(likes: r.likes + 1));
  }

  /// Edit a report (notes + status)
  void editReport(ReportModel report,
      {required String notes, required String status}) {
    _updateReport(report, (r) => r.copyWith(notes: notes, status: status));
  }

  /// Add a comment
  void addCommentToReport(
      ReportModel report, {
        required String text,
        String userName = "EcoUser",
        String userAvatarUrl = "",
      }) {
    final comment = CommentModel(
      userName: userName,
      text: text,
      userAvatarUrl: userAvatarUrl.isNotEmpty
          ? userAvatarUrl
          : "https://api.dicebear.com/6.x/thumbs/svg?seed=$userName",
    );

    _updateReport(report, (r) => r.copyWith(comments: [...r.comments, comment]));
  }

  /// Toggle follow/unfollow
  void toggleFollow(ReportModel report) {
    _updateReport(report, (r) => r.copyWith(isFollowed: !r.isFollowed));
  }
}
