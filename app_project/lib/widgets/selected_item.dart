import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/widgets/pageview_custom.dart';

import 'avatar_coverphot_selected_item.dart';
import 'list_detail_information_in_selected_item.dart';

class SelectedItem extends StatefulWidget {
  final Account account;

  const SelectedItem({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  @override
  Widget build(BuildContext context) {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.account.userName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromRGBO(248, 145, 71, 1),
            fontFamily: 'Helvetica',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(248, 145, 71, 1),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          IconButton(
              icon:  Icon(
                widget.account.uidFollowers.contains(myId)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: const Color.fromRGBO(248, 145, 71, 1),
              ),
              onPressed: () {
                setState(() {
                  if (!widget.account.uidFollowers.contains(myId)) {
                    widget.account.addUidFollowers(myId, widget.account.uid);
                  } else {
                    widget.account.removeUidFollowers(myId, widget.account.uid);
                  }
                });
              }),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            AvatarCoverPhotoSelectedItem(account: widget.account),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7,
              ),
              child: ListDetailInformationInSelectedItem(account: widget.account,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PageViewCustom(id: widget.account.id),
            ),
          ],
        ),
      ),
    );
  }
}
