import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import 'post_provider.dart';
import '../providers/user_info.dart';

//This class get every post relate to user to load to main screen
class PostsProvider with ChangeNotifier {
  final CollectionReference _posts =
      FirebaseFirestore.instance.collection('posts');

  final uid = FirebaseChatCore.instance.firebaseUser!.uid;

  void createPost(
    String content,
    String? imageUrl,
  ) async {
    var id = Uuid().v4();
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
      'imageUrl': null,
    });
  }

  Stream<QuerySnapshot> getPost() {
    var documentStream = FirebaseFirestore.instance
        .collection('posts')
        // .where('postCreatedUserId', isEqualTo: uid)
        .snapshots();
    return documentStream;
  }

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
