import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:test_fix/providers/post/post_provider.dart';
import 'package:test_fix/screens/post_business/create_process_detail_screen.dart';

class CreateProcessPostScreen extends StatefulWidget {
  const CreateProcessPostScreen(
      {Key? key, required this.businessPostProvider, required this.imageFile})
      : super(key: key);

  final PostProvider businessPostProvider;
  final PickedFile imageFile;
  @override
  State<CreateProcessPostScreen> createState() =>
      _CreateProcessPostScreenState();
}

class _CreateProcessPostScreenState extends State<CreateProcessPostScreen> {
  int _currentValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 145, 71, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Text(
              'Your number of process',
              style: GoogleFonts.workSans(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            NumberPicker(
              textStyle: GoogleFonts.workSans(
                fontSize: 35,
                color: Colors.white,
              ),
              selectedTextStyle: GoogleFonts.workSans(
                fontSize: 25,
                color: Colors.black,
              ),
              value: _currentValue,
              minValue: 1,
              maxValue: 10,
              onChanged: (value) => setState(() => _currentValue = value),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: 10,
                top: 20,
              ),
              margin: const EdgeInsets.only(bottom: 20),
              width: double.infinity,
              height: 100,
              child: TextButton(
                child: Text("NEXT",
                    style: GoogleFonts.workSans().copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProcessDetailScreen(
                              numberOfProcess: _currentValue,
                              postProvider: widget.businessPostProvider,
                              imageFile: widget.imageFile,
                            )),
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
