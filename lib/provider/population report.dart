import 'package:flutter_riverpod/flutter_riverpod.dart';

class PollutionReport {
  final double latitude;
  final double longitude;
  final String category;
  final String status;

  PollutionReport({
    required this.latitude,
    required this.longitude,
    required this.category,
    this.status = "Open",
  });
}

final pollutionReportsProvider = StateProvider<List<PollutionReport>>((ref) => []);
