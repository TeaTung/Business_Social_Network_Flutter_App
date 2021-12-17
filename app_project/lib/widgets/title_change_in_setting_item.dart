import 'package:flutter/material.dart';

class TitleChangeInSettingItem extends StatelessWidget {
  final String title;
  final VoidCallback changeHandler;

  const TitleChangeInSettingItem({
    Key? key,
    required this.title,
    required this.changeHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 21,
          ),
        ),
        GestureDetector(
          onTap: changeHandler,
          child: const Text(
            'Change',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(248, 145, 71, 1),
              fontSize: 21,
            ),
          ),
        ),
      ],
    );
  }
}
