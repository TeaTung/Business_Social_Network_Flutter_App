import 'package:flutter/material.dart';
import '../providers/round.dart';

class DashDotItem extends StatelessWidget {
  final List<Round> listRound;
  final int index;

  const DashDotItem({
    Key? key,
    required this.listRound,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: listRound[index].isFinished
                ? const Color.fromRGBO(248, 145, 71, 1)
                : const Color.fromRGBO(100, 100, 100, 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        const SizedBox(height: 13),
        if (listRound.length != index + 1)
          Column(
            children: [
              const SizedBox(height: 2),
              Container(
                width: 3,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: listRound[index].isFinished
                      ? const Color.fromRGBO(248, 145, 71, 1)
                      : const Color.fromRGBO(100, 100, 100, 1.0),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 3.5),
                width: 3,
                height: 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: listRound[index].isFinished
                      ? const Color.fromRGBO(248, 145, 71, 1)
                      : const Color.fromRGBO(100, 100, 100, 1.0),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 3.5),
                width: 3,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: listRound[index].isFinished
                      ? const Color.fromRGBO(248, 145, 71, 1)
                      : const Color.fromRGBO(100, 100, 100, 1.0),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
      ],
    );
  }
}
