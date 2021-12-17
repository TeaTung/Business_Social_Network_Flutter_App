import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Signed In';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed Up';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<bool> isSignUp() async {
    bool isSignUpYet = false;
      print('JUMPED IN METHOD');
      User user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          print('RETURN IN CHECK: TRUE');
          isSignUpYet = true;

        } else {
          print('RETURN IN CHECK: FALSE');
          isSignUpYet = false;
        }
      });
    return isSignUpYet;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
