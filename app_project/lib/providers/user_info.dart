import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserInfoLocal with ChangeNotifier {
  final String uid;
  String userName;
  String avatarUrl;

  UserInfoLocal({
    required this.uid,
    required this.userName,
    this.avatarUrl = '',
  });

  UserInfoLocal get myUser {
    print('set my user run');

    final myId = FirebaseAuth.instance.currentUser?.uid.toString();
    FirebaseFirestore.instance
        .collection("users")
        .doc(myId)
        .get()
        .then((value) {
      return UserInfoLocal(
        userName: value['name'],
        avatarUrl: value['avatarUrl'],
        uid: myId as String,
      );
    });
    return UserInfoLocal(
      uid: myId as String,
      userName: '',
      avatarUrl: '',
    );
  }

  String get getAvatarUrl {
    return avatarUrl;
  }

  String get getUserName {
    return userName;
  }

  void setAvatarUrl(String newAvatarUrl) {
    avatarUrl = newAvatarUrl;
    notifyListeners();
  }

  void setUserName(String newUserName) {
    userName = newUserName;
    notifyListeners();
  }
}
