import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/SMS/providers/chat_provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'chat.dart';
import 'login.dart';
import 'friend.dart';
import 'util.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  bool _error = false;
  bool _initialized = false;
  User? _userAuth;
  types.User? user;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _userAuth = user;
        });
      });

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _userAuth!.uid,
        );

        color = getUserAvatarNameColor1(otherUser);
      } catch (e) {
        // Do nothing if other user is not found
      }
    }
    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: hasImage ? Colors.transparent : color,
        image: hasImage
            ? DecorationImage(
                image: NetworkImage(room.imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: const BorderRadius.all(Radius.circular(55.0)),
        border: Border.all(
          color: Colors.black,
          width: 4.0,
        ),
      ),
      child: !hasImage
          ? Text(
              name.isEmpty ? '' : name[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final userInforProvider = Provider.of<UserInfoLocal>(context);
    if (_error) {
      return Container();
    }

    if (!_initialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _userAuth == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => FriendPage(
                          userAuth: _userAuth,
                        ),
                      ),
                    );
                  },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _userAuth == null ? null : logout,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          userInforProvider.userName,
          style: GoogleFonts.workSans().copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: _userAuth == null
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not authenticated'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            )
          : StreamBuilder<List<types.Room>>(
              stream: chatProvider.getUserRooms(),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: const Text('No rooms'),
                  );
                }

                return Container(
                  color: Colors.white,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 6,
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        final room = snapshot.data![index];
                        print(room);
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  roomId: room.id,
                                  otherUserId: room.users.last.id,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 7,
                            ),
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildAvatar(room),
                                  Text(
                                    room.name ?? '',
                                    style: GoogleFonts.ubuntu()
                                        .copyWith(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
