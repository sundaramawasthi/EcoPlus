import 'package:flutter/material.dart';
import '../model/commentmodel.dart';
import '../model/report.dart';

class ReportCard extends StatefulWidget {
  final ReportModel report;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onLike;
  final VoidCallback? onFollowToggle;
  final VoidCallback? onViewDetail;

  const ReportCard({
    Key? key,
    required this.report,
    this.onEdit,
    this.onDelete,
    this.onLike,
    this.onFollowToggle,
    this.onViewDetail,
  }) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    setState(() {
      widget.report.comments.add(
        CommentModel(
          userName: "You",
          userAvatarUrl: "https://via.placeholder.com/150", // Replace with real avatar
          text: _commentController.text.trim(),
        ),
      );
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final report = widget.report;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 100,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                /// --- Scrollable content ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(report.userAvatarUrl),
                              radius: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(report.userName,
                                      style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Text("🌱 ${report.ecoPoints} EcoPoints",
                                      style: const TextStyle(fontSize: 12, color: Colors.green)),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: widget.onFollowToggle,
                              style: TextButton.styleFrom(
                                backgroundColor: report.isFollowed
                                    ? Colors.green.shade100
                                    : Colors.green.shade50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                foregroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              ),
                              child: Text(report.isFollowed ? "Following" : "Follow"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Image
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.memory(
                            report.imageBytes,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: 8),

                        /// Tags & Notes
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            Chip(
                              label: Text(report.category),
                              avatar: Text(report.categoryIcon),
                              backgroundColor: Colors.grey.shade100,
                            ),
                            Chip(
                              label: Text(report.status),
                              avatar: Text(report.statusEmoji),
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(report.notes,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text("📍 ${report.lat.toStringAsFixed(3)}, ${report.long.toStringAsFixed(3)}",
                            style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        Text("🕒 ${report.timestamp.toLocal().toString().split('.')[0]}",
                            style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 8),

                        /// Likes
                        Row(
                          children: [
                            IconButton(
                              onPressed: widget.onLike,
                              icon: Icon(
                                report.likes > 0 ? Icons.favorite : Icons.favorite_border,
                                color: report.likes > 0 ? Colors.red : null,
                              ),
                            ),
                            Text('${report.likes}'),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Comments Title
                        Text(
                          "Comments",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        /// Comment List
                        if (report.comments.isEmpty)
                          const Text("No comments yet. Be the first to comment!",
                              style: TextStyle(color: Colors.grey))
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: report.comments.length,
                            itemBuilder: (context, index) {
                              final c = report.comments[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundImage: NetworkImage(c.userAvatarUrl),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "${c.userName}: ",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: c.text,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),

                /// --- Bottom Actions & Add Comment ---
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey.shade300)),
                    color: Colors.grey.shade50,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: widget.onEdit,
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                icon: const Icon(Icons.delete, size: 20),
                                onPressed: widget.onDelete,
                              ),
                              TextButton(
                                onPressed: widget.onViewDetail,
                                child: const Text("View Detail"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                hintText: "Add a comment...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _addComment,
                            icon: const Icon(Icons.send, color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
