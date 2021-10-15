import 'package:flutter/foundation.dart';

class User with ChangeNotifier{
  final String uid;
  String userName;
  String avatarUrl;

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

  User(
      {required this.uid,
      required this.userName,
      this.avatarUrl =
          'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'});
}
