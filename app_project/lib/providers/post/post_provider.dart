import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:test_fix/providers/post/posts_provider.dart';

import '../comments.dart';
import '../user_info.dart';

//This class create individual post to load to posts list
class PostProvider with ChangeNotifier {
  final String id;
  // final UserInfoLocal userInfo;
  final String content;
  String imageUrl;
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

  UserInfoLocal? userInfoLocal;

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
    this.userInfoLocal,
    required this.imageUrl,
    required this.shareUsers,
    required this.likedUsers,
    required this.shareCount,
    required this.commentCount,
    required this.commentUsers,
  });

  static PostProvider fromDocumentSnapshot(
      {required Map<String, dynamic> data}) {
    return PostProvider(
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
      userInfoLocal: (UserInfoLocal(
        uid: data['postCreatedUserId'],
        userName: data['userName'],
        avatarUrl: data['userAvatarUrl'],
      )),
    );
  }

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

  Future<void> savePostToDatabase({
    required PostsProvider postsProvider,
    required UserInfoLocal myUserInfoLocal,
    required PickedFile imageFile,
  }) async {
    if (imageFile != null) {
      FirebaseStorage _storage = FirebaseStorage.instance;

      Reference reference = _storage.ref().child('/images/posts/');

      firebase_storage.TaskSnapshot taskSnapshot =
          await reference.putFile(File(imageFile.path));

      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      postsProvider.createPost(
        content: content,
        userInfoLocal: myUserInfoLocal,
        imageUrl: downloadUrl,
      );
    } else {
      postsProvider.createPost(
        content: content,
        userInfoLocal: myUserInfoLocal,
        imageUrl: null,
      );
    }
  }
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
