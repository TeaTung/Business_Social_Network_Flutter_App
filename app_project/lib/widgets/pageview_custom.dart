import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_fix/widgets/positions_section.dart';

import 'educations_section.dart';

class PageViewCustom extends StatefulWidget {
  const PageViewCustom({Key? key}) : super(key: key);

  @override
  _PageViewCustomState createState() => _PageViewCustomState();
}

class _PageViewCustomState extends State<PageViewCustom> {
  var controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      currentPage = controller.page!.toInt();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          width: 375,
          height: 360,
          child: PageView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: index == 0
                      ? PositionsSection(id: id)
                      : EducationsSection(id: id),
                );
              }),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
