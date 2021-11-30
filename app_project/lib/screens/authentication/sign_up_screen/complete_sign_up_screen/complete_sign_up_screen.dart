import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteSignUpScreen extends StatelessWidget {
  static const String routeName = '/complete_sign_up';

  const CompleteSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Sign Up',
        ),
      ),
      body: Body(),
    );
  }
}
