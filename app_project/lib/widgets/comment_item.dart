import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/comments.dart';

class CommentItem extends StatelessWidget {
  final String id;
  final String userName;
  final String userAvatarUrl;
  final String userCommentText;
  final bool isMyComment;
  final DateTime postDate;

  CommentItem(
    this.id,
    this.userName,
    this.userAvatarUrl,
    this.userCommentText,
    this.isMyComment,
    this.postDate,
  );

  @override
  Widget build(BuildContext context) {
    final listComment = Provider.of<CommentProvider>(context);

    String returnTimePost() {
      var days = DateTime.now().difference(postDate).inDays;
      var hours = DateTime.now().difference(postDate).inHours;
      var minutes = DateTime.now().difference(postDate).inMinutes;

      if (days != 0) {
        return '${days}d';
      } else if (hours != 0) {
        return '${hours}h';
      } else {
        return '${minutes}m';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(userAvatarUrl),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(1),
                border: Border.all(
                  color: Colors.black12,
                  width: 0.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${userName}  ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              returnTimePost(),
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        Text(
                          userCommentText,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isMyComment)
                    IconButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text("Are your sure ?"),
                                content: const Text(
                                    'Do you want to delete this comment ?'),
                                actions: [
                                  TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        listComment.removeComment(id);
                                        Navigator.of(ctx).pop();
                                      }),
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  )
                                ],
                              )),
                      icon: const Icon(Icons.delete),
                      iconSize: 16,
                      constraints:
                          const BoxConstraints(maxHeight: 24, maxWidth: 24),
                    ),
                ],
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
