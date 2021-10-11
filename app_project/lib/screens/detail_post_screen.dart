import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/comments.dart';
import '../providers/post.dart';
import '../widgets/comment_field.dart';
import '../widgets/comment_item.dart';
import '../widgets/post_detail_screen_item.dart';

class DetailPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostDetail>(context).post;
    final listComment = Provider.of<Comments>(context);
    const userId = 'id';
    const uid = 'uid';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 15,
          title: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.user.avatarUrl),
              radius: 20,
            ),
            title: Text(
              post.user.userName,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            subtitle: Text(DateFormat('d MMMM y').format(post.postTime)),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // fake data
              PostDetailScreenItem(
                post.user.userName,
                'This is a very fucking longggggggggggggggggggggg description',
                'https://picsum.photos/200/300',
              ),
              CommentField(
                post.user.avatarUrl,
                post.user.userName,
                post.user.uid,
              ),
              if (post.comments != null)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listComment.length,
                  itemBuilder: (ctx, i) => CommentItem(
                    listComment.listComment[i].id,
                    listComment.listComment[i].user.userName,
                    listComment.listComment[i].user.avatarUrl,
                    listComment.listComment[i].userCommentText,
                    userId == post.user.uid,
                    listComment.listComment[i].date,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
