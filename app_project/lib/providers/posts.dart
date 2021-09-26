import 'package:app_project/providers/post.dart';
import 'package:flutter/foundation.dart';

import 'comments.dart';

//This class get every post relate to user to load to main screen
class Posts with ChangeNotifier {
  List<Post> _items = [
    Post(
        postTime: DateTime.now(),
        id: "1",
        uid: "1",
        userAvtUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        userName: "Hello",
        content: "Helo",
        likeCount: 1,
        isBusinessPost: false,
        comments: null,
        imageUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
    Post(
        postTime: DateTime.now(),
        id: "1",
        uid: "1",
        userAvtUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        userName: "Hello",
        content: "Helo",
        likeCount: 1,
        isBusinessPost: false,
        comments: null,
        imageUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
    Post(
        postTime: DateTime.now(),
        id: "1",
        uid: "1",
        userAvtUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        userName: "Hello",
        content: "Helo",
        likeCount: 1,
        isBusinessPost: false,
        comments: null,
        imageUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")
  ];

  List<Post> get items {
    return [..._items];
  }

  void addPost(Post post) {
    _items.add(post);
    notifyListeners();
  }

  void removePost(int index) {
    if (index > 0 && index < items.length) _items.removeAt(index);
    notifyListeners();
  }
}