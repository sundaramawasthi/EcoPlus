import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/report.dart';
import '../provider/reportProvider.dart';

class EditReportDialog extends ConsumerStatefulWidget {
  final ReportModel report;
  const EditReportDialog({super.key, required this.report});

  @override
  ConsumerState<EditReportDialog> createState() => _EditReportDialogState();
}

class _EditReportDialogState extends ConsumerState<EditReportDialog> {
  late TextEditingController notesController;
  late String status;
  final List<String> statuses = ['Open', 'In Progress', 'Resolved'];

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController(text: widget.report.notes);
    status = widget.report.status;
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Report"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: notesController,
            decoration: const InputDecoration(labelText: "Notes"),
            maxLines: null,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: status,
            items: statuses
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => status = val);
            },
            decoration: const InputDecoration(labelText: "Status"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Use the updated immutable editReport method
            ref.read(reportListProvider.notifier).editReport(
              widget.report,
              notes: notesController.text,
              status: status,
            );
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
