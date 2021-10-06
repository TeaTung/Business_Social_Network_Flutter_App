import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/round.dart';

class ProcessItem extends StatelessWidget {
  final String companyName;
  final String position;
  final List<Round> listItem;

  const ProcessItem({
    Key? key,
    required this.companyName,
    required this.position,
    required this.listItem,
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
                    listItem[index].roundName,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    width: 10
                  ),
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
              const SizedBox(height: 3,),
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
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Column(
          children: [
            // title
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.business),
                const SizedBox(width: 8),
                Text(
                  companyName,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 20),
                ),
                const Spacer(),
                const Icon(Icons.work_outline),
                const SizedBox(width: 8),
                Text(
                  position,
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
              itemCount: listItem.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => listRound(listItem, index),
            )
          ],
        ),
      ),
    );
  }
}
