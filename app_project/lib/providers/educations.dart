import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'education.dart';

//This class get every education relate to user to load to position section in Account screen
class Educations with ChangeNotifier {
  List<Education> listEducation = [];

  Future<List<Education>> getListEducation(String id) async {
    if (listEducation.isEmpty) {
      await FirebaseFirestore.instance
          .collection('educations')
          .doc(id)
          .collection('education')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          listEducation.add(Education(
            id: doc['id'],
            title: doc['title'],
            issueYear: doc['issueYear'].toDate(),
            organization: doc['organization'],
          ));
        }
      }).then((value) => notifyListeners());
    }
    return listEducation;
  }

  Future<void> addEducation(
    String title,
    String organization,
    DateTime issueYear,
    String uid,
  ) async {
    await FirebaseFirestore.instance
        .collection('educations')
        .doc(uid)
        .collection('education')
        .add({
      'title': title,
      'organization': organization,
      'issueYear': issueYear
    }).then((value) {
      FirebaseFirestore.instance
          .collection('educations')
          .doc(uid)
          .collection('education')
          .doc(value.id)
          .set({
        'id': value.id,
        'title': title,
        'organization': organization,
        'issueYear': issueYear
      });
      listEducation.add(Education(
        id: value.id,
        title: title,
        issueYear: issueYear,
        organization: organization,
      ));
    }).whenComplete(() => notifyListeners());
  }

  Future<void> removeEducation(int index, String uid, String itemId) async {
    await FirebaseFirestore.instance
        .collection('educations')
        .doc(uid)
        .collection('education')
        .doc(itemId)
        .delete()
        .then((value) {
      print('THIS IS EDUCATION DELETED ID ITEM:' + itemId);
    }).whenComplete(() {
      listEducation.removeAt(index);
      notifyListeners();
    });
  }
}
