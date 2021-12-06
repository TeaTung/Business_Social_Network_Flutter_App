import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:test_fix/providers/user_info.dart';

class ChatProvider with ChangeNotifier {
  var a = FirebaseFirestore.instance.collection('users').get().asStream();

  Stream<List<types.Room>> getUserRooms() {
    return FirebaseChatCore.instance.rooms();
  }

  User? getUserAuth() {
    return FirebaseChatCore.instance.firebaseUser;
  }

  //DocumentSnapshot getUserTalkingTo(String roomId, String userId) {}

  Future<types.Room> createRoom(
      UserInfoLocal otherUser, UserInfoLocal currentUser) async {
    final room = await FirebaseFirestore.instance.collection('rooms').add(
      {
        'createdAt': FieldValue.serverTimestamp(),
        'imageUrl': otherUser.avatarUrl,
        'name': otherUser.userName,
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
