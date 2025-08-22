import 'package:flutter/material.dart';

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
