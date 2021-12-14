import 'package:flutter/material.dart';
import 'package:test_fix/screens/account_screen.dart';
import 'package:test_fix/screens/add_education_screen.dart';
import 'package:test_fix/screens/add_position_screen.dart';
import 'package:test_fix/screens/auth_wrapper.dart';
import 'package:test_fix/screens/authentication/forgot_password_screen/forgot_password_screen.dart';
import 'package:test_fix/screens/authentication/sigin_in_screen/sign_in_screen.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/complete_sign_up_screen/complete_sign_up_screen.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:test_fix/screens/authentication/welcome_screen.dart';
import 'package:test_fix/screens/change_password_screen.dart';
import 'package:test_fix/screens/change_picture_screen.dart';
import 'package:test_fix/screens/detail_business_post_screen.dart';
import 'package:test_fix/screens/detail_message_screen.dart';
import 'package:test_fix/screens/detail_post_screen.dart';
import 'package:test_fix/screens/education_screen.dart';
import 'package:test_fix/screens/onboarding/onboarding_screen.dart';
import 'package:test_fix/screens/positon_screen.dart';
import 'package:test_fix/widgets/change_information_item.dart';
import 'package:test_fix/screens/change_information_screen.dart';
import 'package:test_fix/widgets/overview_message_item.dart';
import 'package:test_fix/screens/setting_account_screen.dart';

var routes = <String, WidgetBuilder>{
  DetailBusinessPostScreen.routeName: (ctx) => const DetailBusinessPostScreen(),
  DetailPostScreen.routeName: (ctx) => const DetailPostScreen(),
  AccountScreen.routeName: (ctx) => const AccountScreen(),
  OverViewMessageItem.routeName: (ctx) => DetailMessageScreen(),
  OnBoardingScreen.routeName: (ctx) => const OnBoardingScreen(),
  SignUpScreen.routeName: (ctx) => const SignUpScreen(),
  CompleteSignUpScreen.routeName: (ctx) => const CompleteSignUpScreen(),
  SignInScreen.routeName: (ctx) => const SignInScreen(),
  WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
  AuthWrapper.routeName: (ctx) => const AuthWrapper(),
  ChangeInformationScreen.routeName: (ctx) => const ChangeInformationScreen(),
  SettingAccountScreen.routeName: (ctx) => const SettingAccountScreen(),
  ChangePasswordScreen.routeName: (ctx) => const ChangePasswordScreen(),
  EducationScreen.routeName: (ctx) => const EducationScreen(),
  AddEducationScreen.routeName: (ctx) => const AddEducationScreen(),
  PositionScreen.routeName: (ctx) => const PositionScreen(),
  AddPositionScreen.routeName: (ctx) => const AddPositionScreen(),
  ChangePictureScreen.routeName: (ctx) => const ChangePictureScreen(),
  ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
};
