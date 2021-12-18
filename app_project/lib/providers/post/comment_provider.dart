import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CommentProvider {
  final String id;
  final String userId;
  final String imageUrl;
  final String content;

  CommentProvider({
    required this.content,
    required this.id,
    required this.userId,
    required this.imageUrl,
  });
}
