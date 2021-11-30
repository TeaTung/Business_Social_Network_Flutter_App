import 'package:flutter/material.dart';
import 'package:test_fix/widgets/round_in_process_item.dart';
import 'package:test_fix/widgets/title_in_process_detail.dart';

import '../providers/round.dart';

class ListRoundInProcessItem extends StatelessWidget {
  final List<Round> listRound;

  const ListRoundInProcessItem({
    Key? key,
    required this.listRound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            const TitleInProcessDetail(
              title: 'About Process',
              icon: Icons.download_done_outlined,
            ),
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listRound.length,
              itemBuilder: (context, index) =>
                  RoundInProcessItem(listRound: listRound, index: index),
            ),
          ],
        ),
      ),
    );
  }
}
