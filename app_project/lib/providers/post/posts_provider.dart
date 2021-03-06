import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../user_info.dart';
import 'post_provider.dart';

//This class get every post relate to user to load to main screen
class PostsProvider with ChangeNotifier {
  final CollectionReference _posts =
      FirebaseFirestore.instance.collection('posts');

  final uid = FirebaseChatCore.instance.firebaseUser!.uid;

  Stream<List<PostProvider>> list = Stream.empty();

  void createPost({
    required String content,
    String? imageUrl,
    required UserInfoLocal userInfoLocal,
  }) async {
    var id = const Uuid().v4();
    await _posts.doc(id).set({
      'id': id,
      'content': content,
      'isBusinessPost': false,
      'likeCount': 0,
      'postTime': DateTime.now(),
      'postCreatedUserId': uid,
      'likedUsers': [],
      'comments': [],
      'shareUsers': [],
      'shareCount': 0,
      'commentCount': 0,
      'commentUsers': [],
      'imageUrl': imageUrl,
      'userName': userInfoLocal.userName,
      'userAvatarUrl': userInfoLocal.avatarUrl,
    });
  }

  Future<void> createBusinessPost(PostProvider postProvider) async {
    var id = const Uuid().v4();
    await _posts.doc(id).set({
      'id': id,
      'content': postProvider.content,
      'isBusinessPost': false,
      'likeCount': 0,
      'postTime': DateTime.now(),
      'postCreatedUserId': FirebaseChatCore.instance.firebaseUser!.uid,
      'likedUsers': [],
      'comments': [],
      'shareUsers': [],
      'shareCount': 0,
      'commentCount': 0,
      'commentUsers': [],
      'imageUrl': postProvider.imageUrl,
      'userName': postProvider.userInfoLocal!.userName,
      'userAvatarUrl': postProvider.userInfoLocal!.avatarUrl,
    });
  }

  Stream<List<PostProvider>> getPost() {
    var documentStream =
        FirebaseFirestore.instance.collection('posts').snapshots();

    PostProvider postProvider;
    var document = documentStream.map((qShot) => qShot.docs.map((doc) {
          var data = doc.data();
          postProvider = PostProvider(
            commentCount: data['commentCount'],
            commentUsers: (List.from(data['commentUsers'])),
            content: data['content'],
            id: data['id'],
            imageUrl: data['imageUrl'],
            isBusinessPost: data['isBusinessPost'],
            likeCount: data['likeCount'],
            likedUsers: (List.from(data['likedUsers'])),
            postCreatedUserId: data['postCreatedUserId'],
            postTime: (data['postTime'].toDate()),
            shareCount: data['shareCount'],
            shareUsers: (List.from(data['shareUsers'])),
            roundId: data['roundId'],
            userInfoLocal: (UserInfoLocal(
              uid: data['postCreatedUserId'],
              userName: data['userName'],
              avatarUrl: data['userAvatarUrl'],
            )),
          );

          return postProvider;
        }).toList());

    return document;
  }

  //     return PostProvider(
  //         commentCount: value['commentCount'],
  //         commentUsers: [],
  //         content: '',
  //         id: '',
  //         imageUrl: '',
  //         isBusinessPost: null,
  //         likeCount: null,
  //         likedUsers: [],
  //         postCreatedUserId: '',
  //         postTime: null,
  //         shareCount: null,
  //         shareUsers: []);
  //   }).toList();
  //   return documentStream;
  // }

  Stream<DocumentSnapshot> getPostById({required String postId}) {
    var documentStream = FirebaseFirestore.instance
        .collection('posts')
        .doc(
          postId,
        )
        .snapshots();
    return documentStream;
  }
}
