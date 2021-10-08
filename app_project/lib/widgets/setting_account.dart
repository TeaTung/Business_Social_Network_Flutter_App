import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './change_information_item.dart';
import '../providers/account.dart';

class SettingAccount extends StatelessWidget {
  static const routeName = '/SettingAccount';

  const SettingAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
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

    Widget detailInformation(Icon icon, String title, String detail) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 18),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.67,
                child: Text(
                  detail,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ],
      );
    }

    Widget titleWidget(String title, int count) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
            GestureDetector(
              onTap: count <= 2 ? handlerPicture : handlerInformation,
              child: Text(
                'Change',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          account.user.userName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Helvetica',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 0.6,
          ),
          preferredSize: const Size.fromHeight(3),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(children: [
                titleWidget('Avatar', 1),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      account.user.avatarUrl.isEmpty
                          ? 'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'
                          : account.user.avatarUrl,
                    ),
                    maxRadius: 70,
                  ),
                ),
                const SizedBox(height: 4),
                titleWidget('Cover photo', 2),
                const SizedBox(height: 6),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: const Color.fromRGBO(224, 224, 224, 1),
                    ),
                    child: account.coverPhotoUrl == ''
                        ? null
                        : Image.network(
                            account.coverPhotoUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 6),
                titleWidget('Detail information', 3),
                detailInformation(
                  const Icon(Icons.drive_file_rename_outline),
                  'Name',
                  account.user.userName,
                ),
                detailInformation(
                  const Icon(Icons.cake_outlined),
                  'Birth Date',
                  DateFormat('d MMM y').format(account.birthDate),
                ),
                detailInformation(
                  const Icon(Icons.transgender_outlined),
                  'Gender',
                  account.gender,
                ),
                detailInformation(
                  const Icon(Icons.map_outlined),
                  'Nationality',
                  account.nationality,
                ),
                detailInformation(
                  const Icon(Icons.format_quote_outlined),
                  'Quote',
                  account.quote,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Divider(
                    thickness: 0.6,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
