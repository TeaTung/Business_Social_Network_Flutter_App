import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:test_fix/helpers/auth_services.dart';
import './orange_button.dart';
import 'package:provider/provider.dart';
import 'form_error.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String email;
  late String password;
  bool rememberMe = false;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(height: 36),
          FormError(errors: errors),
          const SizedBox(height: 46),
          OrangeButton(
            text: 'Send Link',
            onPress: (){
              _formKey.currentState!.validate();
              if (errors.isEmpty) {
                try {
                  context
                      .read<AuthService>().sendPasswordResetEmail(email);
                  const snackBar =
                  SnackBar(content: Text('We have sent recovery email for you'));
                  Navigator.pushNamed(context, '/sign_in');
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }catch(e){
                  const snackBar =
                  SnackBar(content: Text('Problem with authentication process'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
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
        email = value;
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
}
