import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/account.dart';
import '../providers/user.dart';

class ChangeInformation extends StatefulWidget {
  static const routeName = '/ChangeInformation';

  const ChangeInformation({Key? key}) : super(key: key);

  @override
  State<ChangeInformation> createState() => _ChangeInformationState();
}

enum Gender { male, female }

class _ChangeInformationState extends State<ChangeInformation> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final user = Provider.of<User>(context);


    Gender? _gender;
    var userName = user.getUserName;
    var nationality = account.getNationality;
    var quote = account.getQuote;
    DateTime birthDate = account.getBirthDate;

    if (account.getGender == 'Male') {
      _gender = Gender.male;
    } else {
      _gender = Gender.female;
    }
    final _userNameController = TextEditingController();
    _userNameController.text = userName;
    final _nationalityController = TextEditingController();
    _nationalityController.text = nationality;
    final _quoteController = TextEditingController();
    _quoteController.text = quote;
    _pickedDate() async {
      DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        initialDate: birthDate,
      );
      if (date != null) {
        setState(() {
          birthDate = date;
        });
      }
      account.setBirthDate(birthDate);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Change information',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: PreferredSize(
            child: Container(
              color: Colors.grey,
              height: 0.6,
            ),
            preferredSize: const Size.fromHeight(3),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (userName.isNotEmpty && nationality.isNotEmpty) {
                  user.setUserName(userName);
                  account.setNationality(nationality);
                  account.setQuote(quote);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Save Successfully !')));
                  Navigator.of(context).pop();
                  return;
                }
              },
              icon: const Icon(
                Icons.save_rounded,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _userNameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  userName = value;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nationalityController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nationality',
                ),
                onChanged: (value) {
                  nationality = value;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _quoteController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Quote',
                  // border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  quote = value;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Birth Date:  ',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    '${birthDate.day}/${birthDate.month}/${birthDate.year}',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(128, 128, 128, 1),
                        ),
                  ),
                  IconButton(
                    onPressed: _pickedDate,
                    icon: const Icon(Icons.drive_file_rename_outline),
                  ),
                ],
              ),
              const Divider(
                thickness: 0.7,
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
              Row(
                children: [
                  Text(
                    'Gender:  ',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Radio<Gender>(
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        account.setGender('Male');
                      });
                    },
                  ),
                  Text(
                    'Male',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(128, 128, 128, 1),
                        ),
                  ),
                  Radio<Gender>(
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        account.setGender('Female');
                      });
                    },
                  ),
                  Text(
                    'Female',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(128, 128, 128, 1),
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
