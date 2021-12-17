import 'package:flutter/material.dart';

class NoItemsFoundItem extends StatelessWidget {
  const NoItemsFoundItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.folder_open,
            size: 24,
            color: Colors.grey[900]!.withOpacity(0.7),
          ),
          const SizedBox(width: 10),
          Text(
            "No Items Found",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[900]!.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );;
  }
}
