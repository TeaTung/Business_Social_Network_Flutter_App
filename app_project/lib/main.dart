import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/widgets/educations_section.dart';

import './providers/account.dart';
import './providers/comments.dart';
import './providers/post.dart';
import './screens/account_screen.dart';
import './widgets/change_information_item.dart';
import '../navigators/bottom_navigator.dart';
import '../providers/posts.dart';
import '../widgets/setting_account.dart';
import 'navigators/bottom_navigator.dart';
import 'screens/notification_screen.dart';

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
          value: Accounts(),
        ),
        ChangeNotifierProvider(
          create: (_) => Posts(),
        ),
        ChangeNotifierProvider.value(
          value: PostDetail(),
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
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          SettingAccount.routeName: (ctx) => const SettingAccount(),
          ChangeInformation.routeName: (ctx) => const ChangeInformation(),
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
          ListPostScreen(),
          NotificationScreen(),
          Center(
            child: Text("Message",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
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
