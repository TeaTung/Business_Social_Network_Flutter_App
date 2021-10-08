import 'package:flutter/foundation.dart';

import './user.dart';

class Account with ChangeNotifier {
  final String id;
  User user;
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
    required this.user,
    required this.quote,
    this.coverPhotoUrl = '',
    required this.birthDate,
    required this.nationality,
    required this.gender,
    this.uidFollowers,
    this.uidFollowing,
  });

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

  String get getAvatarUrl {
    return user.avatarUrl;
  }

  String get getCoverPhotoUrl {
    return coverPhotoUrl;
  }

  String get getUsername {
    return user.userName;
  }

  User get getUser {
    return user;
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

  void setAvatarUrl(String newAvatarUrl) {
    user.avatarUrl = newAvatarUrl;
    notifyListeners();
  }

  void setCoverPhotoUrl(String newCoverPageUrl) {
    coverPhotoUrl = newCoverPageUrl;
    notifyListeners();
  }

  void setUsername(String newName) {
    user.userName = newName;
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
