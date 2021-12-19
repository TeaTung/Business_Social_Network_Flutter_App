import 'package:flutter/material.dart';
import 'package:test_fix/providers/mesage.dart';

class Messages with ChangeNotifier {
  List<Message> _messages = [
    // UNREAD MESS
    Message(
      content: "Hello there again !",
      uid: "id",
      sentTime: DateTime.now(),
      factorId: "dragleoId",
    ),
    Message(
      content: "Hello there again !",
      uid: "dragleoId",
      sentTime: DateTime.now(),
      factorId: "id",
    ),
    Message(
      content: "Hello there again !",
      uid: "dragleoId",
      sentTime: DateTime.now(),
      factorId: "id",
    ),
    Message(
      content: "Hello there again !",
      uid: "dragleoId",
      sentTime: DateTime.now(),
      factorId: "id",
    ),

    Message(
      content: "Hello there again !",
      uid: "id",
      sentTime: DateTime.now(),
      factorId: "kakaId",
      hasBeenRead: true,
    ),

    // OTHER MESS
    Message(
      content: "Hello there again !",
      uid: "quoeId",
      sentTime: DateTime.now(),
      factorId: "id",
      hasBeenRead: true,
    ),
  ];

  List<Message> get messages {
    return [..._messages];
  }

  void sendMessage(
      String content, String uid, String userImTalkingtoId, DateTime sentTime) {
    _messages.add(Message(
      content: content,
      uid: uid,
      sentTime: DateTime.now(),
      factorId: userImTalkingtoId,
      hasBeenRead: true,
    ));
    notifyListeners();
  }
}
