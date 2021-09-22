import 'package:flutter/foundation.dart';

class Comment {
  final String id;
  final String userName;
  final String userImageUrl;
  final String userCommentText;

  Comment({
    required this.id,
    required this.userName,
    required this.userImageUrl,
    required this.userCommentText,
  });
}

class CommentProvider with ChangeNotifier {
  List<Comment> _listComment = [];

  List<Comment> get listComment {
    return _listComment;
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
