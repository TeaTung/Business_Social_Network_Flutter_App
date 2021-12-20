import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/chats/chat_provider.dart';
import 'package:test_fix/providers/chats/friend_provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'chat_screen.dart';
import 'util.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class FriendPage extends StatelessWidget {
  static const routedName = '/FRIENDPAGE';

  const FriendPage({
    Key? key,
  }) : super(key: key);

  void _handlePressed(UserInfoLocal otherUser, BuildContext context) async {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    types.Room room;
    final userInfoLocal = Provider.of<UserInfoLocal>(context, listen: false);

    String roomId = await chatProvider.hasCreatedRoomAlready(
        otherUserId: otherUser.uid,
        userId: FirebaseChatCore.instance.firebaseUser!.uid);

    if (roomId == 'NotCreated') {
      room = await chatProvider.createRoom(
        otherUser,
        userInfoLocal,
      );
      roomId = room.id;
    }

    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          roomId: roomId,
          otherUserId: otherUser.uid,
          // otherUserAvatarUrl: otherUser.avatarUrl,
          otherUserName: otherUser.userName,
        ),
      ),
    );
  }

  Widget _buildAvatar(UserInfoLocal user) {
    final color = getUserAvatarNameColor(user.uid);
    final hasImage = user.avatarUrl.isNotEmpty;
    final name = user.userName;

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage:
            hasImage ? CachedNetworkImageProvider(user.avatarUrl) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FriendProvider friendProvider =
        Provider.of<FriendProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          "Friends",
          style: GoogleFonts.workSans().copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<List<UserInfoLocal>>(
        stream: friendProvider.getFriends(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No users'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];

              return GestureDetector(
                onTap: () {
                  _handlePressed(user, context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildAvatar(user),
                      Text(user.userName),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
