import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';

class UserInformationItem extends StatelessWidget {

  const UserInformationItem({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Account account = Provider.of<Account>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        SizedBox(
          width: 235,
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
          width: MediaQuery.of(context).size.width * 0.56,
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
