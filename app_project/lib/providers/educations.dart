import 'package:flutter/foundation.dart';

import 'education.dart';

//This class get every education relate to user to load to position section in Account screen
class Educations with ChangeNotifier {
  List<Education> _items = [];

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
