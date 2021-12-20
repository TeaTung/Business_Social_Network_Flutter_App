import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/round.dart';
import '../screens/process_detail_screen.dart';
import '../providers/process.dart';

class ProcessItem extends StatelessWidget {
  final ProcessProvider process;

  const ProcessItem({
    Key? key,
    required this.process,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // design process item
    Widget listRound(List<Round> listItem, int index) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: listItem[index].isFinished ? Colors.blue : Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(height: 12.5),
              if (listItem.length != index + 1)
                Column(
                  children: [
                    const SizedBox(height: 2),
                    Container(
                      width: 3,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: listItem[index].isFinished
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 3.5),
                      width: 3,
                      height: 13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: listItem[index].isFinished
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 3.5),
                      width: 3,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: listItem[index].isFinished
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    listItem[index].roundTitle,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('d MMM y').format(listItem[index].deadline),
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  listItem[index].description,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 14,
                        color: const Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return InkWell(
      // Tap to open detail process
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProcessDetailScreen(
              process: process,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          children: [
            // title
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.business),
                const SizedBox(width: 8),
                Text(
                  process.companyName,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 20),
                ),
                const Spacer(),
                const Icon(Icons.work_outline),
                const SizedBox(width: 8),
                Text(
                  process.position,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            //Round
            ListView.builder(
              itemCount: process.listRound.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  listRound(process.listRound, index),
            )
          ],
        ),
      ),
    );
  }
}
