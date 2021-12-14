import 'package:flutter/material.dart';

class CustomerButton extends StatelessWidget {
  final String text;
  final bool isSolid;
  final VoidCallback onPress;

  const CustomerButton({
    Key? key,
    required this.text,
    required this.isSolid,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SizedBox(
        height: 50,
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
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
