import 'package:flutter/material.dart';
import 'package:test_fix/providers/account.dart';

class PopupListItem extends StatelessWidget {
  final Account account;
  const PopupListItem({Key? key, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        account.userName,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
