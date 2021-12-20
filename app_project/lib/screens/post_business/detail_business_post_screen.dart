import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_fix/providers/post/post_provider.dart';
import 'package:test_fix/widgets/post_business/process_view_item.dart';

class DetailBusinessPostScreen extends StatefulWidget {
  const DetailBusinessPostScreen({Key? key, required this.postProvider})
      : super(key: key);

  final PostProvider postProvider;
  @override
  _DetailBusinessPostScreenState createState() =>
      _DetailBusinessPostScreenState();
}

class _DetailBusinessPostScreenState extends State<DetailBusinessPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 145, 71, 1),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.postProvider.getRoundsForPost(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const Text("Loading"));
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          List<String> listRound = List.from(data['rounds']);
          return Padding(
              padding: EdgeInsets.only(top: 19, bottom: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  List content = listRound[index].split('----');
                  return ProcessViewItem(
                    description: content[1],
                    title: content[0],
                  );
                },
                itemCount: data['roundNum'],
              ));
        },
      ),
    );
  }
}
