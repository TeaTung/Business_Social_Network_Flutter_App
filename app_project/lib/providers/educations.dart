import 'package:flutter/foundation.dart';

import 'education.dart';

//This class get every education relate to user to load to position section in Account screen
class Educations with ChangeNotifier {
  List<Education> _items = [
    Education(
        id: '123',
        uid: '321',
        title: 'BA Bachelor',
        issueYear: DateTime.now(),
        organization: 'UIT',
        credentialUrl: 'https://www.google.com',
        description: 'This is description'),
    Education(
      id: '123',
      uid: '321',
      title: 'BA Bachelor',
      issueYear: DateTime.now(),
      organization: 'UIT',
      credentialUrl: 'https://www.google.com',
    ),
    Education(
      id: '123',
      uid: '321',
      title: 'BA Bachelor',
      issueYear: DateTime.now(),
      organization: 'UIT',
    ),
    Education(
      id: '123',
      uid: '321',
      title: 'BA Bachelor',
      issueYear: DateTime.now(),
      organization: 'UIT',
    ),
  ];

  List<Education> get items {
    return [..._items];
  }

  void addPosition(Education education) {
    _items.add(education);
    notifyListeners();
  }

  void removePosition(int index) {
    if (index > 0 && index < items.length) _items.removeAt(index);
    notifyListeners();
  }
}
