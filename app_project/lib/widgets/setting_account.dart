import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/user.dart';

import './change_information_item.dart';
import '../providers/account.dart';

class SettingAccount extends StatelessWidget {
  static const routeName = '/SettingAccount';

  const SettingAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final user = Provider.of<User>(context);
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 20),
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
              const SizedBox(height: 3),
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

    Widget titleWidget(String title, bool takePicture) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline1,
              ),
              GestureDetector(
                onTap: takePicture ? handlerPicture : handlerInformation,
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
          const SizedBox(height: 15),
        ],
      );
    }

    Widget listDetailInformation() {
      return Column(
        children: [
          detailInformation(
            const Icon(
              EvaIcons.edit2,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Name',
            user.userName,
          ),
          const SizedBox(height: 3),
          detailInformation(
            const Icon(
              EvaIcons.gift,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Birth Date',
            DateFormat('d MMM y').format(account.birthDate),
          ),
          const SizedBox(height: 3),
          detailInformation(
            const Icon(
              EvaIcons.person,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Gender',
            account.gender,
          ),
          const SizedBox(height: 3),
          detailInformation(
            const Icon(
              EvaIcons.pin,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Nationality',
            account.nationality,
          ),
          const SizedBox(height: 3),
          detailInformation(
            const Icon(
              EvaIcons.text,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Quote',
            account.quote,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          user.userName,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            titleWidget('Avatar', true),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  user.avatarUrl.isEmpty
                      ? 'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'
                      : user.avatarUrl,
                ),
                maxRadius: 70,
              ),
            ),
            const SizedBox(height: 6),
            const Divider(thickness: 1),
            titleWidget('Cover photo', true),
            Center(
              child: account.coverPhotoUrl == ''
                  ? Container(
                      padding: const EdgeInsets.all(30),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: const Color.fromRGBO(224, 224, 224, 1),
                      ),
                      child: account.coverPhotoUrl == ''
                          ? null
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(27),
                              child: Image.network(
                                account.coverPhotoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                    )
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(27),
                        child: Image.network(
                          account.coverPhotoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1),
            titleWidget('Detail information', false),
            listDetailInformation(),
          ],
        ),
      ),
    );
  }
}
