import 'package:app_project/providers/post.dart';
import 'package:flutter/foundation.dart';

//This class get every post relate to user to load to main screen
class Posts with ChangeNotifier {
  List<Post> _items = [];

  List<Post> get items {
    return [..._items];
  }

  void addPost(Post post) {
    _items.add(post);
    notifyListeners();
  }
}
