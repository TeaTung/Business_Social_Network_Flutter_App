import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/account.dart';
import '../providers/user_info.dart';

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
    final _formKey = GlobalKey<FormState>();

    late String name;
    late String nationality;
    late String quote;
    late String gender;
    late DateTime birthDate;

    String checkText = '';

    OutlineInputBorder myInputBorder() {
      return const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: Color.fromRGBO(248, 145, 71, 1),
            width: 1.5,
          ));
    }

    OutlineInputBorder myFocusBorder() {
      return const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: Colors.black12,
            width: 1.5,
          ));
    }

    Widget nameTF () {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle: const  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          border: myInputBorder(),
          enabledBorder: myInputBorder(),
          focusedBorder: myFocusBorder(),
          prefixIcon:const  Icon(Icons.person_outline_outlined,size: 30,),
        ),
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          name = value;
          print(name);
        },
      );

    }

    Widget nationalityTF () {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Nationality',
          labelStyle: const  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          border: myInputBorder(),
          enabledBorder: myInputBorder(),
          focusedBorder: myFocusBorder(),
          prefixIcon:const  Icon(Icons.person_outline_outlined,size: 30,),
        ),
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          name = value;
          print(name);
        },
      );

    }

    Widget quoteTF () {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Quote',
          labelStyle: const  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          border: myInputBorder(),
          enabledBorder: myInputBorder(),
          focusedBorder: myFocusBorder(),
          prefixIcon:const  Icon(EvaIcons.pin,size: 30,),
        ),
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) {
          name = value;
          print(name);
        },
      );

    }


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(248, 145, 71, 1),
          title: Text(
            'Change information',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                // if (userName.isNotEmpty && nationality.isNotEmpty) {
                //   user.setUserName(userName);
                //   account.setNationality(nationality);
                //   account.setQuote(quote);
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('Save Successfully !')));
                //   Navigator.of(context).pop();
                //   return;
                // }
                print(checkText);
              },
              icon: const Icon(
                Icons.save_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column (
              children: [
                nameTF(),
                const SizedBox(height: 15),
                nationalityTF(),
                const SizedBox(height: 15),
                quoteTF(),
                const SizedBox(height: 15),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
