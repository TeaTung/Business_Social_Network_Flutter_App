import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/education.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/providers/position.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/widgets/position_item.dart';

import 'education_item.dart';

class DismissiblePositionItem extends StatelessWidget {
  final int index;
  final List<Position> listPosition;
  final String uid;

  const DismissiblePositionItem({
    Key? key,
    required this.index,
    required this.listPosition,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Dismissible(
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext builder) {
              return AlertDialog(
                title: const Text("Confirm"),
                content:
                const Text("Are you sure you wish to delete this item?"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Yes")),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        },
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: Row(
            children: const [
              Spacer(),
              Icon(Icons.delete),
              SizedBox(width: 20),
            ],
          ),
        ),
        onDismissed: (direction) {
          Provider.of<Positions>(context, listen: false).removePosition(
              index, uid, listPosition[index].id);
        },
        key: Key(listPosition[index].id),
        child: PositionItem(position: listPosition[index]),
      ),
    );
  }
}

