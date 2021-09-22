import 'package:app_project/providers/comment.dart';
import 'package:flutter/foundation.dart';

//This class manage all comments of post data, add, edit, fetch,...
class Comments with ChangeNotifier {
  List<Comment> _comments;
  Comments(this._comments);

  List<Comment> get comments {
    return [..._comments];
  }

  void fetchCommentsByIdPost() {}
}
