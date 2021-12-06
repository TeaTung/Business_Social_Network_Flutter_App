import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class RoomProvider with ChangeNotifier {
  Stream getRoomById(String id) {
    return FirebaseChatCore.instance.room(id);
  }
}
