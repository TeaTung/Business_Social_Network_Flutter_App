import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:uuid/uuid.dart';

class CommentsProvider with ChangeNotifier {
  final CollectionReference _comments =
      FirebaseFirestore.instance.collection('comments');

  final CollectionReference _posts =
      FirebaseFirestore.instance.collection('posts');

  Stream<QuerySnapshot> getCommentForPost(String postId) {
    var documentStream = FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .snapshots();

    return documentStream;
  }

  void createComment({
    required String content,
    String? imageUrl,
    required String postId,
    required UserInfoLocal userInfoLocal,
  }) async {
    var id = const Uuid().v4();
    await _comments.doc(id).set({
      'id': id,
      'content': content,
      'imageUrl': imageUrl,
      'userId': FirebaseChatCore.instance.firebaseUser!.uid,
      'postId': postId,
      'postDate': DateTime.now(),
      'userAvatarUrl': userInfoLocal.avatarUrl,
      'userName': userInfoLocal.userName,
    });
  }

  Future<void> deleteCommentById({
    required String commentId,
    required String postId,
  }) async {
    await _comments.doc(commentId).delete();

    await _posts.doc(postId).update({
      'commentUsers':
          FieldValue.arrayRemove([FirebaseChatCore.instance.firebaseUser!.uid])
    });

    await _posts.doc(postId).update({
      'commentCount': FieldValue.increment(-1),
    });
  }
}
