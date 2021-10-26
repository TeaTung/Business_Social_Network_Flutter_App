import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comments.dart';
import '../providers/post.dart';
import '../providers/user.dart';

class CommentField extends StatefulWidget {
  final String userImageUrl;
  final String userName;
  final String uid;

  CommentField(
      this.userImageUrl,
      this.userName,
      this.uid,
      );

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostDetail>(context).post;
    final listComment = Provider.of<Comments>(context);
    final textController = TextEditingController();
    String textComment = '';
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (post.isFavourite) {
                    post.likeCount--;
                  } else {
                    post.likeCount++;
                  }
                  post.isFavourite = !post.isFavourite;
                });
              },
              icon: post.isFavourite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
            ),
            Text('${post.likeCount}'),
            const Spacer(),
            if (listComment.length == 0) const Text('0 comments'),
            if (listComment.length != 0)
              Text(listComment.length.toString() + ' comments'),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
        ),
        Row(
          children: [
            const SizedBox(width: 7),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.userImageUrl),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Leave some comment...',
                ),
                onChanged: (val) {
                  textComment = val.toString();
                },
                onSubmitted: (val) {
                  textComment = val.toString();
                },
              ),
            ),
            const SizedBox(width: 3),
            IconButton(
              icon: const Icon(
                Icons.send,
                size: 20,
              ),
              onPressed: () {
                if (textComment.isEmpty) return;
                listComment.addComment(
                  Comment(
                    id: DateTime.now().toString(),
                    user: User(
                      uid: widget.uid,
                      userName: widget.userName,
                      avatarUrl: widget.userImageUrl,
                    ),
                    date: DateTime.now(),
                    numberOfLike: 0,
                    userCommentText: textComment.trim(),
                  ),
                );
                textController.clear();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
        const SizedBox(height: 3),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
