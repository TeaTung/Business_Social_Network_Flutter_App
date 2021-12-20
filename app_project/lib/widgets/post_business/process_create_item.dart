import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_fix/providers/round.dart';

class CreateProcessItem extends StatefulWidget {
  const CreateProcessItem(
      {Key? key, required this.number, this.onSaveRound, required this.formKey})
      : super(key: key);

  final int number;

  // ignore: prefer_typing_uninitialized_variables
  final onSaveRound;

  final GlobalKey<FormState> formKey;

  @override
  _CreateProcessItemState createState() => _CreateProcessItemState();
}

class _CreateProcessItemState extends State<CreateProcessItem> {
  late Round myRound;
  @override
  Widget build(BuildContext context) {
    final _formKey = widget.formKey;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              ' #${widget.number} Title',
              style: GoogleFonts.workSans(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                hintText: ' Title detail',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey.withOpacity(0.6),
                      width: 1.5),
                ),
              ),
              style: GoogleFonts.workSans().copyWith(fontSize: 15),
              onSaved: (title) {
                myRound = Round(
                    deadline: DateTime.now(),
                    description: '',
                    isFinished: false,
                    roundTitle: title as String);
              },
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
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                hintText: 'Description about task',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey.withOpacity(0.6),
                      width: 1.5),
                ),
              ),
              style: GoogleFonts.workSans().copyWith(fontSize: 15),
              onSaved: (desc) {
                myRound = Round(
                  deadline: DateTime.now(),
                  description: desc as String,
                  isFinished: false,
                  roundTitle: myRound.roundTitle,
                );
                widget.onSaveRound(myRound);
              },
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
