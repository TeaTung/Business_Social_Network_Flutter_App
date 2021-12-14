import 'package:flutter/material.dart';
import 'package:test_fix/widgets/change_password_item.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/ChangePasswordScreen';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Change password',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(248, 145, 71, 1),
            fontFamily: 'Helvetica',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(248, 145, 71, 1),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        reverse: true,
        child: ChangePasswordItem(),
      ),
    );
  }
}
