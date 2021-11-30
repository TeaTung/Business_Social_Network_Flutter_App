import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './round.dart';

class Process {
  final String id;
  final String uid;
  final String companyName;
  final String position;
  final List<Round> listRound;
  final String jobDescription;

  Process({
    required this.id,
    required this.uid,
    required this.companyName,
    required this.position,
    required this.listRound,
    required this.jobDescription,
  });
}

class Processes with ChangeNotifier {
  final List<Process> _items = [
    Process(
      id: 'id',
      uid: 'uid',
      companyName: 'VNG',
      position: 'Director',
      listRound: Rounds().listItem,
      jobDescription: 'Thís is fking v v v v v v  v v v vv v v v v v v v v v v v v v v v very long job description',
    ),
    Process(
      id: 'id',
      uid: 'uid',
      companyName: 'VNG',
      position: 'Director',
      listRound: Rounds().listItem,
      jobDescription: 'Thís is v v v v v  vv v v v v v v v v v v v v vv v v v v v v  fking long job description',
    ),
    Process(
      id: 'id',
      uid: 'uid',
      companyName: 'VNG',
      position: 'Director',
      listRound: Rounds().listItem,
      jobDescription: 'Thís is v v v v v v  v v v v vv v v v v vv v v v v v v v vv v fking long job description',
    ),
  ];

  List<Process> get items {
    return [..._items];
  }

  void removeProcess(int index) {
    if (index > 0 && index < items.length) _items.removeAt(index);
    notifyListeners();
  }
}
