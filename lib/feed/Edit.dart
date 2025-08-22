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
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      child: SingleChildScrollView( // ✅ Mobile scroll support
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            minHeight: 100,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Edit Report", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
