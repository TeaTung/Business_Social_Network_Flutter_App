import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/SMS/providers/chat_provider.dart';
import 'package:test_fix/SMS/providers/friend_provider.dart';
import 'package:test_fix/SMS/providers/room_provider.dart';
import 'package:test_fix/SMS/rooms.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/providers/messages.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/screens/auth_wrapper.dart';
import 'package:test_fix/screens/detail_post_screen.dart';
import './providers/account.dart';
import './providers/comments.dart';
import 'providers/post_provider.dart';
import './providers/round.dart';
import 'providers/posts_provider.dart';
import './providers/process.dart';
import 'helpers/auth_services.dart';
import 'navigators/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);

    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider.value(
          value: Comments(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RoomProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Account(
            id: 'id',
            uid: 'uid',
            quote: 'This is just long quote',
            coverPhotoUrl:
                'https://elead.com.vn/wp-content/uploads/2020/04/13624171783_9f287bafdb_o.jpg',
            birthDate: DateTime.now(),
            nationality: 'United States',
            gender: 'Male',
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FriendProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserInfoLocal(
            uid: 'cSE9ecZUoNaFxSNKeluFHz9k5W92',
            userName: 'Tran Duc Tam',
            avatarUrl:
                'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PostsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PostDetail(),
        ),
        ChangeNotifierProvider.value(
          value: Processes(),
        ),
        ChangeNotifierProvider.value(
          value: Positions(),
        ),
        ChangeNotifierProvider.value(
          value: Educations(),
        ),
        ChangeNotifierProvider.value(
          value: Rounds(),
        ),
        ChangeNotifierProvider(
          create: (_) => Messages(),
        ),
      ],
      child: MaterialApp(
        title: 'Business Social Network',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              fontFamily: 'Helvetica',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          primaryColor: Colors.blue,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: routes,
        onGenerateRoute: (settings) {
          final args = settings.arguments as PostProvider;
          print(args);
          return MaterialPageRoute(
            builder: (context) {
              return DetailPostScreen(
                post: args,
              );
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AuthWrapper();
  }
}
