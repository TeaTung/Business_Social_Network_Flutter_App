import 'package:flutter/material.dart';
import 'package:test_fix/this_is_me.dart';
import 'notification.dart';

class UserMe with ChangeNotifier {
  String uid;
  String imageUrl;
  String username;

  List<NotificationMe> _nots = [];

  UserMe({
    required this.uid,
    required this.username,
    this.imageUrl =
        'https://images.pexels.com/photos/1356300/pexels-photo-1356300.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
  });

  void callMeHere(String UID) {
    if (UID != MyUser.me.uid)
      NotificationMe.AddNotiToFirebase(
        NotificationMe(uid: uid, content: "This is add by me", factorId: UID),
      );
    notifyListeners();
  }
}
