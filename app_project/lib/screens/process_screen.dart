import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/process_item.dart';

import '../providers/process.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProcess = Provider.of<Processes>(context).items;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Process',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listProcess.length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: ProcessItem(
              position: listProcess[index].position,
              companyName: listProcess[index].companyName,
              listItem: listProcess[index].listRound,
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 40),
        ),
      ),
    );
  }
}
