import 'package:flutter/material.dart';

import 'sigin_in_screen/components/orange_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Image.asset(
                'assets/images/sign_in.png',
                height: 300,
                width: 300,
              ),
              const Spacer(flex: 3),
              const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Hi there, Log in or Sign up \nto start your journey with FiWo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                  fontSize: 20,
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: OrangeButton(
                  text: 'Sign In',
                  onPress: () {
                    Navigator.pushNamed(context, '/sign_in');
                  },
                  isSolid: true,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: OrangeButton(
                  text: 'Sign Up',
                  onPress: () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
                  isSolid: false,
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
