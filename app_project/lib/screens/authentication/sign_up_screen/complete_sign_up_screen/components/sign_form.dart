import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:test_fix/helpers/auth_services.dart';
import 'form_error.dart';
import 'orange_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String name = '';
  DateTime? birthday = DateTime.now();
  String nationality = 'Vietnam';
  String email = '';
  String password = '';
  String sex = '';
  bool isBusiness = false;
  late FocusNode birthdayFocusNode;

  void _onFocusChange() {
    if (!birthdayFocusNode.hasFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime(2018, 3, 5),
          maxTime: DateTime(2021, 6, 7), onChanged: (date) {
        print('change $date');
      }, onConfirm: (date) {
        print('confirm $date');
      }, currentTime: DateTime.now(), locale: LocaleType.zh);
    }
  }

  @override
  void initState() {
    super.initState();

    birthdayFocusNode = FocusNode();
    birthdayFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    birthdayFocusNode.dispose();
    birthdayFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  TextEditingController birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authInformation = ModalRoute.of(context)!.settings.arguments as Map;
    email = authInformation['email'];
    password = authInformation['password'];
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          const SizedBox(height: 36),
          buildNationalFormField(),
          const SizedBox(height: 36),
          buildBirthdayFormField(),
          const SizedBox(height: 8),
          FormError(errors: errors),
          GenderPickerWithImage(
            showOtherGender: true,
            verticalAlignedText: true,
            onChanged: (Gender? gender) {
              if (gender == Gender.Male) {
                sex = 'male';
              } else if (gender == Gender.Female) {
                sex = 'female';
              } else {
                sex = 'other';
              }
            },
            equallyAligned: true,
            animationDuration: const Duration(milliseconds: 300),
            unSelectedGenderTextStyle: const TextStyle(
              color: Color.fromRGBO(98, 98, 98, 1),
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            selectedGenderTextStyle: const TextStyle(
              color: Color.fromRGBO(248, 145, 71, 1),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            size: 60,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isBusiness,
                activeColor: const Color.fromRGBO(248, 145, 71, 1),
                onChanged: (value) {
                  setState(() {
                    isBusiness = value!;
                  });
                },
              ),
              const Text('Business Account'),
            ],
          ),
          const SizedBox(height: 18),
          OrangeButton(
            text: 'Sign Up',
            onPress: () {
              _formKey.currentState!.validate();
              if (errors.isEmpty) {
                _formKey.currentState!.save();
                context
                    .read<AuthService>()
                    .signUpWithEmailAndPassword(email, password)
                    .then((value) async {
                  User user = FirebaseAuth.instance.currentUser!;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .set({
                    'uid': user.uid,
                    'email': user.email,
                    'name': name,
                    'birthday': birthday,
                    'gender': sex,
                    'id': user.uid,
                    'quote': '',
                    'nationality': nationality,
                    'coverPhotoUrl': '',
                    'avatarUrl': '',
                    'isBusinessAccount': isBusiness,
                  });
                  Navigator.pushNamed(context, '/auth_wrapper');
                });
              }
            },
            isSolid: true,
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    final validCharacters = RegExp(r'^[a-zA-Z]+$');
    return TextFormField(
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        name = value;
        if (validCharacters.hasMatch(value) &&
            errors.contains('Invalid characters in your name')) {
          setState(() {
            errors.remove('Invalid characters in your name');
          });
        }
        return null;
      },
      validator: (value) {
        if (validCharacters.hasMatch(value!)) {
          setState(() {
            errors.add('Invalid characters in your name');
          });
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your name',
        labelText: 'Name',
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 22, 0),
          child: SvgPicture.asset(
            'assets/icons/User.svg',
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

  TextFormField buildNationalFormField() {
    final validCharacters = RegExp(r'^[a-zA-Z]+$');
    return TextFormField(
      onSaved: (newValue) => nationality = newValue!,
      onChanged: (value) {
        nationality = value;
        if (validCharacters.hasMatch(value) &&
            errors.contains('Invalid characters in your nationality')) {
          setState(() {
            errors.remove('Invalid characters in your nationality');
          });
        }
        return null;
      },
      validator: (value) {
        if (!validCharacters.hasMatch(value!)) {
          setState(() {
            errors.add('Invalid characters in your nationality');
          });
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your nationality',
        labelText: 'Nationality',
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 22, 0),
          child: SvgPicture.asset(
            'assets/icons/nationality.svg',
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

  TextFormField buildBirthdayFormField() {
    return TextFormField(
      //focusNode: birthdayFocusNode,
      //onSaved: (newValue) => birthday = newValue!,
      controller: birthdayController,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains('Please enter your birthday')) {
          setState(() {
            errors.remove('Please enter your birthday');
          });
        }
        return null;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            errors.add('Please enter your birthday');
          });
        }
        return null;
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        birthday = await DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(1900, 1, 1),
          maxTime: DateTime.now(),
          locale: LocaleType.en,
        );
        if (birthday != null) {
          birthdayController.text = DateFormat('yyyy-MM-dd').format(birthday!);
        }
      },
      decoration: InputDecoration(
        hintText: 'Enter your birthday',
        labelText: 'Birthday',
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 22, 0),
          child: SvgPicture.asset(
            'assets/icons/Gift Icon.svg',
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
