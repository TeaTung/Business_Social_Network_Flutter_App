/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_fix/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Notification",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Helvetica',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 0.6,
          ),
          preferredSize: const Size.fromHeight(3),
        ),
      ),
      /*Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('noti')
            .where("uid", isNotEqualTo: MyUser.me.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return snapshot.data!.docs.length > 0
              ? */
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10, left: 10),
            height: 25,
            child: const Text(
              'TODAY',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => NotificationItem(
                  factorId: "???",
                  //snapshot.data!.docs[index]['factorId'],
                  username: "???" //snapshot.data!.docs[index]['content'],
                  //imageUrl: snapshot.data!.docs[index]['imageUrl'],
                  ),
              itemCount: 4,
              separatorBuilder: (BuildContext context, int index) =>
                  const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
              ), //snapshot.data!.docs.length,
            ),
          ),
          /* Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10, left: 10),
                      height: 25,
                      child: Text(
                        'ANOTHER',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => NotificationItem(
                          factorId: snapshot.data!.docs[index]['factorId'],
                          username: snapshot.data!.docs[index]['content'],
                          //imageUrl: snapshot.data!.docs[index]['imageUrl'],
                        ),
                        itemCount: snapshot.data!.docs.length,
                      ),
                    ),*/
        ],
      ),
      /* : const Center(
                  child: Text("You dont have any notis"),
                );*/
      /*   },
      ),
    );*/
    );
  }
}
