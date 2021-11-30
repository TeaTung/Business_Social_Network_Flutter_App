import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/round.dart';
import 'dash_dot_item.dart';
import 'detail_round_item.dart';

class RoundInProcessItem extends StatelessWidget {
  final List<Round> listRound;
  final int index;

  const RoundInProcessItem({
    Key? key,
    required this.listRound,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DashDotItem(index: index, listRound: listRound),
        const SizedBox(
          width: 15
        ),
        DetailRoundItem(index: index, listRound: listRound),
      ],
    );
  }
}
