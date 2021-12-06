import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import './user_info.dart';
import 'comments.dart';

//This class create individual post to load to posts list
class PostProvider with ChangeNotifier {
  final String id;
  // final UserInfoLocal userInfo;
  final String content;
  final String imageUrl;
  Comments? comments;
  bool isFavourite;
  final DateTime postTime;

  final String postCreatedUserId;

  //Variables bellow point out that post is business post or not to add additional information to the post
  final bool isBusinessPost;
  final String? email;
  final String? phoneNumber;

  // arrays of user who like the posts
  final List<String> likedUsers;
  int likeCount;

  // array of user who share the posts
  final List<String> shareUsers;
  final int shareCount;

  // array of user who comment the posts
  final List<String> commentUsers;
  final int commentCount;

  PostProvider({
    required this.postCreatedUserId,
    this.isFavourite = false,
    required this.postTime,
    required this.id,
    required this.content,
    required this.likeCount,
    required this.isBusinessPost,
    this.comments,
    this.email,
    this.phoneNumber,
    required this.imageUrl,
    required this.shareUsers,
    required this.likedUsers,
    required this.shareCount,
    required this.commentCount,
    required this.commentUsers,
  });

  // SHARE
  void updateLikeCount({
    required int likeCount,
    required bool increment,
  }) async {
    var doc = FirebaseFirestore.instance.collection('posts').doc(id);
    await doc.update(
      {'likeCount': likeCount},
    );
    if (increment) {
      await doc.update(
        {
          "likedUsers": FieldValue.arrayUnion(
              [FirebaseChatCore.instance.firebaseUser!.uid])
        },
      );
    } else {
      await doc.update(
        {
          "likedUsers": FieldValue.arrayRemove(
              [FirebaseChatCore.instance.firebaseUser!.uid])
        },
      );
    }
  }

  bool isLikedAlready() {
    bool isLiked = false;
    if (likedUsers.contains(FirebaseChatCore.instance.firebaseUser!.uid)) {
      isLiked = true;
    }
    return isLiked;
  }

  // SHARE
  void updateShareCount({
    required int shareCount,
    required bool increment,
  }) async {
    var iduSER = FirebaseChatCore.instance.firebaseUser!.uid;
    var doc = FirebaseFirestore.instance.collection('posts').doc(id);

    await doc.update(
      {'shareCount': shareCount},
    );

    if (increment) {
      await doc.update({
        'shareUsers': FieldValue.arrayUnion([iduSER])
      });
    } else {
      await doc.update({
        'shareUsers': FieldValue.arrayRemove([iduSER])
      });
    }
  }

  bool isShareAlready() {
    bool isLiked = false;
    if (shareUsers.contains(FirebaseChatCore.instance.firebaseUser!.uid)) {
      isLiked = true;
    }
    return isLiked;
  }

  // COMMENT
  void updateCommentCount({
    required int commentCount,
    required bool increment,
  }) async {
    var idUser = FirebaseChatCore.instance.firebaseUser!.uid;
    var doc = FirebaseFirestore.instance.collection('posts').doc(id);

    await doc.update(
      {'commentCount': commentCount},
    );

    if (increment) {
      await doc.update({
        'commentUsers': FieldValue.arrayUnion([idUser])
      });
    } else {
      await doc.update({
        'commentUsers': FieldValue.arrayRemove([idUser])
      });
    }
  }

  bool isCommentAlready() {
    if (commentUsers.contains(FirebaseChatCore.instance.firebaseUser!.uid)) {
      return true;
    }
    return false;
  }

  Future<DocumentSnapshot> getPostUserInfoLocal() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(postCreatedUserId)
        .get();
  }

  // UserInfoLocal getUserInforUser(String userId) {}
}

class PostDetail with ChangeNotifier {
  // PostProvider post = PostProvider(
  //     postTime: DateTime.now(),
  //     id: "1",
  //     // userInfo: UserInfoLocal(
  //     //   uid: 'id',
  //     //   userName: 'Bopy',
  //     //   avatarUrl:
  //     //       "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
  //     // ),
  //     content: "Hello world !!! This is a very long description in a post <3",
  //     likeCount: 1,
  //     isBusinessPost: false,
  //     comments: Comments(),
  //     isFavourite: false,
  //     likedUsers: [],
  //     imageUrl:
  //         "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
  //     postCreatedUserId: '');
}
