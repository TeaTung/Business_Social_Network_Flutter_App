import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_fix/navigators/bottom_navigator.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/screens/chat/rooms.dart';
import 'package:test_fix/screens/detail_business_post_screen.dart';
import 'package:test_fix/screens/post/create_normal_post_screen.dart';
import 'package:test_fix/screens/post_business/create_business_post_screen.dart';
import 'package:test_fix/screens/post/list_post_screen.dart';
import 'package:test_fix/screens/post_business/create_process_detail_screen.dart';
import 'package:test_fix/screens/post_business/create_process_post_screen.dart';
import 'package:test_fix/screens/process_detail_screen.dart';
import 'account_screen.dart';
import 'notification_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'overview_message_screen.dart';
import 'process_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  static const String routeName = '/auth_wrapper';

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  int _currentIndex = 0;

  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    if (user != null) {
      return _authSuccessScreen();
    }
    return _notAuth();
  }

  Widget _notAuth() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnBoardingScreen(),
    );
  }

  Widget _authSuccessScreen() {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          // ListPostScreen(),
          //RoomsPage(),

          //DetailBusinessPostScreen(),

          //CreateProcessPostScreen(),
          ListPostScreen(),
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
          icon: const Icon(MdiIcons.newspaperVariantOutline),
          title: const Text('Home'),
          iconSelect: const Icon(MdiIcons.newspaperVariant),
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.work_outline),
          title: const Text('Job'),
          iconSelect: const Icon(Icons.work),
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
          icon: const Icon(MdiIcons.heartOutline),
          iconSelect: const Icon(MdiIcons.heart),
          title: const Text('Notification'),
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
