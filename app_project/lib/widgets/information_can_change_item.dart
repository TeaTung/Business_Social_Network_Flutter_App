import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class InformationCanChangeItem extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final IconData icon;

  const InformationCanChangeItem(
      {Key? key,
      required this.title,
      required this.onPress,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            Icon(
              icon,
              size: 24,
              color: Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(78, 78, 78, 1),
              ),
            ),
            const Spacer(),
            const Icon(
              EvaIcons.chevronRight,
              color: Color.fromRGBO(248, 145, 71, 1),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
