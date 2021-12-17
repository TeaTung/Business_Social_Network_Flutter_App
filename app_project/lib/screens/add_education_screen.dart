import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/widgets/customer_button.dart';

import 'authentication/forgot_password_screen/components/form_error.dart';

class AddEducationScreen extends StatefulWidget {
  static const routeName = '/AddEducationScreen';

  const AddEducationScreen({Key? key}) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  var newTitle = '';
  var newOrganization = '';
  var newIssueYear = DateTime.now();
  late FocusNode issueYearFocusNode;
  TextEditingController issueYearController = TextEditingController();

  void _onFocusChange() {
    if (!issueYearFocusNode.hasFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime(2000, 3, 5),
          maxTime: DateTime.now(),
          onChanged: (date) {},
          onConfirm: (date) {},
          currentTime: DateTime.now(),
          locale: LocaleType.zh);
    }
  }

  @override
  void initState() {
    super.initState();

    issueYearFocusNode = FocusNode();
    issueYearFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    issueYearFocusNode.dispose();
    issueYearFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    void createEducation() {
      if (newTitle.isEmpty && !errors.contains("Please insert title !")) {
        setState(() {
          errors.add("Please insert title !");
        });
      } else if (newTitle.isNotEmpty) {
        setState(() {
          errors.remove("Please insert title !");
        });
      }

      if (newOrganization.isEmpty &&
          !errors.contains("Please insert organization !")) {
        setState(() {
          errors.add("Please insert organization !");
        });
      } else if (newOrganization.isNotEmpty) {
        setState(() {
          errors.remove("Please insert organization !");
        });
      }
      _formKey.currentState!.validate();
      if (errors.isEmpty) {
        _formKey.currentState!.save();
        Provider.of<Educations>(context, listen: false).addEducation(
          newTitle,
          newOrganization,
          newIssueYear,
          uid,
        );
        Navigator.of(context).pop();
        setState(() {});
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Add Education',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(248, 145, 71, 1),
            fontFamily: 'Helvetica',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(248, 145, 71, 1),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                customTextFormField(
                  'Title',
                  Icons.title,
                  1,
                ),
                customTextFormField(
                  'Organization',
                  Icons.business,
                  2,
                ),
                customChoosingDate(),
                FormError(errors: errors),
                const SizedBox(height: 10),
                CustomerButton(
                  text: 'Save',
                  onPress: createEducation,
                  isSolid: true,
                ),
              ],
            ),
          ),
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
      ),
    );
  }

  OutlineInputBorder myFocusBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.black12,
        width: 1,
      ),
    );
  }

  Widget customTextFormField(
    String title,
    IconData icon,
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
                newTitle = value.toString();
                if (validCharacters.hasMatch(newTitle) &&
                    errors.contains('Invalid characters in your title')) {
                  setState(() {
                    errors.remove('Invalid characters in your title');
                  });
                }
              } else if (flash == 2) {
                newOrganization = value.toString();
                if (validCharacters.hasMatch(newOrganization) &&
                    errors
                        .contains('Invalid characters in your organization')) {
                  setState(() {
                    errors.remove('Invalid characters in your organization');
                  });
                }
              }
              return;
            },
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
            textCapitalization: TextCapitalization.sentences,
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
        controller: issueYearController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          newIssueYear = (await DatePicker.showDatePicker(
            context,
            currentTime: DateTime.now(),
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            maxTime: DateTime.now(),
            locale: LocaleType.en,
          ))!;
          issueYearController.text =
              DateFormat('dd MMM yyyy').format(newIssueYear);
        },
        decoration: InputDecoration(
          hintText: DateFormat('dd MMM yyyy').format(DateTime.now()),
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromRGBO(191, 191, 191, 1),
            ),
          ),
          prefixIcon: const Icon(
            Icons.timer,
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
          ' Issues Year',
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
}
