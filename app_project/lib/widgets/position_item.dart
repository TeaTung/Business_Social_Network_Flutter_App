import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/position.dart';

//This widget will be loaded into position section in Account screen
class PositionItem extends StatelessWidget {
  const PositionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Position position = Provider.of<Position>(context);

    //This code below test widget without data
    // Position position = Position(
    //   id: '123',
    //   uid: '321',
    //   jobTitle: 'UX Engineer',
    //   jobDescription: 'Design UI for company app',
    //   company: 'KMS Technology in Ho Chi Minh city',
    //   startDate: DateTime.now(),
    //   companyUrl: 'https:google.com',
    // );

    String getEndDate() {
      if (position.endDate == null) {
        return 'Present';
      } else {
        return DateFormat('MM-yyyy').format(position.endDate!);
      }
    }

    openUrl() async {
      if (position.companyUrl != null) {
        if (await canLaunch(position.companyUrl!)) {
          //SimpleUrlPreview(url: position.companyUrl!);
          launch(position.companyUrl!);
        } else {
          throw 'Can not launch company url';
        }
      }
    }

    //This function will be deployed later
    void launchCompanyPage() {}

    String? getExperienceYear() {
      if (position.endDate != null) {
        int difference =
            position.endDate!.difference(position.startDate).inDays;
        if (difference < 30) {
          return '$difference Days';
        }
        if (difference > 30) {
          return '${difference / 30} Months';
        }
      } else {
        int difference = DateTime.now().difference(position.startDate).inDays;
        if (difference < 30) {
          return '$difference Days';
        }
        if (difference > 30) {
          return '${difference / 30} Months';
        }
      }
      return null;
    }

    return Wrap(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (position.companyAvt != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12.0),
                      child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage: NetworkImage(position.companyAvt!),
                      ),
                    ),
                  if (position.companyAvt == null)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12.0),
                      child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage:
                            AssetImage('assets/images/company.png'),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          position.jobTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          position.company,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${DateFormat('MM/yyyy').format(position.startDate)} - ${getEndDate()} | ${getExperienceYear()}',
                        ),
                        const SizedBox(height: 4),
                        if (position.jobDescription != null)
                          Text(position.jobDescription!),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: openUrl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
