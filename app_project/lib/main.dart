import 'package:test_fix/providers/messages.dart';
import 'package:test_fix/screens/detail_message_screen.dart';
import 'package:test_fix/screens/overview_message_screen.dart';
import '../providers/posts.dart';
import '../screens/list_post_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/providers/user.dart';
import 'package:test_fix/screens/account_screen.dart';
import 'package:test_fix/screens/list_post_screen.dart';
import './navigators/bottom_navigator.dart';
import './providers/account.dart';
import './providers/comments.dart';
import './providers/post.dart';
import './providers/posts.dart';
import './providers/process.dart';
import './screens/account_screen.dart';
import 'widgets/overview_messsage_item.dart';
import './screens/notification_screen.dart';
import './screens/process_screen.dart';
import './widgets/change_information_item.dart';
import './widgets/setting_account.dart';
import './screens/detail_post_screen.dart';


void main() {
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
          value: User(
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
        ChangeNotifierProvider(
          create: (_) => Messages(),
        ChangeNotifierProvider.value(
          value: Processes(),
        ),
        ChangeNotifierProvider.value(
          value: Positions(),
        ),
        ChangeNotifierProvider.value(
          value: Educations(),
        ),
      ],
      child: MaterialApp(
        title: 'Business Social Network',
        theme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              fontFamily: 'Helvetica',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: DetailPostScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          SettingAccount.routeName: (ctx) => const SettingAccount(),
          ChangeInformation.routeName: (ctx) => const ChangeInformation(),
          OverViewMessageItem.routeName: (ctx) => DetailMessageScreen(),
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
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          //ListPostScreen(),
         // DetailMessageScreen(),
          OverviewMessageScreen(),
          ListPostScreen(),
          NotificationScreen(),
          //FollowerItem(),
          AccountScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
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
          icon: Icon(MdiIcons.heartOutline),
          iconSelect: Icon(MdiIcons.heart),
          title: Text('Users'),
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
