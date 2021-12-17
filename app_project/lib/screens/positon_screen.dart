import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/education.dart';
import 'package:test_fix/providers/position.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/widgets/dismissible_education_item.dart';
import 'package:test_fix/widgets/dismissible_position_item.dart';

import 'add_education_screen.dart';
import 'add_position_screen.dart';

class PositionScreen extends StatefulWidget {
  static const routeName = '/PositionScreen';

  const PositionScreen({Key? key}) : super(key: key);

  @override
  _PositionScreenState createState() => _PositionScreenState();
}

class _PositionScreenState extends State<PositionScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    Future<List<Position>> educations =
    Provider.of<Positions>(context).getListPosition(uid);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Position',
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
              Navigator.of(context).pushNamed(AddPositionScreen.routeName);
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
              List<Position> listPosition = snapshot.data as List<Position>;
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return DismissiblePositionItem(
                    index: index,
                    uid: uid,
                    listPosition: listPosition,
                  );
                },
                itemCount: listPosition.length,
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
