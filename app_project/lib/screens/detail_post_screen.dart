import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/SMS/util.dart';
import 'package:test_fix/providers/comment_provider.dart';
import 'package:test_fix/providers/comments_provider.dart';
import 'package:test_fix/providers/posts_provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/widgets/list_comments.dart';
import 'package:test_fix/widgets/post_item.dart';

import '../providers/comments.dart';
import '../providers/post_provider.dart';
import '../widgets/comment_field.dart';
import '../widgets/comment_item.dart';
import '../widgets/post_detail_screen_item.dart';

class DetailPostScreen extends StatefulWidget {
  static const routeName = '/DetailPostScreen';

  const DetailPostScreen({Key? key, required this.post}) : super(key: key);

  final PostProvider post;

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  @override
  Widget build(BuildContext context) {
    var userName;
    var userAvatarUrl;
    var userId;

    final postsProvider = Provider.of<PostsProvider>(context);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   centerTitle: false,
          //   leadingWidth: 7,
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   // leadingWidth: 15,
          //   title: FutureBuilder<DocumentSnapshot>(
          //     future: post.getPostUserInfoLocal(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<DocumentSnapshot> snapshot) {
          //       if (snapshot.hasError) {
          //         return Text("Something went wrong");
          //       }
          //       if (snapshot.hasData && !snapshot.data!.exists) {
          //         return Text("Document does not exist");
          //       }
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         Map<String, dynamic> data =
          //             snapshot.data!.data() as Map<String, dynamic>;
          //         return ListTile(
          //           leading: CircleAvatar(
          //             backgroundImage: NetworkImage(data['avatarUrl']),
          //             backgroundColor: Colors.black12,
          //             radius: 20,
          //           ),
          //           title: Text(
          //             data['name'],
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .headline1!
          //                 .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          //           ),
          //           subtitle: Text(DateFormat('d MMMM y').format(post.postTime)),
          //         );
          //       }

          //       return const Padding(
          //         padding: EdgeInsets.only(left: 8.0),
          //         child: Text("loading"),
          //       );
          //     },
          //   ),
          // ),
          body: Container(
            decoration: BoxDecoration(
              image: (widget.post.imageUrl != null)
                  ? DecorationImage(
                      image: NetworkImage(
                        widget.post.imageUrl.toString(),
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: (widget.post.imageUrl == null)
                  ? getUserAvatarNameColor(widget.post.id)
                  : null,
            ),
            child: StreamBuilder<DocumentSnapshot>(
              stream: postsProvider.getPostById(postId: widget.post.id),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading"));
                }

                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(top: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data['userAvatarUrl']),
                                backgroundColor: Colors.black12,
                                radius: 20,
                              ),
                              title: Text(
                                data['userName'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                              ),
                              // subtitle:
                              //     Text(DateFormat('d MMMM y').format(post.postTime)),
                            ),
                          ),
                        ),
                        LikePostButton(
                          postProvider:
                              PostProvider.fromDocumentSnapshot(data: data),
                          darkTheme: true,
                        ),
                        CommentPostButton(
                          postProvider:
                              PostProvider.fromDocumentSnapshot(data: data),
                          darkTheme: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          widget.post.content,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (BuildContext context) => CommentsProvider(),
                      child: CommentField(
                        userImageUrl: userAvatarUrl,
                        userName: userName,
                        uid: userId,
                        post: PostProvider.fromDocumentSnapshot(data: data),
                      ),
                    )
                  ],
                );

                // return ListView(
                //   children:
                //   Map<String, dynamic> data =
                //       document.data()! as Map<String, dynamic>;
                //   return ListTile(
                //     title: Text(data['full_name']),
                //     subtitle: Text(data['company']),
                //   );
                // }).toList()
                // );
              },
            ),
          )

          // // Container(
          // //   decoration: BoxDecoration(
          // //     image: DecorationImage(
          // //       image: NetworkImage(
          // //         post.imageUrl,
          // //       ),
          // //       fit: BoxFit.cover,
          // //     ),
          // //   ),
          // //   child: FutureBuilder<DocumentSnapshot>(
          // //     future: post.getPostUserInfoLocal(),
          // //     builder: (BuildContext context,
          // //         AsyncSnapshot<DocumentSnapshot> snapshot) {
          // //       if (snapshot.hasError) {
          // //         return Text("Something went wrong");
          // //       }
          // //       if (snapshot.hasData && !snapshot.data!.exists) {
          // //         return Text("Document does not exist");
          // //       }
          // //       if (snapshot.connectionState == ConnectionState.done) {
          // //         Map<String, dynamic> data =
          // //             snapshot.data!.data() as Map<String, dynamic>;
          // //         userName = data['name'];
          // //         userAvatarUrl = data['avatarUrl'];
          // //         userId = data['uid'];
          // //         return Column(
          // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // //           children: [
          // //             Row(
          // //               mainAxisAlignment: MainAxisAlignment.end,
          // //               children: [
          // //                 Expanded(
          // //                   child: Container(
          // //                     width: 100,
          // //                     margin: EdgeInsets.only(top: 10),
          // //                     child: ListTile(
          // //                       leading: CircleAvatar(
          // //                         backgroundImage:
          // //                             NetworkImage(data['avatarUrl']),
          // //                         backgroundColor: Colors.black12,
          // //                         radius: 20,
          // //                       ),
          // //                       title: Text(
          // //                         data['name'],
          // //                         style: Theme.of(context)
          // //                             .textTheme
          // //                             .headline1!
          // //                             .copyWith(
          // //                               fontWeight: FontWeight.w500,
          // //                               fontSize: 14,
          // //                               color: Colors.white,
          // //                             ),
          // //                       ),
          // //                       // subtitle:
          // //                       //     Text(DateFormat('d MMMM y').format(post.postTime)),
          // //                     ),
          // //                   ),
          // //                 ),
          // //                 LikePostButton(
          // //                   postProvider: post,
          // //                   darkTheme: true,
          // //                 ),
          // //                 CommentPostButton(
          // //                   postProvider: post,
          // //                   darkTheme: true,
          // //                 ),
          // //               ],
          // //             ),
          // //             ChangeNotifierProvider(
          // //               create: (BuildContext context) => CommentsProvider(),
          // //               child: CommentField(
          // //                 userImageUrl: userAvatarUrl,
          // //                 userName: userName,
          // //                 uid: userId,
          // //                 post: post,
          // //               ),
          // //             )
          // //           ],
          // //         );
          // //       }

          // //       return const Padding(
          // //         padding: EdgeInsets.only(left: 8.0),
          // //         child: Text("loading"),
          // //       );
          // //     },
          // //   ),

          //   //   SingleChildScrollView(
          //   //     physics: const ScrollPhysics(),
          //   //     padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
          //   //     child: Column(
          //   //       mainAxisSize: MainAxisSize.min,
          //   //       children: [
          //   //         // post.imageUrl != null
          //   //         //     ? PostDetailScreenItem(
          //   //         //         postDescription: post.content,
          //   //         //         postImageUrl: post.imageUrl,
          //   //         //       )
          //   //         //     : PostDetailScreenItem(
          //   //         //         postDescription: post.content,
          //   //         //       ),
          //   //         FutureBuilder<DocumentSnapshot>(
          //   //             future: post.getPostUserInfoLocal(),
          //   //             builder:
          //   //                 (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          //   //               if (snapshot.hasError) {
          //   //                 return Text("Something went wrong");
          //   //               }

          //   //               if (snapshot.hasData && !snapshot.data!.exists) {
          //   //                 return Text("Document does not exist");
          //   //               }
          //   //               if (snapshot.connectionState == ConnectionState.done) {
          //   //                 Map<String, dynamic> data =
          //   //                     snapshot.data!.data() as Map<String, dynamic>;
          //   //                 userName = data['name'];
          //   //                 userAvatarUrl = data['avatarUrl'];
          //   //                 userId = data['uid'];
          //   //                 return ChangeNotifierProvider(
          //   //                   create: (BuildContext context) => CommentsProvider(),
          //   //                   child: CommentField(
          //   //                     userImageUrl: userAvatarUrl,
          //   //                     userName: userName,
          //   //                     uid: userId,
          //   //                     post: post,
          //   //                   ),
          //   //                 );
          //   //               }

          //   //               return Text("loading");
          //   //             }),
          //   //         ChangeNotifierProvider(
          //   //           create: (BuildContext context) => CommentsProvider(),
          //   //           child: ListComments(
          //   //             postId: post.id,
          //   //             userAvatarUrl: userAvatarUrl,
          //   //             userName: userName,
          //   //           ),
          //   //         ),
          //   //       ],
          //   //     ),
          //   //   ),
          //   // ),
          // ),

          ),
    );
  }
}
