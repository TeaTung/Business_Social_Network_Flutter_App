import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';

class ListDetailInformationInAccountScreen extends StatelessWidget {
  const ListDetailInformationInAccountScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Account account = Provider.of<Account>(context, listen: false);

    Widget detailInformation(IconData icon, String title, String detail) {
      return Row(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          Text(
            '   $title ',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(118, 118, 118, 1),
            ),
          ),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 375,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About myself',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 13),
                  detailInformation(
                    Icons.person_outline,
                    'My name is ',
                    account.userName,
                  ),
                  const SizedBox(height: 5),
                  detailInformation(
                    EvaIcons.heartOutline,
                    'I have ',
                    account.followersCount() == 0
                        ? '0 followers'
                        : account.followersCount().toString() + ' follower',
                  ),
                  const SizedBox(height: 5),
                  detailInformation(
                    MdiIcons.calendarBlankOutline,
                    'My birthdate is ',
                    DateFormat('d MMM y').format(account.birthDate),
                  ),
                  const SizedBox(height: 5),
                  detailInformation(
                    account.gender == 'Male'
                        ? Icons.male_outlined
                        : Icons.female_outlined,
                    'My gender is ',
                    account.gender,
                  ),
                  const SizedBox(height: 5),
                  detailInformation(
                    Icons.location_on_outlined,
                    'I live in ',
                    account.nationality,
                  ),
                  const SizedBox(height: 5),
                  detailInformation(
                    Icons.mail_outlined,
                    'Contact me to ',
                    account.email,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
