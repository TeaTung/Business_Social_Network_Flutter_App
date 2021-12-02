import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/widgets/title_change_in_setting_item.dart';

class UserInformationInSettingItem extends StatelessWidget {
  final Account account;
  final UserInfoLocal user;
  final VoidCallback changeInformation;

  const UserInformationInSettingItem({
    Key? key,
    required this.account,
    required this.user,
    required this.changeInformation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget detailInformation(Icon icon, String title, String detail) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title,
                  style: const TextStyle(
                    color: Color.fromRGBO(248, 145, 71, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 3),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.67,
                child: Text(
                  detail,
                  style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(95, 95, 95, 1),
                      ),
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ],
      );
    }

    return Card(
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        child: Column(
          children: [
            TitleChangeInSettingItem(
              changeHandler: changeInformation,
              title: 'Information',
            ),
            const SizedBox(height: 13),
            detailInformation(
              const Icon(
                EvaIcons.edit2,
                color: Color.fromRGBO(248, 145, 71, 1),
                size: 30,
              ),
              'Name',
              user.userName,
            ),
            const SizedBox(height: 5),
            detailInformation(
              const Icon(
                EvaIcons.gift,
                color: Color.fromRGBO(248, 145, 71, 1),
                size: 30,
              ),
              'Birth Date',
              DateFormat('d MMM y').format(account.birthDate),
            ),
            const SizedBox(height: 5),
            detailInformation(
              const Icon(
                EvaIcons.person,
                color: Color.fromRGBO(248, 145, 71, 1),
                size: 30,
              ),
              'Gender',
              account.gender,
            ),
            const SizedBox(height: 5),
            detailInformation(
              const Icon(
                EvaIcons.pin,
                color: Color.fromRGBO(248, 145, 71, 1),
                size: 30,
              ),
              'Nationality',
              account.nationality,
            ),
            const SizedBox(height: 5),
            detailInformation(
              const Icon(
                Icons.textsms_outlined,
                color: Color.fromRGBO(248, 145, 71, 1),
                size: 30,
              ),
              'Quote',
              account.quote,
            ),
          ],
        ),
      ),
    );
  }
}
