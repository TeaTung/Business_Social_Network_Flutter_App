import 'package:flutter/foundation.dart';

//This class manage individual comment data, comment can be deleted and liked
class Comment with ChangeNotifier {
  String postId;
  String id;
  DateTime postTime;
  String content;
  int likeCount = 0;

  Comment({
    required this.postId,
    required this.id,
    required this.postTime,
    required this.content,
  });

  void toggleLike() {
    notifyListeners();
  }
}
