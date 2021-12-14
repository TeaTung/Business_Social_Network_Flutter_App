import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/complete_sign_up_screen/complete_sign_up_screen.dart';

import 'auth_services.dart';

class GoogleAuthController with ChangeNotifier{
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleUser;

  GoogleSignInAccount get googleUser => _googleUser!;

  logIn() async {
    final googleAccount = await _googleSignIn.signIn();
    if(googleAccount == null) return;
    _googleUser = googleAccount;

    final googleAuth = await _googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}

loginWithGoogle(BuildContext context) async{
  var googleAuthProvider =
  Provider.of<GoogleAuthController>(context,
      listen: false);

  await googleAuthProvider.logIn();
  bool isSignUp = await AuthService.isSignUp();
  if (googleAuthProvider.googleUser != null &&
      isSignUp == false) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CompleteSignUpScreen(),
        // Pass the arguments as part of the RouteSettings. The
        // DetailScreen reads the arguments from these settings.
        settings: RouteSettings(
          arguments: {
            'email': googleAuthProvider.googleUser.email,
            'password': '_'
          },
        ),
      ),
    );
  } else if (googleAuthProvider.googleUser != null &&
      isSignUp == true) {
    Navigator.pushNamed(context, '/auth_wrapper');
  } else {
    const snackBar = SnackBar(
        content:
        Text('Problem with google authentication'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
