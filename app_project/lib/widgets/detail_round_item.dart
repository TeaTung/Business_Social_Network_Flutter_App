import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/round.dart';

class DetailRoundItem extends StatelessWidget {
  final List<Round> listRound;
  final int index;

  const DetailRoundItem({
    Key? key,
    required this.listRound,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              listRound[index].roundName,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: const Color.fromRGBO(248, 145, 71, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat('d MMM y').format(listRound[index].deadline),
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(145, 145, 145, 1.0),
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.825,
          child: Text(
            listRound[index].description,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 18,
                  color: const Color.fromRGBO(100, 100, 100, 1.0),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),

      ],
    );
  }
}
