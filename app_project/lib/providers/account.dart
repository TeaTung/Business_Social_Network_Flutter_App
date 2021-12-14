import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import './user_info.dart';

class Account with ChangeNotifier {
  String id;
  String uid;
  String quote;
  String coverPhotoUrl;
  DateTime birthDate;
  String gender;
  String nationality;
  String email;
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
      required this.email,
      this.avatarUrl = ''});

  Future<Account> getMyAccount(String myId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myId)
        .get()
        .then((value) {
      id = myId;
      uid = myId;
      email = value['email'];
      gender = value['gender'];
      quote = value['quote'];
      birthDate = (value['birthday'].toDate());
      nationality = value['nationality'];
      coverPhotoUrl = value['coverPhotoUrl'];
      userName = value['name'];
      avatarUrl = value['avatarUrl'];
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
    return Account(
      id: id,
      uid: uid,
      email: email,
      gender: gender,
      quote: quote,
      birthDate: birthDate,
      nationality: nationality,
      coverPhotoUrl: coverPhotoUrl,
      userName: userName,
      avatarUrl: avatarUrl,
    );
  }

  Future<void> fetchAndSetBasicInformation(
    String newName,
    String newNationality,
    String newQuote,
    String newGender,
    DateTime newBirthdate,
    String id,
  ) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'name': newName,
      'nationality': newNationality,
      'quote': newQuote,
      'gender': newGender,
      'birthday': newBirthdate,
    }).then((_) {
      userName = newName;
      nationality = newNationality;
      quote = newQuote;
      gender = newGender;
      birthDate = newBirthdate;
      notifyListeners();
    }).catchError((error) {
      throw error;
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<bool> validateCurrentPassword(String password, String email) async {
    var user = FirebaseAuth.instance.currentUser;

    var authCredentials = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    try {
      var authResult = await user!.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (errors) {
      print("errors");
      return false;
    }

  }

  Future<void> updatePassword(String newPassword) async{
    var user = FirebaseAuth.instance.currentUser;

    await user!.updatePassword(newPassword);
  }

  void setAndFetchAvatar (File image) async {
    var user = FirebaseAuth.instance.currentUser;
    var newAvatarUrl = '';
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(user!.uid + '.jpg');

    await ref.putFile(image);

    await ref.getDownloadURL().then((p0) {
      newAvatarUrl = p0;
    }).whenComplete(() {
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'avatarUrl': newAvatarUrl,
      });
      avatarUrl = newAvatarUrl;
      notifyListeners();
    });;

  }

  void setAndFetchCoverPhoto (File image) async {
    var user = FirebaseAuth.instance.currentUser;
    var newCoverPhotoUrl = '';
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(user!.uid + '.jpg');

    await ref.putFile(image);

    await ref.getDownloadURL().then((p0) {
      newCoverPhotoUrl = p0;
    }).whenComplete(() {
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'coverPhotoUrl': newCoverPhotoUrl,
      });
      coverPhotoUrl = newCoverPhotoUrl;
      notifyListeners();
    });
  }


  int followersCount() {
    if (uidFollowers != null) {
      return uidFollowers!.length;
    } else {
      return 0;
    }
  }
}
