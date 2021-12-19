import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/chats/chat_provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'chat_screen.dart';
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

  Widget _buildAvatar({
    required String roomType,
    required String otherUserAvatarUrl,
    required String otherUserId,
    required String roomName,
  }) {
    final color = getUserAvatarNameColor(otherUserId);

    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(55.0)),
        border: Border.all(
          color: Colors.black,
          width: 4.0,
        ),
      ),
      child: Center(
          child: Text(
        roomName[0],
        style: GoogleFonts.workSans(
          color: Colors.white,
          fontSize: 18,
        ),
      )),
      // child: Text(
      //   roomName,
      //   style: const TextStyle(color: Colors.white),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
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
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _userAuth == null
                ? null
                : () {
                    Navigator.pushNamed(
                      context,
                      FriendPage.routedName,
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
          userInforProvider.getUserName,
          style: GoogleFonts.workSans().copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
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
          : StreamBuilder<QuerySnapshot>(
              stream: chatProvider.getUserRooms(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading"));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: const Text('No rooms'),
                  );
                }
                // if (!snapshot.hasData) {
                //   return Container(
                //     alignment: Alignment.center,
                //     margin: const EdgeInsets.only(
                //       bottom: 200,
                //     ),
                //     child: const Text('No rooms'),
                //   );
                // }

                return Container(
                  color: Colors.white,
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      String otherUserid = List<String>.from(data['userIds'])
                          .firstWhere((id) => id != _userAuth!.uid);

                      String otherUserName =
                          (FirebaseChatCore.instance.firebaseUser!.uid !=
                                  data['otherUserId'])
                              ? data['name1']
                              : data['name2'];

                      String otherUserAvatar =
                          (FirebaseChatCore.instance.firebaseUser!.uid !=
                                  data['otherUserId'])
                              ? data['name1']
                              : data['name2'];

                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider.value(
                                  value: Provider.of<UserInfoLocal>(context),
                                  child: ChatScreen(
                                    roomId: document.id,
                                    otherUserId: otherUserid,
                                    otherUserAvatarUrl: otherUserAvatar,
                                    otherUserName: otherUserName,
                                  ),
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
                                  _buildAvatar(
                                    otherUserAvatarUrl: otherUserAvatar,
                                    otherUserId: otherUserid,
                                    roomName: otherUserName,
                                    roomType: 'direct',
                                  ),
                                  Text(
                                    otherUserName,
                                    style: GoogleFonts.ubuntu()
                                        .copyWith(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ));
                    }).toList(),

//                               children: snapshot.data!.docs.map((DocumentSnapshot document) {

// :   snapshot.data!.docs.length,
//                       (index) {
//                         final room = snapshot.data![index];
//                         print(room);
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => ChatPage(
//                                   roomId: room.id,
//                                   otherUserId: room.users.last.id,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(
//                               vertical: 3,
//                               horizontal: 7,
//                             ),
//                             child: Card(
//                               elevation: 0,
//                               color: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(13.0),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   _buildAvatar(room),
//                                   Text(
//                                     room.name ?? '',
//                                     style: GoogleFonts.ubuntu()
//                                         .copyWith(fontSize: 15),
//                                   )
//                                 ],
//                               ),
//                             ),
//                         );
//                       },
//                     ),
                  ),
                );
              },
            ),
    );
  }
}
