import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/screens/authentication/forgot_password_screen/components/form_error.dart';

import '../providers/account.dart';
import 'customer_button.dart';

class ChangeInformation extends StatefulWidget {
  const ChangeInformation({Key? key}) : super(key: key);

  @override
  State<ChangeInformation> createState() => _ChangeInformationState();
}

enum Gender { male, female }

class _ChangeInformationState extends State<ChangeInformation> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  var newName = '';
  var newQuote = '';
  var newNationality = '';
  var newGender = '';
  var newBirthDate = DateTime.now();
  late FocusNode birthdayFocusNode;

  Gender? gender;

  void _onFocusChange() {
    if (!birthdayFocusNode.hasFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime(1900, 3, 5),
          maxTime: DateTime.now(), onChanged: (date) {
      }, onConfirm: (date) {
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
    final Account account = Provider.of<Account>(context);
    final id = FirebaseAuth.instance.currentUser!.uid;

    void saveInformation() {
      _formKey.currentState!.validate();
      if (errors.isEmpty) {
        _formKey.currentState!.save();
        if (newName.isEmpty) {
          newName = account.userName;
        }
        if (newQuote.isEmpty) {
          newQuote = account.quote;
        }
        if (newNationality.isEmpty) {
          newNationality = account.nationality;
        }
        if (newGender.isEmpty) {
          newGender = account.gender;
        }
        if (newBirthDate == DateTime.now()) {
          newBirthDate = account.birthDate;
        }
        account.fetchAndSetBasicInformation(
          newName, newNationality, newQuote,
          newGender, newBirthDate, id,);

        Navigator.of(context).pop();
      }
    }

    //This is secret UI which nobody want to know so please don't open it
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

    Widget customTextFormField(
      String title,
      IconData icon,
      TextCapitalization textCapitalization,
      String initValue,
      int flash,
    ) {
      final validCharacters = RegExp(r'^[a-zA-Z]+$');
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
                if (flash == 1) {
                  newName = value.toString();
                  if (validCharacters.hasMatch(newName) &&
                      errors.contains('Invalid characters in your name')) {
                    setState(() {
                      errors.remove('Invalid characters in your name');
                    });
                  }
                } else if (flash == 2){
                  newNationality = value.toString();
                  if (validCharacters.hasMatch(newNationality) &&
                      errors.contains('Invalid characters in your newNationality')) {
                    setState(() {
                      errors.remove('Invalid characters in your newNationality');
                    });
                  }
                } else if (flash == 3){
                  newQuote = value.toString();
                  if (validCharacters.hasMatch(newQuote) &&
                      errors.contains('Invalid characters in your quote')) {
                    setState(() {
                      errors.remove('Invalid characters in your quote');
                    });
                  }
                }
                return;
              },
              validator: (value) {
                if (validCharacters.hasMatch(value!)) {
                  setState(() {
                    errors.add('Invalid characters');
                  });
                }
                return null;
              },
              initialValue: initValue,
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
              textCapitalization: textCapitalization,
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }

    Widget datePicker() {
      return SizedBox(
        height: 55,
        child: TextFormField(
          controller: birthdayController,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          onSaved: (value) {
            if (value!.isNotEmpty &&
                errors.contains('Please enter your birthday')) {
              setState(() {
                errors.remove('Please enter your birthday');
              });
            }
            return;
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

            newBirthDate = (await DatePicker.showDatePicker(
              context,
              currentTime: account.birthDate,
              showTitleActions: true,
              minTime: DateTime(1900, 1, 1),
              maxTime: account.birthDate,
              locale: LocaleType.en,
            ))!;

            birthdayController.text =
                DateFormat('dd MMM yyyy').format(newBirthDate);
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromRGBO(191, 191, 191, 1),
              ),
            ),
            hintText: DateFormat('yyyy-MM-dd').format(account.birthDate),
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            prefixIcon: const Icon(
              Icons.card_giftcard_outlined,
              size: 24,
              color: Color.fromRGBO(78, 78, 78, 1),
            ),
          ),
        ),
      );
    }

    Widget customChoosingDate() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' BirthDate',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          datePicker(),
          const SizedBox(height: 20),
        ],
      );
    }

    Widget radio(Gender sex, String title) {
      gender ??= Provider.of<Account>(context).gender == 'Male'
            ? Gender.male
            : Gender.female;
      return Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: const Color.fromRGBO(191, 191, 191, 1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Radio<Gender>(
              focusColor: const Color.fromRGBO(248, 145, 71, 1),
              activeColor: const Color.fromRGBO(248, 145, 71, 1),
              value: sex,
              groupValue: gender,
              onChanged: (Gender? myNewGender) {
                setState(() {
                  gender = myNewGender!;
                  if (myNewGender == Gender.male) {
                    newGender = 'Male';
                    print(newGender);
                  } else {
                    newGender = 'Female';
                    print(newGender);
                  }
                });
              },
            ),
          ],
        ),
      );
    }

    Widget genderChosenItem() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' Gender',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              radio(Gender.male, 'Male'),
              const Spacer(),
              radio(Gender.female, 'Female'),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            customTextFormField(
              'Name',
              Icons.person_outline,
              TextCapitalization.words,
              account.userName,
              1,
            ),
            customTextFormField(
              'Nationality',
              Icons.location_on_outlined,
              TextCapitalization.sentences,
              account.nationality,
              2,
            ),
            customTextFormField(
              'Quote',
              Icons.message_outlined,
              TextCapitalization.sentences,
              account.quote,
              3,
            ),
            customChoosingDate(),
            genderChosenItem(),
            FormError(errors: errors),
            const SizedBox(height: 10),
            CustomerButton(
              text: 'Save',
              onPress: saveInformation,
              isSolid: true,
            ),
          ],
        ),
      ),
    );
  }
}
