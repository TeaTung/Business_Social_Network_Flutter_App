class Round {
  final String roundName;
  final bool isFinished;
  final DateTime deadline;
  final String description;

  Round({
    required this.roundName,
    required this.isFinished,
    required this.deadline,
    required this.description,
  });
}

class Rounds {
  List<Round> _listRound = [
    Round(
      roundName: 'CV',
      isFinished: true,
      deadline: DateTime.now(),
      description: 'This is description',
    ),
    Round(
      roundName: 'Test online',
      isFinished: true,
      deadline: DateTime.now(),
      description: 'This is description',
    ),
    Round(
      roundName: 'Interview',
      isFinished: false,
      deadline: DateTime.now(),
      description:
      'This is a super long description, which is made to test !!!! keke',
    ),
    Round(
      roundName: 'Interview 2',
      isFinished: false,
      deadline: DateTime.now(),
      description: 'This is description',
    ),
  ];

  List<Round> get listItem {
    return _listRound;
  }
}
