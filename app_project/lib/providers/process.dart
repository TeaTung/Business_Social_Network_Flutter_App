import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_fix/providers/post/post_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:uuid/uuid.dart';

import './round.dart';

class ProcessProvider {
  final String id;
  final String uid;
  final String companyName;
  final String position;
  final List<Round> listRound;
  final String jobDescription;

  ProcessProvider({
    required this.id,
    required this.uid,
    required this.companyName,
    required this.position,
    required this.listRound,
    required this.jobDescription,
  });
}

class ProcessesProvider with ChangeNotifier {
  // final List<ProcessProvider> _items = [
  //   ProcessProvider(
  //     id: 'id',
  //     uid: 'uid',
  //     companyName: 'VNG',
  //     position: 'Director',
  //     listRound: Rounds().listItem,
  //     jobDescription:
  //         'Thís is fking v v v v v v  v v v vv v v v v v v v v v v v v v v v very long job description',
  //   ),
  //   ProcessProvider(
  //     id: 'id',
  //     uid: 'uid',
  //     companyName: 'VNG',
  //     position: 'Director',
  //     listRound: Rounds().listItem,
  //     jobDescription:
  //         'Thís is v v v v v  vv v v v v v v v v v v v v vv v v v v v v  fking long job description',
  //   ),
  //   ProcessProvider(
  //     id: 'id',
  //     uid: 'uid',
  //     companyName: 'VNG',
  //     position: 'Director',
  //     listRound: Rounds().listItem,
  //     jobDescription:
  //         'Thís is v v v v v v  v v v v vv v v v v vv v v v v v v v vv v fking long job description',
  //   ),
  // ];

  final CollectionReference _processes =
      FirebaseFirestore.instance.collection('processes');

  final CollectionReference _posts =
      FirebaseFirestore.instance.collection('posts');
  // List<ProcessProvider> get items {
  //   return [..._items];
  // }

  // void removeProcess(int index) {
  //   if (index > 0 && index < items.length) _items.removeAt(index);
  //   notifyListeners();
  // }

  Stream<QuerySnapshot> getProcessInPostByPostId(String postId) {
    var documentStream = FirebaseFirestore.instance
        .collection('process')
        .where('postId', isEqualTo: postId)
        .snapshots();
    return documentStream;
  }

  void createProcess({
    required List<Round> rounds,
    required PostProvider postProvider,
    required PickedFile imageFile,
  }) async {
    Round(
      description: '',
      isFinished: false,
      roundTitle: '',
      deadline: DateTime.now(),
    );

    String processId = const Uuid().v4();

    List<String> roundContent = List.from([]);
    for (var r in rounds) {
      String content = r.roundTitle + "----" + r.description;
      roundContent.add(content);
    }
    await _processes.doc(processId).set({
      'companyName': 'me',
      'id': processId,
      'rounds': roundContent,
      'jobDescription': 'sdsd',
      'position': '',
      'roundNum': rounds.length,
      'uid': FirebaseChatCore.instance.firebaseUser!.uid,
    });

    var postId = const Uuid().v4();

    if (imageFile != null) {
      FirebaseStorage _storage = FirebaseStorage.instance;

      Reference reference = _storage.ref().child('/images/posts/');

      firebase_storage.TaskSnapshot taskSnapshot =
          await reference.putFile(File(imageFile.path));

      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await _posts.doc(postId).set({
        'id': postId,
        'content': postProvider.content,
        'isBusinessPost': true,
        'likeCount': 0,
        'postTime': DateTime.now(),
        'postCreatedUserId': postProvider.postCreatedUserId,
        'likedUsers': [],
        'comments': [],
        'shareUsers': [],
        'shareCount': 0,
        'commentCount': 0,
        'commentUsers': [],
        'imageUrl': downloadUrl,
        'userName': postProvider.userInfoLocal!.userName,
        'userAvatarUrl': postProvider.userInfoLocal!.avatarUrl,
        'roundId': processId,
      });
    } else {
      await _posts.doc(postId).set({
        'id': postId,
        'content': postProvider.content,
        'isBusinessPost': true,
        'likeCount': 0,
        'postTime': DateTime.now(),
        'postCreatedUserId': postProvider.postCreatedUserId,
        'likedUsers': [],
        'comments': [],
        'shareUsers': [],
        'shareCount': 0,
        'commentCount': 0,
        'commentUsers': [],
        'imageUrl': null,
        'userName': postProvider.userInfoLocal!.userName,
        'userAvatarUrl': postProvider.userInfoLocal!.avatarUrl,
        'roundId': processId,
      });
    }
  }
}
