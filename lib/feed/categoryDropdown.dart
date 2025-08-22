import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Filter UI',
      home: const FilterPage(),
    );
  }
}

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedCategory;
  String? selectedStatus;
  String sortBy = "Latest";

  void clearFilters() {
    setState(() {
      selectedCategory = null;
      selectedStatus = null;
      sortBy = "Latest";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report Feed")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final spacing = isMobile ? const SizedBox(height: 12) : const SizedBox(width: 12);

            return isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryDropdown(
                  selected: selectedCategory,
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
                spacing,
                StatusDropdown(
                  selected: selectedStatus,
                  onChanged: (val) => setState(() => selectedStatus = val),
                ),
                spacing,
                SortDropdown(
                  selected: sortBy,
                  onChanged: (val) => setState(() => sortBy = val),
                ),
                spacing,
                Align(
                  alignment: Alignment.centerLeft,
                  child: ClearFiltersButton(onClear: clearFilters),
                ),
              ],
            )
                : Row(
              children: [
                Expanded(
                  child: CategoryDropdown(
                    selected: selectedCategory,
                    onChanged: (val) => setState(() => selectedCategory = val),
                  ),
                ),
                spacing,
                Expanded(
                  child: StatusDropdown(
                    selected: selectedStatus,
                    onChanged: (val) => setState(() => selectedStatus = val),
                  ),
                ),
                spacing,
                Expanded(
                  child: SortDropdown(
                    selected: sortBy,
                    onChanged: (val) => setState(() => sortBy = val),
                  ),
                ),
                spacing,
                ClearFiltersButton(onClear: clearFilters),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ========== Existing widgets (unchanged) ==========

class CategoryDropdown extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selected ?? '',
      hint: const Text("All Categories"),
      decoration: const InputDecoration(border: OutlineInputBorder()),
      isExpanded: true,
      items: const [
        DropdownMenuItem(value: '', child: Text("All Categories")),
        DropdownMenuItem(value: "Food Waste", child: Text("🍲 Food Waste")),
        DropdownMenuItem(value: "Water Pollution", child: Text("💧 Water Pollution")),
        DropdownMenuItem(value: "Climate Issue", child: Text("🌳 Climate Issue")),
      ],
      onChanged: (value) {
        onChanged(value == '' ? null : value);
      },
    );
  }
}

class StatusDropdown extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const StatusDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selected ?? '',
      hint: const Text("All Statuses"),
      decoration: const InputDecoration(border: OutlineInputBorder()),
      isExpanded: true,
      items: const [
        DropdownMenuItem(value: '', child: Text("All Statuses")),
        DropdownMenuItem(value: "Open", child: Text("🟢 Open")),
        DropdownMenuItem(value: "In Progress", child: Text("🟡 In Progress")),
        DropdownMenuItem(value: "Resolved", child: Text("✅ Resolved")),
      ],
      onChanged: (value) {
        onChanged(value == '' ? null : value);
      },
    );
  }
}

class SortDropdown extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const SortDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      isExpanded: true,
      items: const [
        DropdownMenuItem(value: "Latest", child: Text("Latest")),
        DropdownMenuItem(value: "Oldest", child: Text("Oldest")),
      ],
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}

class ClearFiltersButton extends StatelessWidget {
  final VoidCallback onClear;

  const ClearFiltersButton({
    super.key,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.clear),
      label: const Text("Clear Filters"),
      onPressed: onClear,
    );
  }
}
