import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/providers/mesage.dart';
import 'package:test_fix/providers/messages.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/widgets/detail_message_item_belong_to_me.dart';
import 'package:test_fix/widgets/overview_message_item.dart';

class OverviewMessageScreen extends StatelessWidget {
  const OverviewMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userMe = Provider.of<UserInfoLocal>(context);
    var messagesTotal = Provider.of<Messages>(context).messages.toList();

    var listOther = messagesTotal
        .where((element) =>
            (element.hasBeenRead == true && element.factorId == userMe.uid))
        .toList();

    final listSent = messagesTotal
        .where((element) =>
            (element.hasBeenRead == true && element.uid == userMe.uid))
        .toList();

    final listUnread = messagesTotal.where((element) =>
        (element.hasBeenRead == false && element.uid != userMe.uid)).toList();

    listOther.removeWhere((element) {
      bool f = false;
      listSent.forEach((sentElement) {
        if (element.uid == sentElement.factorId) {
          f = true;
          return;
        }
      });
      return f;
    });

    // SORT LIST
    listOther.sort((m1, m2) => m2.sentTime.compareTo(m1.sentTime));
    listSent.sort((m1, m2) => m2.sentTime.compareTo(m1.sentTime));
    listUnread.sort((m1, m2) => m2.sentTime.compareTo(m1.sentTime));


    var groupMessageSent = groupBy(
      listSent,
      (Message e) {
        return e.factorId;
      },
    );

    var groupMessageOther = groupBy(
      listOther,
      (Message e) {
        return e.uid;
      },
    );

    var groupMessageUnread = groupBy(
      listUnread,
      (Message e) {
        return e.uid;
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                padding: const EdgeInsets.only(left: 40, top: 50),
                width: double.infinity,
                color: const Color.fromRGBO(255, 235, 212, 1),
                height: constraints.maxHeight * 0.27,
                child: Column(
                  children: [
                    Text(
                      "Your",
                      style: GoogleFonts.workSans().copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "Messages",
                      style: GoogleFonts.workSans().copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "You have  unreads message",
                        style: GoogleFonts.workSans().copyWith(
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, top: 30),
                padding: const EdgeInsets.only(left: 30, top: 20, bottom: 10),
                width: double.infinity,
                color: const Color.fromRGBO(255, 180, 171, 1),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Unread(${groupMessageUnread.length})",
                          style: GoogleFonts.ubuntuMono().copyWith(
                            fontSize: 18,
                            color: const Color.fromRGBO(28, 12, 91, 1),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "Mark as read",
                            style: GoogleFonts.ubuntuMono().copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      // <-- this will disable scroll
                      shrinkWrap: true,
                      itemBuilder: (context, index) => OverViewMessageItem(
                        (groupMessageUnread[
                                groupMessageUnread.keys.elementAt(index)]!
                            .toList()[0]),
                        MessageType.UNREAD,
                      ),
                      itemCount: groupMessageUnread.length,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sent(${groupMessageSent.length})",
                          style: GoogleFonts.ubuntuMono().copyWith(
                            fontSize: 18,
                            color: const Color.fromRGBO(28, 12, 91, 1),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "See all",
                            style: GoogleFonts.ubuntuMono().copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // LIST OF SENT MESS
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OverViewMessageItem(
                          (groupMessageSent[
                                  groupMessageSent.keys.elementAt(index)]!
                              .toList()[0]),
                          MessageType.SENT,
                        );
                      },
                      itemCount: groupMessageSent.length,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Other(${(groupMessageOther.length >= 1) ? groupMessageOther[groupMessageOther.keys.elementAt(0)]!.toList().length : 0})",
                          style: GoogleFonts.ubuntuMono().copyWith(
                            fontSize: 18,
                            color: const Color.fromRGBO(28, 12, 91, 1),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "See all",
                            style: GoogleFonts.ubuntuMono().copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ],
                    ),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OverViewMessageItem(
                          (groupMessageOther[
                                  groupMessageOther.keys.elementAt(index)]!
                              .toList()[0]),
                          MessageType.OTHER,
                        );
                      },
                      itemCount: groupMessageOther.length,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
