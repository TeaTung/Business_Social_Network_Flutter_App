import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import './user_info.dart';

class Account with ChangeNotifier {
  String id;
  String uid;
  String quote;
  String coverPhotoUrl;
  DateTime birthDate;
  String gender;
  String nationality;
  String userName;
  String avatarUrl;

  //users who this account is following
  List<String>? uidFollowing;

  //users who is following this account
  List<String>? uidFollowers;

  Account(
      {required this.id,
      required this.uid,
      required this.quote,
      this.coverPhotoUrl = '',
      required this.birthDate,
      required this.nationality,
      required this.gender,
      this.uidFollowers,
      this.uidFollowing,
      required this.userName,
      this.avatarUrl = ''});

  void getMyAccount(String myId) async {
    print('set my account run');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myId)
        .get()
        .then((value) {
      id = myId;
      uid = myId;
      gender = value['gender'];
      quote = value['quote'];
      birthDate = (value['birthday'].toDate());
      nationality = value['nationality'];
      coverPhotoUrl = value['coverphotourl'];
      userName = value['name'];
      avatarUrl = value['avatarUrl'];
    });
    notifyListeners();
    print('finish my account');
  }

  String get getAvatarUrl {
    return avatarUrl;
  }

  String get getUserName {
    return userName;
  }

  String get getNationality {
    return nationality;
  }

  String get getGender {
    return gender;
  }

  String get getQuote {
    return quote;
  }

  DateTime get getBirthDate {
    return birthDate;
  }

  String get getCoverPhotoUrl {
    return coverPhotoUrl;
  }

  void setAvatarUrl(String newAvatarUrl) {
    avatarUrl = newAvatarUrl;
    notifyListeners();
  }

  void setUserName(String newUserName) {
    userName = newUserName;
    notifyListeners();
  }

  void setNationality(String newNationality) {
    nationality = newNationality;
    notifyListeners();
  }

  void setGender(String newGender) {
    gender = newGender;
    notifyListeners();
  }

  void setQuote(String newQuote) {
    quote = newQuote;
    notifyListeners();
  }

  void setBirthDate(DateTime newBirthDate) {
    birthDate = newBirthDate;
    notifyListeners();
  }

  void setCoverPhotoUrl(String newCoverPageUrl) {
    coverPhotoUrl = newCoverPageUrl;
    notifyListeners();
  }

  int followersCount() {
    if (uidFollowers != null) {
      return uidFollowers!.length;
    } else {
      return 0;
    }
  }
}
