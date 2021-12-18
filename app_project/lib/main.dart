import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/accounts.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/providers/messages.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/providers/post/post_provider.dart';
import 'package:test_fix/providers/post/posts_provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/screens/onboarding/onboarding_screen.dart';
import 'package:test_fix/screens/post/detail_post_screen.dart';
import './providers/account.dart';
import './providers/comments.dart';
import './providers/round.dart';
import './providers/posts.dart';
import './providers/process.dart';
import 'helpers/auth_services.dart';
import 'helpers/facebook_auth_controller.dart';
import 'helpers/google_auth_controller.dart';
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
        ChangeNotifierProvider.value(
          value: Accounts(),
        ),
        ChangeNotifierProvider.value(
          value: Account(
            email: '',
            id: '',
            uid: '',
            quote: '',
            coverPhotoUrl: '',
            birthDate: DateTime.now(),
            nationality: '',
            gender: '',
            userName: '',
            avatarUrl: '',
          ),
        ),
        FutureProvider.value(
          value: UserInfoLocal.fromFirebase(),
          initialData: null,
        ),

        // this is for post
        ChangeNotifierProvider(
          create: (_) => Posts(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostsProvider(),
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
        ChangeNotifierProvider(
          create: (_) => GoogleAuthController(),
        ),
        ChangeNotifierProvider(
          create: (_) => FacebookAuthController(),
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
    return OnBoardingScreen();
  }
}
