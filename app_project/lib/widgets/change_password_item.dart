import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/screens/authentication/forgot_password_screen/components/form_error.dart';

import 'customer_button.dart';

class ChangePasswordItem extends StatefulWidget {
  const ChangePasswordItem({Key? key}) : super(key: key);

  @override
  _ChangePasswordItemState createState() => _ChangePasswordItemState();
}

class _ChangePasswordItemState extends State<ChangePasswordItem> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  var newPassword = '';
  var oldPassword = '';
  var confirmPassword = '';
  bool isCurrentPassword = true;

  @override
  Widget build(BuildContext context) {
    final Account account = Provider.of<Account>(context);

    Future<bool> validateCurrentPassword() async {
      return await account.validateCurrentPassword(oldPassword, account.email);
    }

    void isPasswordValid() async {
      validateCurrentPassword().then((value) {
        isCurrentPassword = value;
      }).whenComplete(() {
        if (!isCurrentPassword) {
          if (!errors.contains("The old password is invalid")) {
            setState(() {
              errors.add("The old password is invalid");
            });
          }
        } else if (isCurrentPassword){
          if (errors.contains("The old password is invalid")) {
            setState(() {
              errors.remove("The old password is invalid");
            });
          }
        }
        _formKey.currentState!.validate();
        if (errors.isEmpty) {
          _formKey.currentState!.save();
          account.updatePassword(newPassword);
          Navigator.of(context).pop();
        }
      });
    }

    void savePassword() {
      isPasswordValid();
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildOldPasswordFormField(
              'Old password',
              Icons.lock_open_outlined,
            ),
            buildNewPasswordFormField(
              'New password',
              Icons.lock_outline,
            ),
            buildConfirmPasswordFormField(
              'Confirm password',
              Icons.lock_rounded,
            ),
            FormError(errors: errors),
            const SizedBox(height: 10),
            CustomerButton(
              text: 'Save',
              onPress: savePassword,
              isSolid: true,
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder myInputBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Color.fromRGBO(191, 191, 191, 1),
          width: 1,
        ));
  }

  OutlineInputBorder myFocusBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.black12,
          width: 1,
        ));
  }

  Widget buildOldPasswordFormField(
    String title,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 55,
          child: TextFormField(
            onChanged: (newValue) {
              oldPassword = newValue;
            },
            validator: (value) {
              if (value!.isEmpty) {
                if (!errors.contains('Please enter your old password')) {
                  setState(() {
                    errors.add('Please enter your old password');
                  });
                }
              } else {
                if (errors.contains('Please enter your old password')) {
                  setState(() {
                    errors.remove('Please enter your old password');
                  });
                }
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              border: myInputBorder(),
              enabledBorder: myInputBorder(),
              focusedBorder: myFocusBorder(),
              prefixIcon: Icon(
                icon,
                size: 24,
                color: const Color.fromRGBO(78, 78, 78, 1),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildNewPasswordFormField(
    String title,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 55,
          child: TextFormField(
            onChanged: (value) {
              newPassword = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                if (!errors.contains('Please enter your new password')) {
                  setState(() {
                    errors.add('Please enter your new password');
                  });
                }
              } else {
                if (errors.contains('Please enter your new password')) {
                  setState(() {
                    errors.remove('Please enter your new password');
                  });
                }
              }
              if (value.length < 8) {
                if (!errors.contains('Your new password is too short')) {
                  setState(() {
                    errors.add('Your new password is too short');
                  });
                }
              } else {
                if (errors.contains('Your new password is too short')) {
                  setState(() {
                    errors.remove('Your new password is too short');
                  });
                }
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              border: myInputBorder(),
              enabledBorder: myInputBorder(),
              focusedBorder: myFocusBorder(),
              prefixIcon: Icon(
                icon,
                size: 24,
                color: const Color.fromRGBO(78, 78, 78, 1),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildConfirmPasswordFormField(
    String title,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 55,
          child: TextFormField(
            onChanged: (value) {
              confirmPassword = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                if (!errors.contains('Please enter your confirm password')) {
                  setState(() {
                    errors.add('Please enter your confirm password');
                  });
                }
              } else {
                if (errors.contains('Please enter your confirm password')) {
                  setState(() {
                    errors.remove('Please enter your confirm password');
                  });
                }
              }
              if (value != newPassword) {
                if (!errors.contains('The confirm password is incorrect')) {
                  setState(() {
                    errors.add('The confirm password is incorrect');
                  });
                } else {
                  if (errors.contains('The confirm password is incorrect')) {
                    setState(() {
                      errors.remove('The confirm password is incorrect');
                    });
                  }
                }
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              border: myInputBorder(),
              enabledBorder: myInputBorder(),
              focusedBorder: myFocusBorder(),
              prefixIcon: Icon(
                icon,
                size: 24,
                color: const Color.fromRGBO(78, 78, 78, 1),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
