import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/widgets/customer_button.dart';
import 'package:test_fix/widgets/list_round_in_process.dart';

import '../providers/process.dart';
import '../providers/round.dart';
import '../widgets/job_description_item.dart';

class ProcessDetailScreen extends StatelessWidget {
  final ProcessProvider process;

  const ProcessDetailScreen({
    Key? key,
    required this.process,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final listProcess = Provider.of<ProcessesProvider>(context).items;

    void onPressButton() {}

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(248, 145, 71, 1),
        title: Text(
          'Process Detail',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Colors.white,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              JobDescriptionItem(process: process),
              const SizedBox(height: 11),
              ListRoundInProcessItem(listRound: process.listRound),
              const SizedBox(height: 13),
              CustomerButton(
                isSolid: true,
                text: 'Unapply',
                onPress: onPressButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
