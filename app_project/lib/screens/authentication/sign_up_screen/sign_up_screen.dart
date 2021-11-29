import 'package:flutter/material.dart';

import 'components/body.dart';


class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign_in';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: null,
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
