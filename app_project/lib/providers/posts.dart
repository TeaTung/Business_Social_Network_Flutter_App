import 'package:flutter/foundation.dart';

import '../providers/post.dart';
import '../providers/user.dart';

//This class get every post relate to user to load to main screen
class Posts with ChangeNotifier {
  List<Post> _items = [
    Post(
        postTime: DateTime.now(),
        id: "1",
        user: User(
          uid: 'id',
          userName: 'Bopy',
          avatarUrl:
              "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        ),
        content: "Hello world !!! This is a very long description in a post <3",
        likeCount: 0,
        isBusinessPost: true,
        comments: null,
        imageUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
    Post(
        postTime: DateTime.now(),
        id: "1",
        user: User(
          uid: 'Hello world !!! This is a very long description in a post <3',
          userName: 'Bopy',
          avatarUrl:
              "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        ),
        content: "Helo",
        likeCount: 1,
        isBusinessPost: false,
        imageUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
    Post(
        postTime: DateTime.now(),
        id: "1",
        user: User(
          uid: 'id',
          userName: 'Bopy',
          avatarUrl:
              "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        ),
        content: "Helo",
        likeCount: 1,
        isBusinessPost: false,
        comments: null,
        imageUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
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
