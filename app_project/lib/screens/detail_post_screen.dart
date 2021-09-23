import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/post.dart';
import '../widgets/comment_field.dart';
import '../widgets/comment_item.dart';

import '../providers/comments.dart';

class DetailPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const userPostImageUrl =
        'https://i.pinimg.com/474x/0c/eb/c3/0cebc3e2a01fe5abcff9f68e9d2a06e4.jpg';
    const postImageUrl = 'https://picsum.photos/200/300.jpg';
    final listComment = Provider.of<CommentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Post(
                userPostImageUrl,
                'Name',
                'This is description',
                postImageUrl,
              ),
              CommentField(userPostImageUrl, 'Name'),
              Flexible(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listComment.listComment.length,
                  itemBuilder: (ctx, i) => CommentItem(
                    listComment.listComment[i].id,
                    listComment.listComment[i].userName,
                    listComment.listComment[i].userAvatarUrl,
                    listComment.listComment[i].userCommentText,
                    //usercommentID = myId
                    1 == 1,
                    listComment.listComment[i].date,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
