import 'package:flutter/foundation.dart';

import 'account.dart';

class Followers with ChangeNotifier {
  List<Account> _items = [];

  List<Account> get items {
    return [..._items];
  }

  void fetchAndGetFollowers() {}
}
