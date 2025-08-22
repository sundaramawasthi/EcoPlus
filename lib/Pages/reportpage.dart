import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../provider/reportProvider.dart';
import 'custom nav bar.dart';

class ReportPage extends ConsumerStatefulWidget {
  const ReportPage({super.key});

  @override
  ConsumerState<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends ConsumerState<ReportPage> {
  Uint8List? _mediaBytes;
  final TextEditingController notesController = TextEditingController();

  String? selectedCategory;
  String selectedStatus = 'Open';
  Position? _currentPosition;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    }
  }

  Future<void> _pickMedia(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source, imageQuality: 75);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _mediaBytes = bytes;
        });
      }
    } catch (e) {
      debugPrint("Media picking failed: $e");
    }
  }

  void _showUploadOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Upload Photo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pick from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Capture Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitReport() {
    if (_currentPosition == null) {
      _showError("Location not detected. Please enable GPS.");
      return;
    }
    if (_mediaBytes == null) {
      _showError("Please upload an image.");
      return;
    }
    if (selectedCategory == null) {
      _showError("Please select a category.");
      return;
    }
    if (notesController.text.trim().isEmpty) {
      _showError("Please enter some notes about the report.");
      return;
    }

    // ✅ Push report to provider using createReport
    ref.read(reportListProvider.notifier).createReport(
      lat: _currentPosition!.latitude,
      long: _currentPosition!.longitude,
      category: selectedCategory!,
      notes: notesController.text.trim(),
      status: selectedStatus,
      imageBytes: _mediaBytes!,
      timestamp: DateTime.now(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Report submitted. You can check it on Feed."),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.pushReplacementNamed(context, '/feed');
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: Column(
        children: [
          const NavBarhome(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isWide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Report an Environmental Problem",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Your vigilance helps us protect our planet. Submit any environmental issue you observe, and our community and partners will work to address it. Every report makes a difference.",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 40),
                            Image.asset(
                              "assests/images/UI Image.jpg",
                              height: 300,
                              width: 400,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Submit Your Report",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),

                                // Image Picker
                                GestureDetector(
                                  onTap: _showUploadOptions,
                                  child: Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: _mediaBytes == null
                                          ? const Text("Tap to capture or select photo")
                                          : Image.memory(_mediaBytes!, fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Location
                                const Text("GPS Location"),
                                Text(_currentPosition == null
                                    ? "Detecting location..."
                                    : "Lat: ${_currentPosition!.latitude}, Long: ${_currentPosition!.longitude}"),
                                const SizedBox(height: 16),

                                // Category Dropdown
                                const Text("Category"),
                                DropdownButtonFormField<String>(
                                  value: selectedCategory,
                                  hint: const Text("Select category"),
                                  items: const [
                                    DropdownMenuItem(value: "Food Waste", child: Text("🍲 Food Waste")),
                                    DropdownMenuItem(value: "Water Pollution", child: Text("💧 Water Pollution")),
                                    DropdownMenuItem(value: "Climate Issue", child: Text("🌳 Climate Issue")),
                                  ],
                                  onChanged: (val) => setState(() => selectedCategory = val),
                                ),
                                const SizedBox(height: 16),

                                // Status Dropdown
                                const Text("Status"),
                                DropdownButtonFormField<String>(
                                  value: selectedStatus,
                                  items: const [
                                    DropdownMenuItem(value: "Open", child: Text("🟢 Open")),
                                    DropdownMenuItem(value: "In Progress", child: Text("🟡 In Progress")),
                                    DropdownMenuItem(value: "Resolved", child: Text("✅ Resolved")),
                                  ],
                                  onChanged: (val) => setState(() => selectedStatus = val ?? 'Open'),
                                ),
                                const SizedBox(height: 16),

                                // Notes
                                const Text("Notes"),
                                TextField(
                                  controller: notesController,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    hintText: "Enter additional details",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Submit Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _submitReport,
                                    child: const Text("Submit Report"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : const Center(child: Text("Mobile layout not implemented yet")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
