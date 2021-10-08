import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/process_item.dart';

import '../providers/process.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProcess = Provider
        .of<Processes>(context)
        .items;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Process',
          textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .headline1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 0.6,
          ),
          preferredSize: const Size.fromHeight(3),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listProcess.length,
          itemBuilder: (context, index) => ProcessItem(
            position: listProcess[index].position,
            companyName: listProcess[index].companyName,
            listItem: listProcess[index].listRound,
          ),
        ),
      ),
    );
  }
}
