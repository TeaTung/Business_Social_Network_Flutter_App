import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import './user_info.dart';

class Account with ChangeNotifier {
  final String id;
  final String uid;
  String quote;
  String coverPhotoUrl;
  DateTime birthDate;
  String gender;
  String nationality;

  //users who this account is following
  List<String>? uidFollowing;

  //users who is following this account
  List<String>? uidFollowers;

  Account({
    required this.id,
    required this.uid,
    required this.quote,
    this.coverPhotoUrl = '',
    required this.birthDate,
    required this.nationality,
    required this.gender,
    this.uidFollowers,
    this.uidFollowing,
  });

  void getMyAccount(String myId) async {
    print('day la id cua toi' + myId);
    print('set my account run');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myId)
        .get()
        .then((value) {
      print(value['gender']);
      gender = value['gender'];
      quote = value['quote'];
      birthDate = value['birhtday'];
      nationality = value['nationality'];
      coverPhotoUrl = value['coverphotourl'];
    });
    // notifyListeners();
    print('finish my account run');
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
