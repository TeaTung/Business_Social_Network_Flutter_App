import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/comments_provider.dart';
import 'package:test_fix/widgets/posts/comment_item.dart';

class ListComments extends StatelessWidget {
  ListComments({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final String postId;

  @override
  Widget build(BuildContext context) {
    final commentProviders = Provider.of<CommentsProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: commentProviders.getCommentForPost(postId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const Text("Loading"));
        }

        return Padding(
          padding: EdgeInsets.only(top: 19, bottom: 20),
          child: (snapshot.data!.docs.length > 0)
              ? ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return CommentItem(
                      postId: postId,
                      id: data['id'],
                      isMyComment: ((data['userId']) ==
                          FirebaseChatCore.instance.firebaseUser!.uid),
                      postDate: ((data['postDate'].toDate())),
                      userAvatarUrl: data['userAvatarUrl'],
                      userCommentText: (data['content']),
                      userName: data['userName'],
                    );
                  }).toList(),
                )
              : Center(
                  child: Text(
                    "Seem a quite here",
                    style: GoogleFonts.workSans().copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
