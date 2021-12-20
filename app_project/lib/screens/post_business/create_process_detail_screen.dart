import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/post/post_provider.dart';
import 'package:test_fix/providers/post/posts_provider.dart';
import 'package:test_fix/providers/process.dart';
import 'package:test_fix/providers/round.dart';
import 'package:test_fix/widgets/post_business/process_create_item.dart';

class CreateProcessDetailScreen extends StatefulWidget {
  const CreateProcessDetailScreen({
    Key? key,
    required this.numberOfProcess,
    required this.postProvider,
    required this.imageFile,
  }) : super(key: key);

  final int numberOfProcess;
  final PostProvider postProvider;
  final PickedFile imageFile;

  @override
  _CreateProcessDetailScreenState createState() =>
      _CreateProcessDetailScreenState();
}

class _CreateProcessDetailScreenState extends State<CreateProcessDetailScreen> {
  // }

  List<Round> listRound = List.from([]);
  List<GlobalKey<FormState>> listFormState = List.from([]);

  void onSaveRound(Round r) {
    listRound.add(r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 145, 71, 1),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                GlobalKey<FormState> globalKey = GlobalKey<FormState>();

                listFormState.add(globalKey);

                return CreateProcessItem(
                  number: index + 1,
                  onSaveRound: onSaveRound,
                  formKey: globalKey,
                );
              },
              itemCount: widget.numberOfProcess,
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: TextButton(
              child: const Icon(
                Icons.check,
                size: 30,
              ),
              onPressed: () {
                for (var key in listFormState) {
                  if (key.currentState != null) key.currentState!.save();
                }
                Provider.of<ProcessesProvider>(context, listen: false)
                    .createProcess(
                  rounds: listRound,
                  postProvider: widget.postProvider,
                  imageFile: widget.imageFile,
                );

                //Provider.of<PostsProvider>(context, listen: false).createPost()
                listRound = List.from([]);
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 3);
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
