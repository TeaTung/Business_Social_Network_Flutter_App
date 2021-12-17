import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/widgets/avatar_in_setting_item.dart';
import 'package:test_fix/widgets/avatar_username_item.dart';
import 'package:test_fix/widgets/list_information_can_change_item.dart';
import 'package:test_fix/widgets/user_information_in_setting_item.dart';

import '../widgets/change_information_item.dart';
import '../providers/account.dart';
import '../widgets/cover_photo_in_setting_item.dart';
import 'account_screen.dart';

class SettingAccountScreen extends StatelessWidget {
  static const routeName = '/SettingAccountScreen';

  const SettingAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Account account = Provider.of<Account>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Setting',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(248, 145, 71, 1),
            fontFamily: 'Helvetica',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(248, 145, 71, 1),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          children: [
            AvatarUsernameItem(
              avatarUrl: account.avatarUrl,
              name: account.userName,
            ),
            const SizedBox(height: 10),
            const ListInformationCanChangeItem(),
          ],
        ),
      ),
    );
  }
}
