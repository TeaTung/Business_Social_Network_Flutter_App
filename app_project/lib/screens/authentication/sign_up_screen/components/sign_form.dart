import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/complete_sign_up_screen/complete_sign_up_screen.dart';
import 'form_error.dart';
import 'orange_button.dart';
import 'package:email_validator/email_validator.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(height: 36),
          buildPasswordFormField(),
          const SizedBox(height: 36),
          buildConfirmPasswordFormField(),
          const SizedBox(height: 20),
          FormError(errors: errors),
          const SizedBox(height: 20),
          OrangeButton(
            text: 'Continue',
            onPress: () {
              _formKey.currentState!.validate();
              if (errors.isEmpty) {
                _formKey.currentState!.save();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompleteSignUpScreen(),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(
                      arguments: {'email': email, 'password': password},
                    ),
                  ),
                );
              } else {}
            },
            isSolid: true,
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains('Please enter your email')) {
          setState(() {
            errors.remove('Please enter your email');
          });
        } else if (EmailValidator.validate(value) &&
            errors.contains('Your email is invalid')) {
          setState(() {
            errors.remove('Your email is invalid');
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains('Please enter your email')) {
          setState(() {
            errors.add('Please enter your email');
          });
        } else if (!EmailValidator.validate(value) &&
            !errors.contains('Your email is invalid') &&
            !errors.contains('Please enter your email')) {
          setState(() {
            errors.add('Your email is invalid');
          });
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your email',
        labelText: 'Email',
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 22, 0),
          child: SvgPicture.asset(
            'assets/icons/Mail.svg',
            height: 14,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: const TextStyle(
          color: Color.fromRGBO(248, 145, 71, 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty && errors.contains('Please enter your password')) {
          setState(() {
            errors.remove('Please enter your password');
          });
        } else if (value.isNotEmpty &&
            value.length >= 8 &&
            errors.contains('Your password is too short')) {
          setState(() {
            errors.remove('Your password is too short');
          });
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains('Please enter your password')) {
          setState(() {
            errors.add('Please enter your password');
          });
        } else if (value.length < 8 &&
            !errors.contains('Your password is too short') &&
            !errors.contains('Please enter your password')) {
          setState(() {
            errors.add('Your password is too short');
          });
        }
        return;
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        labelText: 'Password',
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 24, 0),
          child: SvgPicture.asset(
            'assets/icons/Lock.svg',
            height: 14,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: const TextStyle(
          color: Color.fromRGBO(248, 145, 71, 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        confirmPassword = value;
        if (value.isNotEmpty && errors.contains('Please enter your password')) {
          setState(() {
            errors.remove('Please enter your password');
          });
        } else if (password == confirmPassword) {
          setState(() {
            errors.remove('Your confirm password is not matched');
          });
        } else if (value.isNotEmpty &&
            errors.contains('Please re-enter your password')) {
          errors.remove('Please re-enter your password');
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty &&
            !errors.contains('Please re-enter your password')) {
          setState(() {
            errors.add('Please re-enter your password');
          });
        } else if (password != confirmPassword) {
          setState(() {
            errors.add('Your confirm password is not matched');
          });
        }
        return;
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Re-enter your password',
        labelText: 'Confirm Password',
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 24, 0),
          child: SvgPicture.asset(
            'assets/icons/Lock.svg',
            height: 14,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: const TextStyle(
          color: Color.fromRGBO(248, 145, 71, 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black12),
          gapPadding: 10,
        ),
      ),
    );
  }
}
