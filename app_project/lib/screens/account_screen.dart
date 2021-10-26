import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/widgets/educations_section.dart';
import 'package:test_fix/widgets/positions_section.dart';
import 'package:test_fix/widgets/setting_account.dart';

import '../providers/account.dart';
import '../providers/posts.dart';
import '../providers/user.dart';

import '../widgets/avatar_cover_photo_item.dart';
import '../widgets/post_item.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/AccountScreen';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final listPost = Provider.of<Posts>(context);
    final user = Provider.of<User>(context);
    final _controller = ScrollController();

    //This is user id
    final id = ModalRoute.of(context)!.settings.arguments;

    Widget detailInformation(
        Icon icon, String title, String detail, VoidCallback? func) {
      return GestureDetector(
        onTap: func,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                child: icon,
              ),
              const SizedBox(width: 12),
              Text(
                detail,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    Widget listDetailInformation() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Basic Information',
                  style: Theme.of(context).textTheme.headline1!,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          detailInformation(
            const Icon(
              EvaIcons.edit2,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Name',
            user.userName,
            null,
          ),
          detailInformation(
            const Icon(
              EvaIcons.bell,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Followers',
            account.followersCount().toString() + ' Followers',
            null,
          ),
          detailInformation(
            const Icon(
              EvaIcons.gift,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Birth Date',
            DateFormat('d MMM y').format(account.birthDate),
            null,
          ),
          detailInformation(
            const Icon(
              EvaIcons.person,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Gender',
            account.gender,
            null,
          ),
          detailInformation(
            const Icon(
              EvaIcons.pin,
              color: Color.fromRGBO(1, 21, 71, 1),
              size: 30,
            ),
            'Nationality',
            account.nationality,
            null,
          ),
          const SizedBox(height: 6),
        ],
      );
    }

    //User click follow button to follow
    void followUser() {}

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
        //Check if id is my id
        leading: id == null
            ? null
            : IconButton(
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
        actions: [
          // check is my uid
          if (id == null)
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushNamed(SettingAccount.routeName);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  AvatarCoverPhoto(
                    user.userName,
                    user.avatarUrl,
                    account.coverPhotoUrl,
                    account.quote,
                  ),
                  //Check if id isn't my id, we can follow him
                  if (id != null)
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 17,
                      ),
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: const Text(
                        "Follow",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  const Divider(thickness: 1),
                  //user information
                  listDetailInformation(),
                  const PositionsSection(),
                  const EducationsSection(),
                ],
              ),
            ),
            //Post of user
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Activities',
                    style: Theme.of(context).textTheme.headline1!,
                  ),
                ],
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              controller: _controller,
              itemCount: listPost.items.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: listPost.items[index],
                  child: const PostItem(),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                height: 7,
                color: const Color.fromRGBO(200, 200, 200, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
