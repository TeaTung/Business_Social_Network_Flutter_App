import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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

  void setAvatarUrl(String newAvatarUrl) {
    avatarUrl = newAvatarUrl;
    notifyListeners();
  }

  void setUserName(String newUserName) {
    userName = newUserName;
    notifyListeners();
  }
}
