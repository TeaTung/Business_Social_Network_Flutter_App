import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/education.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/widgets/dismissible_education_item.dart';
import 'package:test_fix/widgets/education_item.dart';

import 'add_education_screen.dart';

class EducationScreen extends StatefulWidget {
  static const routeName = '/EducationScreen';

  const EducationScreen({Key? key}) : super(key: key);

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    Future<List<Education>> educations =
        Provider.of<Educations>(context).getListEducation(uid);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Education',
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Color.fromRGBO(248, 145, 71, 1),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEducationScreen.routeName);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        physics: const ScrollPhysics(),
        child: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<Education> listEducation = snapshot.data as List<Education>;
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return DismissibleEducationItem(
                    index: index,
                    uid: uid,
                    listEducation: listEducation,
                  );
                },
                itemCount: listEducation.length,
                separatorBuilder: (context, _) {
                  return const SizedBox(height: 5);
                },
              );
            } else {
              return const Center(child: Text("Error"));
            }
          },
          future: educations,
        ),
      ),
    );
  }
}
