import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  const OrangeButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.isSolid,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;
  final bool isSolid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: isSolid
              ? const Color.fromRGBO(248, 145, 71, 1)
              : const Color.fromRGBO(236, 236, 236, 1),
          onPressed: onPress,
          child: Text(
            text,
            style: isSolid
                ? const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )
                : const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(248, 145, 71, 1),
                  ),
          ),
        ),
      ),
    );
  }
}
