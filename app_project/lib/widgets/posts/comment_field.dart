import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/comment_provider.dart';
import 'package:test_fix/providers/comments_provider.dart';

import '../../providers/comments.dart';
import '../../providers/post_provider.dart';
import '../../providers/user_info.dart';

class CommentField extends StatefulWidget {
  final String userImageUrl;
  final String userName;
  final String uid;

  final PostProvider post;

  // ignore: use_key_in_widget_constructors
  const CommentField({
    required this.userImageUrl,
    required this.userName,
    required this.uid,
    required this.post,
  });

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  @override
  Widget build(BuildContext context) {
    final commentsProvider = Provider.of<CommentsProvider>(context);
    final postProvider = widget.post;
    final textController = TextEditingController();

    final UserInfoLocal userInfoLocal = Provider.of<UserInfoLocal>(context);

    String textComment = '';
    return Column(
      children: [
        // Row(
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         setState(() {
        //           if (postProvider.isFavourite) {
        //             postProvider.updateLikeCount(
        //                 likeCount: postProvider.likeCount, increment: true);
        //           } else {
        //             postProvider.updateLikeCount(
        //                 likeCount: postProvider.likeCount, increment: true);
        //           }
        //         });
        //       },
        //       icon: postProvider.isLikedAlready()
        //           ? const Icon(Icons.favorite)
        //           : const Icon(Icons.favorite_border),
        //     ),
        //     Text('${postProvider.likeCount}'),
        //     const Spacer(),
        //     if (postProvider.commentCount == 0) const Text('0 comment'),
        //     if (postProvider.commentCount != 0)
        //       Text(postProvider.commentCount.toString() + ' comments'),
        //     const Spacer(),
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.share),
        //     ),
        //   ],
        // ),

        Row(
          children: [
            const SizedBox(width: 20),
            // CircleAvatar(
            //   backgroundImage: NetworkImage(widget.userImageUrl),
            // ),
            // const SizedBox(width: 7),
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  style: GoogleFonts.workSans().copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  controller: textController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: ' Leave a comment',
                    hintStyle: GoogleFonts.workSans().copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    contentPadding: const EdgeInsets.only(left: 15),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                  ),
                  onChanged: (val) {
                    textComment = val.toString();
                  },
                  onSubmitted: (val) {
                    textComment = val.toString();
                  },
                ),
              ),
            ),
            const SizedBox(width: 3),
            IconButton(
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                if (textComment.isEmpty) return;
                commentsProvider.createComment(
                  content: (textComment.trim()),
                  postId: postProvider.id,
                  userInfoLocal: userInfoLocal,
                );
                postProvider.updateCommentCount(
                  commentCount: postProvider.commentCount + 1,
                  increment: true,
                );

                textController.clear();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
