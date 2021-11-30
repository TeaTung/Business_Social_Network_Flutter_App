import 'package:flutter/material.dart';

class JobDescriptionInProcessDetailItem extends StatelessWidget {
  final String jobDescription;

  const JobDescriptionInProcessDetailItem({
    Key? key,
    required this.jobDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Job Description",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(248, 145, 71, 1),
          ),
        ),
        const SizedBox(height: 11),
        SizedBox(
          width: double.infinity,
          child: Text(
            jobDescription,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(100, 100, 100, 1.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
