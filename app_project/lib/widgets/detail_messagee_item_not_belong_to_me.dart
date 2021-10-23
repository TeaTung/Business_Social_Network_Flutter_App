import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_fix/providers/mesage.dart';

class DetailMessageItemNotBelongToMe extends StatefulWidget {
  Message messageData;


  DetailMessageItemNotBelongToMe(this.messageData);

  @override
  State<DetailMessageItemNotBelongToMe> createState() =>
      _DetailMessageItemNotBelongToMeState();

}

class _DetailMessageItemNotBelongToMeState
    extends State<DetailMessageItemNotBelongToMe> {
  final imageStr =
      "https://images.pexels.com/photos/6194912/pexels-photo-6194912.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: constraints.maxWidth * 0.8,
            margin: const EdgeInsets.only(top: 20, left: 0, bottom: 20),
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.messageData.uid,
                        style: GoogleFonts.ubuntuMono().copyWith(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        width: constraints.maxWidth * 0.6,
                        child: Text(
                          widget.messageData.content,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.ubuntuMono().copyWith(
                            color: Colors.pink.withOpacity(0.8),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(imageStr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
