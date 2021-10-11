import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_fix/providers/mesage.dart';


enum MessageType{ UNREAD, OTHER, SENT}

class DetailMessageItemBelongToMe extends StatefulWidget {

  Message messageData;
  DetailMessageItemBelongToMe(this.messageData);

  @override
  State<DetailMessageItemBelongToMe> createState() => _DetailMessageItemBelongToMeState();
}

class _DetailMessageItemBelongToMeState extends State<DetailMessageItemBelongToMe> {
  final imageStr =
      "https://images.pexels.com/photos/6194912/pexels-photo-6194912.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Container(
          width: constraints.maxWidth * 0.8,
          margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.pinkAccent.withOpacity(0.6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2),
              bottomLeft: Radius.circular(2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(imageStr),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: GoogleFonts.ubuntuMono().copyWith(
                            color: Colors.white.withOpacity(0.8), fontSize: 15),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
