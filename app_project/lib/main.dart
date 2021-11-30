import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/providers/messages.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/screens/account_screen.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/complete_sign_up_screen/complete_sign_up_screen.dart';
import 'package:test_fix/screens/authentication/welcome_screen.dart';
import 'package:test_fix/screens/list_post_screen.dart';
import 'package:test_fix/widgets/follower_item.dart';
import './navigators/bottom_navigator.dart';
import './providers/account.dart';
import './providers/comments.dart';
import './providers/post.dart';
import './providers/round.dart';
import './providers/posts.dart';
import './providers/process.dart';
import './screens/account_screen.dart';
import './screens/notification_screen.dart';
import './screens/process_screen.dart';
import './widgets/change_information_item.dart';
import './widgets/setting_account.dart';
import './screens/detail_post_screen.dart';
import './screens/detail_business_post_screen.dart';
import './widgets/overview_message_item.dart';
import './screens/detail_message_screen.dart';
import './screens/overview_message_screen.dart';
import 'helpers/auth_services.dart';
import 'screens/authentication/sigin_in_screen/sign_in_screen.dart';
import 'screens/authentication/sign_up_screen/sign_up_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';


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
          create: (context) => context.read<AuthService>().authStateChanges, initialData: null,
        ),
        ChangeNotifierProvider.value(
          value: Comments(),
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
        ChangeNotifierProvider.value(
          value: UserInfoLocal(
            uid: '123',
            userName: 'Nguyễn Dương Tùng',
            avatarUrl:
            'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1',
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Posts(),
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
            titleTextStyle: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w500),
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
        routes: {
          SettingAccount.routeName: (ctx) => const SettingAccount(),
          ChangeInformation.routeName: (ctx) => const ChangeInformation(),
          DetailBusinessPostScreen.routeName: (ctx) =>
              const DetailBusinessPostScreen(),
          DetailPostScreen.routeName: (ctx) => const DetailPostScreen(),
          AccountScreen.routeName: (ctx) => const AccountScreen(),
          OverViewMessageItem.routeName: (ctx) => DetailMessageScreen(),
          OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          CompleteSignUpScreen.routeName: (ctx) => CompleteSignUpScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen(),
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
    // return Scaffold(
    //   body: PageView(
    //     controller: controller,
    //     children: [
    //       ListPostScreen(),
    //       ProcessScreen(),
    //       OverviewMessageScreen(),
    //       NotificationScreen(),
    //       // FollowerItem(),
    //       AccountScreen(),
    //     ],
    //     onPageChanged: (index) {
    //       setState(() {
    //         _currentIndex = index;
    //       });
    //     },
    //   ),
    //   bottomNavigationBar: _buildBottomBar(),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: WelcomeScreen(),
    );
  }

  int _currentIndex = 0;
  PageController controller = PageController(
    initialPage: 0,
  );

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 55,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
        controller.animateToPage(_currentIndex,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(MdiIcons.newspaperVariantOutline),
          title: Text('Home'),
          iconSelect: Icon(MdiIcons.newspaperVariant),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.work_outline),
          title: Text('Job'),
          iconSelect: Icon(Icons.work),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(MdiIcons.messageOutline),
          iconSelect: Icon(MdiIcons.message),
          title: Text('Messages'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(MdiIcons.heartOutline),
          iconSelect: Icon(MdiIcons.heart),
          title: Text('Notification'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(MdiIcons.accountSettingsOutline),
          iconSelect: Icon(MdiIcons.accountSettings),
          title: Text('Settings'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
