import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/providers/messages.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/widgets/detail_messagee_item_not_belong_to_me.dart';
import 'package:test_fix/widgets/detail_message_item_belong_to_me.dart';

class DetailMessageScreen extends StatelessWidget {
  final imageStr =
      "https://images.pexels.com/photos/963436/pexels-photo-963436.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260";

  final _controller = ScrollController();
  final _textInputControler = TextEditingController();

  void sendMessage(Messages messages, UserInfoLocal userMe, String userImTextingToId) {
    messages.sendMessage(
      _textInputControler.value.text,
      userMe.uid,
      userImTextingToId,
      DateTime.now(),
    );
    _textInputControler.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userImTextingToId =
        ModalRoute.of(context)!.settings.arguments as String;
    final userMe = Provider.of<UserInfoLocal>(context);

    //get message depend in id
    final messageOver = Provider.of<Messages>(context);
    final userImTextingToMessages =
        Provider.of<Messages>(context).messages.where((element) {
      return ((element.factorId == userMe.uid &&
          element.uid == userImTextingToId));
    }).toList();

    final myMessages = Provider.of<Messages>(context).messages.where((element) {
      return element.factorId == userImTextingToId;
    }).toList();

    var messageList = (userImTextingToMessages + myMessages);
    messageList.sort((l1, l2) {
      return l1.sentTime.compareTo(l2.sentTime);
    });

    //scroll to the bottom
    Timer(
      Duration(milliseconds: 600),
      () => _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(
          "${userImTextingToId}",
          style: GoogleFonts.workSans().copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageStr),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: ListView.builder(
                      controller: _controller,
                      itemBuilder: (context, index) {
                        if (messageList[index].uid == userMe.uid)
                          return DetailMessageItemBelongToMe(
                              messageList[index]);
                        return DetailMessageItemNotBelongToMe(
                            messageList[index]);
                      },
                      itemCount: messageList.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Theme(
                      data: ThemeData(
                        primarySwatch: Colors.pink,
                      ),
                      child: TextField(
                        controller: _textInputControler,
                        maxLines: null,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Send your message",
                          hintStyle: GoogleFonts.workSans(),
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          suffix: IconButton(
                            padding: EdgeInsets.all(0),
                            icon: const Icon(
                              MdiIcons.mail,
                              color: Colors.pink,
                              size: 30,
                            ),
                            onPressed: () {
                              sendMessage(
                                  messageOver, userMe, userImTextingToId);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
