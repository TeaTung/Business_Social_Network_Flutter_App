import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './round.dart';

class Process {
  final String id;
  final String uid;
  final String companyName;
  final String position;
  final List<Round> listRound;

  Process({
    required this.id,
    required this.uid,
    required this.companyName,
    required this.position,
    required this.listRound,
  });
}

class Processes with ChangeNotifier {
  List<Process> _items = [
    Process(
      id: 'id',
      uid: 'uid',
      companyName: 'VNG',
      position: 'Director',
      listRound: Rounds().listItem,
    ),
    Process(
      id: 'id',
      uid: 'uid',
      companyName: 'VNG',
      position: 'Director',
      listRound: Rounds().listItem,
    ),
    Process(
      id: 'id',
      uid: 'uid',
      companyName: 'VNG',
      position: 'Director',
      listRound: Rounds().listItem,
    ),
  ];

  List<Process> get items {
    return [..._items];
  }
}
