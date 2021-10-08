import 'package:flutter/foundation.dart';

import './user.dart';

class Comment with ChangeNotifier {
  final String id;
  final User user;
  final String userCommentText;
  final int numberOfLike;
  final DateTime date;

  Comment({
    required this.id,
    required this.user,
    required this.userCommentText,
    required this.numberOfLike,
    required this.date,
  });
}

class Comments with ChangeNotifier {
  List<Comment> _listComment = [
    Comment(
      numberOfLike: 0,
      id: 'id',
      userCommentText: 'Comment neeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
      date: DateTime.now(),
      user: User(
        uid: 'as',
        userName: 'Nguyễn Võ Đức Thắng',
        avatarUrl: 'https://picsum.photos/200/300.jpg',
      ),
    ),
    Comment(
      numberOfLike: 0,
      id: 'id',
      userCommentText: 'Comment ne',
      date: DateTime.now(),
      user: User(
        uid: 'as',
        userName: 'Nguyễn Võ Đức Thắng',
        avatarUrl: 'https://picsum.photos/200/300.jpg',
      ),
    ),
  ];

  List<Comment> get listComment {
    return [..._listComment];
  }

  void addComment(Comment comment) {
    _listComment.add(comment);
    notifyListeners();
  }

  int get length {
    return listComment.length;
  }

  void removeComment(String id) {
    _listComment.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
