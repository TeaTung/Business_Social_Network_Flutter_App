import 'package:flutter/material.dart';

class ListTitleProcessDetailItem extends StatelessWidget {
  const ListTitleProcessDetailItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Company",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(248, 145, 71, 1),
          ),
        ),
        SizedBox(height: 11),
        Text(
          "Postion",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(248, 145, 71, 1),
          ),
        ),
        SizedBox(height: 11),
      ],
    );
  }
}
