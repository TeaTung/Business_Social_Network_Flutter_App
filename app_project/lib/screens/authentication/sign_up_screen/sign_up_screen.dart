import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign_up';

  const SignUpScreen({Key? key}) : super(key: key);

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
        title: const Text(
          'Sign Up',
        ),
      ),
      body: Body(),
    );
  }
}
