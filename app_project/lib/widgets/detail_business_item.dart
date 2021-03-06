import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './post_detail_screen_item.dart';
import './process_item.dart';

import '../providers/process.dart';

class DetailBusinessItem extends StatelessWidget {
  const DetailBusinessItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //When user click apply job button
    void applyJob() {}

    final process = Provider.of<ProcessProvider>(context);
    return Column(
      children: [
        PostDetailScreenItem(
          'Bopy',
          'This is a very fucking longggggggggggggggggggggg description',
          'https://picsum.photos/200/300',
        ),
        //Fake data ? Of course
        Card(
          elevation: 5,
          child: Column(
            children: [
              ProcessItem(
                process: process,
              ),
              SizedBox(
                width: 320,
                child: ElevatedButton(
                  onPressed: applyJob,
                  child: const Text("Apply now"),
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ],
    );
  }
}
