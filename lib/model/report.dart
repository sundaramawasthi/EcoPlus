import 'dart:typed_data';
import 'commentmodel.dart';

class ReportModel {
  final double lat;
  final double long;
  final String category;
  final String notes;
  final String status;
  final Uint8List imageBytes;
  final DateTime timestamp;
  final String userName;
  final String userAvatarUrl;
  final int ecoPoints;
  final bool isFollowed;
  final int likes;
  final List<CommentModel> comments;

  ReportModel({
    required this.lat,
    required this.long,
    required this.category,
    required this.notes,
    required this.status,
    required this.imageBytes,
    required this.timestamp,
    required this.userName,
    required this.userAvatarUrl,
    this.ecoPoints = 50,
    this.isFollowed = false,
    this.likes = 0,
    List<CommentModel>? comments,
  }) : comments = comments ?? [];

  /// ✨ Add category emoji based on category string
  String get categoryIcon {
    switch (category.toLowerCase()) {
      case 'litter':
        return '🚯';
      case 'air pollution':
        return '🌫️';
      case 'water pollution':
        return '🌊';
      case 'deforestation':
        return '🌳';
      case 'climate':
        return '🌡️';
      case 'noise':
        return '🔊';
      case 'wildlife':
        return '🦉';
      case 'recycling':
        return '♻️';
      case 'energy':
        return '⚡';
      default:
        return '🌍';
    }
  }

  /// Optional: add status emoji if not already
  String get statusEmoji {
    switch (status.toLowerCase()) {
      case 'open':
        return '🟢';
      case 'in progress':
        return '🟡';
      case 'resolved':
        return '✅';
      default:
        return '❓';
    }
  }

  /// 📦 For immutability
  ReportModel copyWith({
    double? lat,
    double? long,
    String? category,
    String? notes,
    String? status,
    Uint8List? imageBytes,
    DateTime? timestamp,
    String? userName,
    String? userAvatarUrl,
    int? ecoPoints,
    bool? isFollowed,
    int? likes,
    List<CommentModel>? comments,
  }) {
    return ReportModel(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      imageBytes: imageBytes ?? this.imageBytes,
      timestamp: timestamp ?? this.timestamp,
      userName: userName ?? this.userName,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      ecoPoints: ecoPoints ?? this.ecoPoints,
      isFollowed: isFollowed ?? this.isFollowed,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
