import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'account.dart';

class Accounts with ChangeNotifier {
  List<Account> listAccount = [];

  Future<List<Account>> getListEducation() async {
    if (listAccount.isEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              listAccount.add(Account(
                email: doc['email'],
                uid: doc['uid'],
                userName: doc['name'],
                nationality: doc['nationality'],
                birthDate: doc['birthday'].toDate(),
                quote: doc['quote'],
                gender: doc['gender'],
                id: doc['id'],
                avatarUrl: doc['avatarUrl'],
                coverPhotoUrl: doc['coverPhotoUrl'],
              ));
            }
          })
          .then((value) => notifyListeners())
          .whenComplete(() {
            print('THIS IS LIST ACCOUNT LENGTH: ' + listAccount.length.toString());
          });
    }
    return listAccount;
  }
}
