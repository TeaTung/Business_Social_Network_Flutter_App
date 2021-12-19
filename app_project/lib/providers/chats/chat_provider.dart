import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:test_fix/providers/user_info.dart';

class ChatProvider with ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> _rooms =
      FirebaseFirestore.instance.collection('rooms');

  // void getRoom() {
  //   FirebaseFirestore.instance
  //       .collection(config.roomsCollectionName)
  //       .doc(roomId)
  //       .snapshots()
  //       .asyncMap(
  //         (doc) => processRoomDocument(doc, fu, config.usersCollectionName),
  //       );
  // }

  Future<String> hasCreatedRoomAlready(
      {required String userId, required String otherUserId}) async {
    String idRoomCreated = 'NotCreated';
    await _rooms
        .where('userIds', isEqualTo: [userId, otherUserId])
        .get()
        .then((value) {
          if (value.docs.isNotEmpty) idRoomCreated = value.docs.first.id;
        });
    return idRoomCreated;
  }

  Stream<QuerySnapshot> getUserRooms() {
    return _rooms
        .where('userIds',
            arrayContains: FirebaseChatCore.instance.firebaseUser!.uid)
        .snapshots();
  }

  User? getUserAuth() {
    return FirebaseChatCore.instance.firebaseUser;
  }

  //DocumentSnapshot getUserTalkingTo(String roomId, String userId) {}

  Future<types.Room> createRoom(
      UserInfoLocal otherUser, UserInfoLocal currentUser) async {
    print(otherUser.avatarUrl);
    final room = await FirebaseFirestore.instance.collection('rooms').add(
      {
        'createdAt': FieldValue.serverTimestamp(),
        'imageUrl': otherUser.avatarUrl,
        'otherUserId': otherUser.uid,
        'name1': currentUser.userName,
        'name2': otherUser.userName,
        'avatar1': currentUser.avatarUrl,
        'avatar2': otherUser.avatarUrl,
        'type': types.RoomType.direct.toShortString(),
        'updatedAt': FieldValue.serverTimestamp(),
        'userIds': ([currentUser.uid, otherUser.uid].toList()),
        'userRoles': null,
      },
    );

    return types.Room(
      id: room.id,
      type: types.RoomType.direct,
      users: [
        currentUser.toUserChat(),
        otherUser.toUserChat(),
      ],
      imageUrl: otherUser.avatarUrl,
    );
  }
}
