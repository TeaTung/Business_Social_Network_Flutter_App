import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'sign_form.dart';
import 'social_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 36),
              const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sign up with your detail \nor continue with social media',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 46),
              const SignForm(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(
                    icon: 'assets/icons/google-icon.svg',
                    press: () {},
                  ),
                  SocialButton(
                    icon: 'assets/icons/facebook-2.svg',
                    press: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'By continue you agree to our \nTerm and Condition',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 46),
            ],
          ),
        ),
      )),
    );
  }
}
