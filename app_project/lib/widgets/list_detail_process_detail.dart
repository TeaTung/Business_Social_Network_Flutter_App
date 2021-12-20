import 'package:flutter/material.dart';

import '../providers/process.dart';

class ListDetailProcessDetailItem extends StatelessWidget {
  final ProcessProvider process;

  const ListDetailProcessDetailItem({Key? key, required this.process})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 2),
        Text(
          process.companyName,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(100, 100, 100, 1.0),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 11),
        Text(
          process.position,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(100, 100, 100, 1.0),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 11),
      ],
    );
  }
}
