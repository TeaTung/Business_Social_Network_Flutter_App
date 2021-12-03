import 'package:flutter/material.dart';
import 'package:test_fix/screens/account_screen.dart';
import 'package:test_fix/screens/auth_wrapper.dart';
import 'package:test_fix/screens/authentication/sigin_in_screen/sign_in_screen.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/complete_sign_up_screen/complete_sign_up_screen.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:test_fix/screens/authentication/welcome_screen.dart';
import 'package:test_fix/screens/detail_business_post_screen.dart';
import 'package:test_fix/screens/detail_message_screen.dart';
import 'package:test_fix/screens/detail_post_screen.dart';
import 'package:test_fix/screens/onboarding/onboarding_screen.dart';
import 'package:test_fix/widgets/change_information_item.dart';
import 'package:test_fix/widgets/overview_message_item.dart';
import 'package:test_fix/widgets/setting_account.dart';

var routes = <String, WidgetBuilder>{
  ChangeInformation.routeName: (ctx) => const ChangeInformation(),
  DetailBusinessPostScreen.routeName: (ctx) => const DetailBusinessPostScreen(),
  DetailPostScreen.routeName: (ctx) => const DetailPostScreen(),
  AccountScreen.routeName: (ctx) => const AccountScreen(),
  OverViewMessageItem.routeName: (ctx) => DetailMessageScreen(),
  OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
  SignUpScreen.routeName: (ctx) => SignUpScreen(),
  CompleteSignUpScreen.routeName: (ctx) => CompleteSignUpScreen(),
  SignInScreen.routeName: (ctx) => SignInScreen(),
  WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
  AuthWrapper.routeName: (ctx) => AuthWrapper(),
};