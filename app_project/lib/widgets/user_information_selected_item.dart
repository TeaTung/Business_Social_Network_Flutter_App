import 'package:flutter/material.dart';
import 'package:test_fix/providers/account.dart';

class UserInformationSelectedItem extends StatelessWidget {
  final Account account;

  const UserInformationSelectedItem({
    required this.account,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.53,
          child: Text(
            account.userName,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.53,
          child: Text(
            account.quote,
            style: const TextStyle(
              color: Color.fromRGBO(100, 100, 100, 1),
            ),
          ),
        ),
        const SizedBox(height: 3),

      ],
    );
  }
}
