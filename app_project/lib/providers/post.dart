import 'package:flutter/foundation.dart';

import 'comments.dart';

//This class create individual post to load to posts list
class Post with ChangeNotifier {
  final String id;
  final String uid;
  final String userAvtUrl;
  final String userName;
  final String content;
  final int likeCount;
  final String? imageUrl;
  Comment? comments;
  final DateTime postTime;

  //Variables bellow point out that post is business post or not to add additional information to the post
  final bool isBusinessPost;
  final String? email;
  final String? phoneNumber;

  Post({
    required this.postTime,
    required this.id,
    required this.uid,
    required this.userAvtUrl,
    required this.userName,
    required this.content,
    required this.likeCount,
    required this.isBusinessPost,
    required this.comments,
    this.email,
    this.phoneNumber,
    this.imageUrl,
  });
}
