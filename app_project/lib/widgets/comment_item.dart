import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comments.dart';

class CommentItem extends StatelessWidget {
  final id;
  final userName;
  final userImageUrl;
  final userCommentText;

  CommentItem(
      this.id,
      this.userName,
      this.userImageUrl,
      this.userCommentText,
      );
  @override
  Widget build(BuildContext context) {
    final listComment = Provider.of<CommentProvider>(context);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userImageUrl),
          ),
          title: Text(userName),
          subtitle: Text(userCommentText),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: const Text('Do you want to delete this comment'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        listComment.removeComment(id);
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
