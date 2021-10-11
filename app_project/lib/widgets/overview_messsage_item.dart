import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/mesage.dart';
import 'package:test_fix/providers/messages.dart';
import 'package:test_fix/widgets/detail_message_item_belong_to_me.dart';

class OverViewMessageItem extends StatelessWidget {
  final imageStr =
      "https://images.pexels.com/photos/6194912/pexels-photo-6194912.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

  static final routeName = "/Message";

  Message messageData;

  MessageType messageType;

  OverViewMessageItem(this.messageData, this.messageType);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (messageType == MessageType.UNREAD) {
          Provider.of<Messages>(context, listen: false)
              .messages
              .where((element) =>
                  element.uid == messageData.uid &&
                  element.hasBeenRead == false)
              .forEach((element) {
            element.hasBeenRead = true;
          });
        }
        if (messageType == MessageType.UNREAD ||
            messageType == MessageType.OTHER) {
          Navigator.of(context)
              .pushNamed(OverViewMessageItem.routeName, arguments: messageData.uid);
        }
        if (messageType == MessageType.SENT) {
          Navigator.of(context).pushNamed(OverViewMessageItem.routeName,
              arguments: messageData.factorId);
        }
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: EdgeInsets.only(left: 50, bottom: 10, top: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              color: Colors.white.withOpacity(0.8),
            ),
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        (messageType == MessageType.SENT)
                            ? "ME: ${messageData.content}"
                            : messageData.content,
                        style: GoogleFonts.workSans(),
                      ),
                      margin: EdgeInsets.only(bottom: 4),
                      width: 250,
                    ),
                    Text(
                      (messageType == MessageType.SENT)
                          ? messageData.factorId
                          : messageData.uid,
                      style: GoogleFonts.workSans().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromRGBO(231, 0, 0, 0.5),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 12,
                  bottom: 0,
                  child: Text(
                    DateFormat.yMMMEd().format(
                      messageData.sentTime,
                    ),
                    style: GoogleFonts.workSans()
                        .copyWith(color: Colors.black.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 2,
            bottom: 8,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                imageStr,
              ),
            ),
          )
        ],
      ),
    );
  }
}
