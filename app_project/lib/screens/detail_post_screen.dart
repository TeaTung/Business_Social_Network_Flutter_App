import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/comments.dart';
import '../providers/post.dart';
import '../widgets/comment_field.dart';
import '../widgets/comment_item.dart';
import '../widgets/post_detail_screen_item.dart';

class DetailPostScreen extends StatelessWidget {
  static const routeName = '/DetailPostScreen';

  const DetailPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is post id
    final id = ModalRoute.of(context)!.settings.arguments;

    final post = Provider.of<PostDetail>(context).post;
    final listComment = Provider.of<Comments>(context);
    const userId = 'id';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          // leadingWidth: 15,
          title: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.userInfo.avatarUrl),
              radius: 20,
            ),
            title: Text(
              post.userInfo.userName,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            subtitle: Text(DateFormat('d MMMM y').format(post.postTime)),
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
                post.userInfo.userName,
                'This is a very fucking longggggggggggggggggggggg description',
                'https://picsum.photos/200/300',
              ),
              CommentField(
                post.userInfo.avatarUrl,
                post.userInfo.userName,
                post.userInfo.uid,
              ),
              if (post.comments != null)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listComment.length,
                  itemBuilder: (ctx, i) => CommentItem(
                    listComment.listComment[i].id,
                    listComment.listComment[i].userInfo.userName,
                    listComment.listComment[i].userInfo.avatarUrl,
                    listComment.listComment[i].userCommentText,
                    userId == post.userInfo.uid,
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
