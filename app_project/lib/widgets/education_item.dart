import 'package:app_project/providers/education.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//This widget will be loaded into education section in Account screen
class EducationItem extends StatelessWidget {
  const EducationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Education education = Provider.of<Education>(context);

    //This code below test widget without data
    // Education education = Education(
    //   id: '123',
    //   uid: '321',
    //   title: 'Toeic Reading & Listening',
    //   issueYear: DateTime.now(),
    //   organization: 'IIG Vietnam',
    //   credentialUrl: 'https:google.com',
    //   description: 'This certificate prove my English skills',
    // );

    String getEndDate() {
      if (education.expirationYear == null) {
        return 'No expiration';
      } else {
        return DateFormat('MM-yyyy').format(education.expirationYear!);
      }
    }

    openUrl() async {
      if (education.credentialUrl != null) {
        if (await canLaunch(education.credentialUrl!)) {
          //SimpleUrlPreview(url: position.companyUrl!);
          launch(education.credentialUrl!);
        } else {
          throw 'Can not launch credential url';
        }
      }
    }

    //This function will be deployed later
    void launchOrganizationPage() {}

    return Wrap(
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (education.credentialProviderAvtUrl != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12.0),
                      child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage:
                            NetworkImage(education.credentialProviderAvtUrl!),
                      ),
                    ),
                  if (education.credentialProviderAvtUrl == null)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12.0),
                      child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage:
                            AssetImage('assets/images/certificate.png'),
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
                          education.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          education.organization,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${DateFormat('MM/yyyy').format(education.issueYear)} - ${getEndDate()}',
                        ),
                        const SizedBox(height: 4),
                        if (education.description != null)
                          Text(education.description!),
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
