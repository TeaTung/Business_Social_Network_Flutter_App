import 'package:flutter/foundation.dart';

class Comment {
  final String id;
  final String uid;
  final String userName;
  final String userAvatarUrl;
  final String userCommentText;
  final int numberOfLike;
  final DateTime date;

  Comment({
    required this.id,
    required this.uid,
    required this.userName,
    required this.userAvatarUrl,
    required this.userCommentText,
    required this.numberOfLike,
    required this.date,
  });
}

class CommentProvider with ChangeNotifier {
  List<Comment> _listComment = [
    Comment(
      numberOfLike: 0,
      id: 'id',
      userName: 'Thang',
      userCommentText: 'Comment ne',
      userAvatarUrl: 'https://picsum.photos/200/300.jpg',
      date: DateTime.now(),
      uid: 'p1',
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
