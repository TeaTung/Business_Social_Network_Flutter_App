import 'package:flutter/material.dart';
import 'package:test_fix/providers/user.dart';
import 'package:test_fix/widgets/detail_message_item_belong_to_me.dart';

class Message with ChangeNotifier {
  String content;

  String uid;
  String factorId;
  DateTime sentTime;

  Message(
      {required this.content,
      required this.uid,
      required this.sentTime,
      required this.factorId,
      this.hasBeenRead = false});

  bool hasBeenRead = false;
  MessageType messageType  = MessageType.UNREAD;
}
