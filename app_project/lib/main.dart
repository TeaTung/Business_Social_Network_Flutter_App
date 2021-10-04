import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/screens/notification_screen.dart';

import './navigators/bottom_navigator.dart';
import './providers/comments.dart';
import '../providers/posts.dart';
import '../screens/list_post_screen.dart';

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
          value: CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Posts(),
        ),
      ],
      child: MaterialApp(
        title: 'Business Social Network',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.workSansTextTheme(),
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
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
          Center(
            child: Text("User",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
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
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(MdiIcons.newspaperVariantOutline),
          title: const Text('Home'),
          iconSelect: const Icon(MdiIcons.newspaperVariant),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(MdiIcons.heartOutline),
          iconSelect: const Icon(MdiIcons.heart),
          title: const Text('Users'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(MdiIcons.messageOutline),
          iconSelect: const Icon(MdiIcons.message),
          title: const Text('Messages'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(MdiIcons.accountSettingsOutline),
          iconSelect: const Icon(MdiIcons.accountSettings),
          title: const Text('Settings'),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
