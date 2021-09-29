import 'package:flutter/foundation.dart';

import 'position.dart';

//This class get every position relate to user to load to position section in Account screen
class Positions with ChangeNotifier {
  List<Position> _items = [];

  List<Position> get items {
    return [..._items];
  }

  void addPosition(Position position) {
    _items.add(position);
    notifyListeners();
  }

  void removePosition(int index) {
    if (index > 0 && index < items.length) _items.removeAt(index);
    notifyListeners();
  }
}
