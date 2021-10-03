import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import './user.dart';
import 'comments.dart';

//This class create individual post to load to posts list
class Post with ChangeNotifier {
  final String id;
  final User user;
  final String content;
  int likeCount;
  final String? imageUrl;
  Comments? comments;
  bool isFavourite;
  final DateTime postTime;

  //Variables bellow point out that post is business post or not to add additional information to the post
  final bool isBusinessPost;
  final String? email;
  final String? phoneNumber;

  Post({
    this.isFavourite = false,
    required this.postTime,
    required this.id,
    required this.user,
    required this.content,
    required this.likeCount,
    required this.isBusinessPost,
    this.comments,
    this.email,
    this.phoneNumber,
    this.imageUrl,
  });
}

class PostDetail with ChangeNotifier {
  Post post = Post(
      postTime: DateTime.now(),
      id: "1",
      user: User(id: 'id',
        userName: 'Bopy',
        avatarUrl: "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      ),
      content: "Helo",
      likeCount: 1,
      isBusinessPost: false,
      comments: Comments(),
      isFavourite: false,
      imageUrl:
      "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
}