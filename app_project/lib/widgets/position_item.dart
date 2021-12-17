import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/position.dart';

//This widget will be loaded into position section in Account screen
class PositionItem extends StatelessWidget {
  final Position position;

  const PositionItem({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? getExperienceYear() {
      int difference = position.endDate.difference(position.startDate).inDays;
      if (difference < 30) {
        return '$difference Days';
      }
      if (difference > 30) {
        if ((difference / 30) < 12) {
          return '${(difference / 30).round()} Months';
        } else {
          return '${((difference / 30) / 12).round()} Years';
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 13,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/company.png'),
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${position.company} - ${position.jobTitle}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Experience: ${getExperienceYear()}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(118, 118, 118, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
