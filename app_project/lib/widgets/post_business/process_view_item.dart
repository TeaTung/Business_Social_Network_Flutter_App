import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_fix/providers/round.dart';

class ProcessViewItem extends StatelessWidget {
  const ProcessViewItem(
      {Key? key,
      //  required this.number,
      required this.title,
      required this.description})
      : super(key: key);

  //final int number;
  final String title;

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              'Title',
              style: GoogleFonts.workSans(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: GoogleFonts.workSans().copyWith(fontSize: 15),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Description',
              style: GoogleFonts.workSans(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              description,
              style: GoogleFonts.workSans().copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
