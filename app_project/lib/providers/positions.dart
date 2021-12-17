import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'position.dart';

//This class get every position relate to user to load to position section in Account screen
class Positions with ChangeNotifier {
  List<Position> listPosition = [];

  Future<List<Position>> getListPosition(String id) async {
    if (listPosition.isEmpty) {
      await FirebaseFirestore.instance
          .collection('positions')
          .doc(id)
          .collection('position')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          listPosition.add(Position(
            id: doc['id'],
            company: doc['company'],
            endDate: doc['endDate'].toDate(),
            startDate: doc['startDate'].toDate(),
            jobTitle: doc['jobTitle'],
          ));
        }
      });
    }
    return listPosition;
  }

  Future<void> addPosition(
    String company,
    String jobTitle,
    DateTime startDate,
    DateTime endDate,
    String uid,
  ) async {
    await FirebaseFirestore.instance
        .collection('positions')
        .doc(uid)
        .collection('position')
        .add({
      'company': company,
      'jobTitle': jobTitle,
      'startDate': startDate,
      'endDate': endDate,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('positions')
          .doc(uid)
          .collection('position')
          .doc(value.id)
          .set({
        'id': value.id,
        'company': company,
        'jobTitle': jobTitle,
        'startDate': startDate,
        'endDate': endDate,
      });
      listPosition.add(Position(
        id: value.id,
        jobTitle: jobTitle,
        startDate: startDate,
        endDate: endDate,
        company: company,
      ));
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> removePosition(
    int index,
    String uid,
    String itemId,
  ) async {
    await FirebaseFirestore.instance
        .collection('positions')
        .doc(uid)
        .collection('position')
        .doc(itemId)
        .delete()
        .then((value) {})
        .whenComplete(() {
      listPosition.removeAt(index);
      notifyListeners();
    });
  }
}
