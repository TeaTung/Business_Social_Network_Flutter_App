import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class UserInfoLocal with ChangeNotifier {
  String uid;
  String userName;
  String avatarUrl;

  UserInfoLocal({
    required this.uid,
    required this.userName,
    this.avatarUrl = '',
  });

  String get getAvatarUrl {
    return avatarUrl;
  }

  String get getUserName {
    return userName;
  }

  types.User toUserChat() {
    return types.User(
      id: uid,
      firstName: userName,
      imageUrl: avatarUrl,
    );
  }

  void setAvatarUrl(String newAvatarUrl) {
    avatarUrl = newAvatarUrl;
    notifyListeners();
  }

  void setUserName(String newUserName) {
    userName = newUserName;
    notifyListeners();
  }

  static Future<UserInfoLocal> fromFirebase() async {
    DocumentReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    UserInfoLocal userInfoLocal = UserInfoLocal(uid: '', userName: '');
    await users.get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;

      userInfoLocal = UserInfoLocal(
        uid: data['uid'],
        userName: data['name'],
        avatarUrl: data['avatarUrl'],
      );
    });
    return userInfoLocal;
  }
}
