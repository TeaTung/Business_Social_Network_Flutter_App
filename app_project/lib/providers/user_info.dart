import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class UserInfoLocal with ChangeNotifier {
  final String uid;
  String userName;
  String avatarUrl;

  types.User toUserChat() {
    return types.User(id: uid, firstName: userName, imageUrl: avatarUrl);
  }

  static UserInfoLocal fromFirebase() {
    DocumentReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseChatCore.instance.firebaseUser!.uid);
    UserInfoLocal userInfoLocal = UserInfoLocal(uid: '', userName: '');
    users.get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;

      userInfoLocal = UserInfoLocal(
        uid: data['uid'],
        userName: data['name'],
        avatarUrl: data['avatarUrl'],
      );
    });
    return userInfoLocal;
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

  UserInfoLocal(
      {required this.uid,
      required this.userName,
      this.avatarUrl =
          'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'});
}
