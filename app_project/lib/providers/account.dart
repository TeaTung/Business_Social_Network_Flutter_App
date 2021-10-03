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

  Account(
      {required this.id,
      required this.user,
      required this.quote,
      this.coverPhotoUrl = '',
      required this.birthDate,
      required this.nationality,
      required this.gender});
}

class Accounts with ChangeNotifier {
  Account _account = Account(
      id: 'id',
      user: User(id: 'id', userName: 'Nguyễn Võ Đức Thắng',),
      coverPhotoUrl: '',
      quote: 'Learn, Learn more, Learn forever ',
      birthDate: DateTime.now(),
      nationality: 'Viet Nam',
      gender: 'Male');

  Account get account {
    return _account;
  }

  void changeNationality(String newNationality) {
    _account.nationality = newNationality;
    notifyListeners();
  }

  void changeGender(String newGender) {
    _account.gender = newGender;
    notifyListeners();
  }

  void changeQuote(String newQuote) {
    _account.quote = newQuote;
    notifyListeners();
  }

  void changeBirthDate(DateTime newBirthDate) {
    _account.birthDate = newBirthDate;
    notifyListeners();
  }

  void changeAvatarUrl(String newAvatarUrl) {
    _account.user.avatarUrl = newAvatarUrl;
    notifyListeners();
  }

  void changeCoverPhotoUrl(String newCoverPageUrl) {
    _account.coverPhotoUrl = newCoverPageUrl;
    notifyListeners();
  }

  void changeName(String newName) {
    _account.user.userName = newName;
    notifyListeners();
  }
}
