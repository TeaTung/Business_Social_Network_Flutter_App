import 'package:flutter/cupertino.dart';

class Round {
  final String roundTitle;
  final bool isFinished;
  final DateTime deadline;
  final String description;

  Round({
    required this.roundTitle,
    required this.isFinished,
    required this.deadline,
    required this.description,
  });
}

class Rounds with ChangeNotifier {
  List<Round> _listRound = [
    Round(
      roundTitle: 'CV',
      isFinished: true,
      deadline: DateTime.now(),
      description: 'This is description',
    ),
    Round(
      roundTitle: 'Test online',
      isFinished: true,
      deadline: DateTime.now(),
      description: 'This is description',
    ),
    Round(
      roundTitle: 'Interview',
      isFinished: false,
      deadline: DateTime.now(),
      description:
          'This is a super long description, which is made to test !!!! keke',
    ),
    Round(
      roundTitle: 'Interview 2',
      isFinished: false,
      deadline: DateTime.now(),
      description: 'This is description',
    ),
  ];

  List<Round> get listItem {
    return _listRound;
  }
}
