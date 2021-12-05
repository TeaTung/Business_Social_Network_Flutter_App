import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/complete_sign_up_screen/complete_sign_up_screen.dart';

import 'auth_services.dart';

class FacebookAuthController with ChangeNotifier {
  dynamic _facebookUserData;
  bool _isLogin = false;

  dynamic get facebookUserData => _facebookUserData.toString();

  bool get isLogin => _isLogin;

  logIn() async {
    final LoginResult loginResult;
    // Trigger the sign-in flow
    try {
      loginResult = await FacebookAuth.instance.login();
    } catch (e) {
      _isLogin = false;
      return;
    }
    _isLogin = true;
    _facebookUserData =
        await FacebookAuth.instance.getUserData(fields: 'email');

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}

loginWithFacebook(BuildContext context) async {
  var facebookAuthProvider =
      Provider.of<FacebookAuthController>(context, listen: false);
  await facebookAuthProvider.logIn();
  bool isSignUp = await AuthService.isSignUp();
  if (facebookAuthProvider.isLogin && isSignUp == false) {
    String email = facebookAuthProvider.facebookUserData;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CompleteSignUpScreen(),
        // Pass the arguments as part of the RouteSettings. The
        // DetailScreen reads the arguments from these settings.
        settings: RouteSettings(
          arguments: {'email': email, 'password': '_'},
        ),
      ),
    );
  } else if (facebookAuthProvider.isLogin && isSignUp == true) {
    Navigator.pushNamed(context, '/auth_wrapper');
  } else {
    const snackBar =
        SnackBar(content: Text('Problem with facebook authentication'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
