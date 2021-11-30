import 'package:flutter/material.dart';

import 'components/body.dart';


class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign_in';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {Navigator.pop(context);},
        ),
        centerTitle: true,
        title: const Text(
          'Sign In',
        ),
      ),
      body: Body(),
    );
  }
}
