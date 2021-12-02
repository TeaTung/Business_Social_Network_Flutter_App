import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/widgets/avatar_in_setting_item.dart';
import 'package:test_fix/widgets/user_information_in_setting_item.dart';

import './change_information_item.dart';
import '../providers/account.dart';
import 'cover_photo_in_setting_item.dart';

class SettingAccount extends StatelessWidget {
  static const routeName = '/SettingAccount';

  const SettingAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final user = Provider.of<UserInfoLocal>(context);

    print(account.coverPhotoUrl);

    Widget takePicture() {
      return FractionallySizedBox(
        heightFactor: 0.15,
        child: Column(
          children: [
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  const SizedBox(width: 7),
                  const Icon(Icons.image, color: Colors.black),
                  const SizedBox(width: 20),
                  Text(
                    'Choose from library',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  const SizedBox(width: 7),
                  const Icon(Icons.camera_alt, color: Colors.black),
                  const SizedBox(width: 20),
                  Text(
                    'Take a picture',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    void handlerPicture() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return takePicture();
        },
        isScrollControlled: true,
      );
    }

    void handlerInformation() {
      Navigator.of(context).pushNamed(ChangeInformation.routeName);
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1.0),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          user.userName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: const Color.fromRGBO(248, 145, 71, 1),
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          children: [
            AvatarInSettingItem(
              avatarUrl: user.avatarUrl,
              changePicture: handlerPicture,
            ),
            const SizedBox(height: 10),
            CoverPhotoInSettingItem(
              changePicture: handlerPicture,
              coverPhotoUrl: account.coverPhotoUrl,
            ),
            const SizedBox(height: 10),
            UserInformationInSettingItem(
              account: account,
              user: user,
              changeInformation: handlerInformation,
            )
          ],
        ),
      ),
    );
  }
}
