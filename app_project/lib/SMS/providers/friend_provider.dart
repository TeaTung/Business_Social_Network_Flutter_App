import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:test_fix/providers/user_info.dart';

class FriendProvider with ChangeNotifier {
  Stream<List<UserInfoLocal>> getFriends() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isNotEqualTo: FirebaseChatCore.instance.firebaseUser!.uid)
        .snapshots();

    return stream.map((qShot) => qShot.docs.map((doc) {
          return UserInfoLocal(
            uid: doc.get('uid'),
            userName: doc.get('name'),
          );
        }).toList());
  }
}
