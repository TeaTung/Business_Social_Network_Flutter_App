import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/post/comments_provider.dart';
import '../../providers/comments.dart';

class CommentItem extends StatelessWidget {
  final String id;
  final String userName;
  final String userAvatarUrl;
  final String userCommentText;
  final bool isMyComment;
  final DateTime postDate;
  final String postId;

  CommentItem({
    required this.postId,
    required this.id,
    required this.userName,
    required this.userAvatarUrl,
    required this.userCommentText,
    required this.isMyComment,
    required this.postDate,
  });

  @override
  Widget build(BuildContext context) {
    final listComment = Provider.of<Comments>(context, listen: false);

    final commentsProvider = Provider.of<CommentsProvider>(context);

    String returnTimePost() {
      var days = DateTime.now().difference(postDate).inDays;
      var hours = DateTime.now().difference(postDate).inHours;
      var minutes = DateTime.now().difference(postDate).inMinutes;

      if (days != 0) {
        return '${days}d';
      } else if (hours != 0) {
        return '${hours}h';
      } else {
        if (minutes == 0) {
          return "now";
        }
        return '${minutes}m';
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userAvatarUrl),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    // color: Color.fromRGBO(235, 235, 235, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                        bottomLeft: Radius.circular(3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '$userName  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                              ),
                              Text(
                                returnTimePost(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(userCommentText,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w400,
                                    )),
                          ),
                        ],
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
                                            commentsProvider.deleteCommentById(
                                              commentId: id,
                                              postId: postId,
                                            );
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
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          iconSize: 20,
                          constraints:
                              const BoxConstraints(maxHeight: 20, maxWidth: 24),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
