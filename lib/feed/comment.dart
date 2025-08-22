import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/commentmodel.dart';
import '../model/report.dart';
import '../provider/reportProvider.dart';

class CommentDialog extends ConsumerStatefulWidget {
  final ReportModel report;

  const CommentDialog({Key? key, required this.report}) : super(key: key);

  @override
  ConsumerState<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends ConsumerState<CommentDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Comments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),

            /// Report details
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.report.userAvatarUrl),
              ),
              title: Text(widget.report.userName),
              subtitle: Text(widget.report.notes),
            ),
            const Divider(),

            /// Comments list
            Expanded(
              child: ListView.builder(
                itemCount: widget.report.comments.length,
                itemBuilder: (context, index) {
                  final CommentModel comment = widget.report.comments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(comment.userAvatarUrl),
                      radius: 16,
                    ),
                    title: Text(
                      comment.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(comment.text),
                  );
                },
              ),
            ),

            /// Add new comment
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Add a comment...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      // Add comment using the provider
                      ref.read(reportListProvider.notifier).addCommentToReport(
                        widget.report,
                        text: text,
                        userName: "EcoUser", // replace with logged-in user
                        userAvatarUrl:
                        "https://api.dicebear.com/6.x/thumbs/svg?seed=EcoUser",
                      );

                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
