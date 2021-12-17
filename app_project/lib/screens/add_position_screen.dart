import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/widgets/customer_button.dart';

import 'authentication/forgot_password_screen/components/form_error.dart';

class AddPositionScreen extends StatefulWidget {
  static const routeName = '/AddPositionScreen';

  const AddPositionScreen({Key? key}) : super(key: key);

  @override
  _AddPositionScreenState createState() => _AddPositionScreenState();
}

class _AddPositionScreenState extends State<AddPositionScreen> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  var newCompany = '';
  var newJobTitle = '';
  var newStartDate = DateTime.now();
  var newEndDate = DateTime.now();
  late FocusNode startDateFocusNode;
  late FocusNode endDateFocusNode;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  void _onFocusChange() {
    if (!startDateFocusNode.hasFocus) {
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
    if (!endDateFocusNode.hasFocus) {
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

    startDateFocusNode = FocusNode();
    startDateFocusNode.addListener(_onFocusChange);
    endDateFocusNode = FocusNode();
    endDateFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    startDateFocusNode.dispose();
    startDateFocusNode.removeListener(_onFocusChange);
    endDateFocusNode.dispose();
    endDateFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    void createPosition() {
      if (newCompany.isEmpty && !errors.contains("Please insert title !")) {
        setState(() {
          errors.add("Please insert title !");
        });
      } else if (newCompany.isNotEmpty) {
        setState(() {
          errors.remove("Please insert title !");
        });
      }

      if (newJobTitle.isEmpty &&
          !errors.contains("Please insert organization !")) {
        setState(() {
          errors.add("Please insert organization !");
        });
      } else if (newJobTitle.isNotEmpty) {
        setState(() {
          errors.remove("Please insert organization !");
        });
      }

      if (newEndDate.difference(newStartDate).inDays == 0 &&
          !errors.contains("Start date and end date can't share same day !")) {
        setState(() {
          errors.add("Start date and end date can't share same day !");
        });
      } else if (newEndDate.difference(newStartDate).inDays != 0) {
        setState(() {
          errors.remove("Start date and end date can't share same day !");
        });
      }

      if (newEndDate.difference(newStartDate).inDays < 0 &&
          !errors.contains("Start date must be earlier than end date !")) {
        setState(() {
          errors.add("Start date must be earlier than end date !");
        });
      } else if (newEndDate.difference(newStartDate).inDays >= 0) {
        setState(() {
          errors.remove("Start date must be earlier than end date !");
        });
      }

      _formKey.currentState!.validate();
      if (errors.isEmpty) {
        _formKey.currentState!.save();
        Provider.of<Positions>(context, listen: false).addPosition(
          newCompany,
          newJobTitle,
          newStartDate,
          newEndDate,
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
          'Add Position',
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
                  'Company',
                  Icons.title,
                  1,
                ),
                customTextFormField(
                  'Job Title',
                  Icons.business,
                  2,
                ),
                customStartDate(),
                customEndDate(),
                FormError(errors: errors),
                const SizedBox(height: 10),
                CustomerButton(
                  text: 'Save',
                  onPress: createPosition,
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
                newCompany = value.toString();
                if (validCharacters.hasMatch(newCompany) &&
                    errors.contains('Invalid characters in company name')) {
                  setState(() {
                    errors.remove('Invalid characters in company name');
                  });
                }
              } else if (flash == 2) {
                newJobTitle = value.toString();
                if (validCharacters.hasMatch(newJobTitle) &&
                    errors.contains('Invalid characters in job title')) {
                  setState(() {
                    errors.remove('Invalid characters in job title');
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

  Widget startDatePicker() {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: startDateController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          newStartDate = (await DatePicker.showDatePicker(
            context,
            currentTime: DateTime.now(),
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            maxTime: DateTime.now(),
            locale: LocaleType.en,
          ))!;
          startDateController.text = DateFormat('dd MMM yyyy').format(newStartDate);
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
            Icons.calendar_today_outlined,
            size: 24,
            color: Color.fromRGBO(78, 78, 78, 1),
          ),
        ),
      ),
    );
  }
  Widget endDatePicker() {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: endDateController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          newEndDate = (await DatePicker.showDatePicker(
            context,
            currentTime: DateTime.now(),
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            maxTime: DateTime.now(),
            locale: LocaleType.en,
          ))!;
          endDateController.text = DateFormat('dd MMM yyyy').format(newEndDate);
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
            Icons.calendar_view_day_outlined,
            size: 24,
            color: Color.fromRGBO(78, 78, 78, 1),
          ),
        ),
      ),
    );
  }

  Widget customStartDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Start day',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        startDatePicker(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget customEndDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'End Day',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        endDatePicker(),
        const SizedBox(height: 20),
      ],
    );
  }
}
