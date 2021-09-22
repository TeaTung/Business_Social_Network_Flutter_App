import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comments.dart';

class CommentField extends StatefulWidget {
  final String userImageUrl;
  final String userName;

  CommentField(
      this.userImageUrl,
      this.userName,
      );

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  int numberOfFavourite = 0;
  int numberOfComment = 0;
  bool _isFavorite = false;
  String textComment = '';

  @override
  Widget build(BuildContext context) {
    final listComment = Provider.of<CommentProvider>(context);
    final textController = TextEditingController();
    return Card(
      elevation: 1,
      borderOnForeground: true,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_isFavorite) {
                      numberOfFavourite--;
                    } else {
                      numberOfFavourite++;
                    }
                    _isFavorite = !_isFavorite;
                  });
                },
                icon: _isFavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
              ),
              Text('$numberOfFavourite'),
              const Spacer(),
              Text(listComment.length.toString() + ' comments'),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ],
          ),
          const Divider(thickness: 1),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.userImageUrl),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  textCapitalization: TextCapitalization.sentences,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (textComment.isEmpty) return;
                    listComment.addComment(
                      Comment(
                        id: DateTime.now().toString(),
                        userName: widget.userName,
                        userImageUrl: widget.userImageUrl,
                        userCommentText: textComment.trim(),
                      ),
                    );
                    textController.clear();
                    FocusScope.of(context).unfocus();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
