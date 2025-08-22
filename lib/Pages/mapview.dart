import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import '../provider/reportProvider.dart';
import 'custom nav bar.dart';
import '../widegets/footer.dart';

class MapViewPage extends ConsumerStatefulWidget {
  const MapViewPage({super.key});

  @override
  ConsumerState<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends ConsumerState<MapViewPage> {
  String? selectedCategory;
  String? selectedStatus;

  final MapController _mapController = MapController();
  final PopupController _popupController = PopupController();

  void _applyFilters() {
    setState(() {});
    _fitMapToMarkers();
  }

  void _fitMapToMarkers() {
    final reports = ref.read(reportListProvider);
    final filtered = reports.where((report) {
      final matchCategory =
          selectedCategory == null || report.category == selectedCategory;
      final matchStatus =
          selectedStatus == null || report.status == selectedStatus;
      return matchCategory && matchStatus;
    }).toList();

    if (filtered.isEmpty) return;

    final bounds = LatLngBounds(
      LatLng(filtered.map((r) => r.lat).reduce((a, b) => a < b ? a : b),
          filtered.map((r) => r.long).reduce((a, b) => a < b ? a : b)),
      LatLng(filtered.map((r) => r.lat).reduce((a, b) => a > b ? a : b),
          filtered.map((r) => r.long).reduce((a, b) => a > b ? a : b)),
    );

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: EdgeInsets.all(50),
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(reportListProvider);

    final filteredReports = reports.where((report) {
      final matchCategory =
          selectedCategory == null || report.category == selectedCategory;
      final matchStatus =
          selectedStatus == null || report.status == selectedStatus;
      return matchCategory && matchStatus;
    }).toList();

    final markers = filteredReports.map((report) {
      Color markerColor;
      switch (report.status) {
        case "Open":
          markerColor = Colors.red;
          break;
        case "In Progress":
          markerColor = Colors.orange;
          break;
        case "Resolved":
          markerColor = Colors.green;
          break;
        default:
          markerColor = Colors.blue;
      }

      return Marker(
        point: LatLng(report.lat, report.long),
        width: 40,
        height: 40,
        child: Icon(
          Icons.location_on,
          size: 30,
          color: markerColor,
        ),
      );
    }).toList();

    final initialCenter = filteredReports.isNotEmpty
        ? LatLng(filteredReports.first.lat, filteredReports.first.long)
        : const LatLng(28.6139, 77.2090);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const NavBarhome(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filters
                      Container(
                        width: 250,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Filter Reports",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text("Category"),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedCategory,
                              hint: const Text("Select a category"),
                              items: const [
                                DropdownMenuItem(
                                    value: "Food Waste",
                                    child: Text("🍲 Food Waste")),
                                DropdownMenuItem(
                                    value: "Water Pollution",
                                    child: Text("💧 Water Pollution")),
                                DropdownMenuItem(
                                    value: "Climate Issue",
                                    child: Text("🌳 Climate Issue")),
                              ],
                              onChanged: (val) =>
                                  setState(() => selectedCategory = val),
                            ),
                            const SizedBox(height: 20),
                            const Text("Status"),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedStatus,
                              hint: const Text("Select a status"),
                              items: const [
                                DropdownMenuItem(
                                    value: "Open", child: Text("🟢 Open")),
                                DropdownMenuItem(
                                    value: "In Progress",
                                    child: Text("🟡 In Progress")),
                                DropdownMenuItem(
                                    value: "Resolved",
                                    child: Text("✅ Resolved")),
                              ],
                              onChanged: (val) =>
                                  setState(() => selectedStatus = val),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _applyFilters,
                                child: const Text("Apply Filters"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),

                      // Map
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 500,
                            child: PopupScope(
                              child: FlutterMap(
                                mapController: _mapController,
                                options: MapOptions(
                                  initialCenter: initialCenter,
                                  initialZoom: 5,
                                  minZoom: 3,
                                  maxZoom: 18,
                                  onTap: (_, __) =>
                                      _popupController.hideAllPopups(),
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                    "https://api.maptiler.com/maps/satellite/{z}/{x}/{y}.jpg?key=6Ot4A3N4zeXMf96MDzfS",
                                    userAgentPackageName: 'com.example.app',
                                  ),

                                  MarkerClusterLayerWidget(
                                    options: MarkerClusterLayerOptions(
                                      maxClusterRadius: 45,
                                      size: const Size(40, 40),
                                      markers: markers,
                                      builder: (context, cluster) =>
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue.shade600,
                                            ),
                                            child: Text(
                                              cluster.length.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                      popupOptions: PopupOptions(
                                        popupController: _popupController,
                                        popupBuilder:
                                            (BuildContext context, Marker marker) {
                                          return Card(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      "Lat: ${marker.point.latitude.toStringAsFixed(5)}"),
                                                  Text(
                                                      "Lng: ${marker.point.longitude.toStringAsFixed(5)}"),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
