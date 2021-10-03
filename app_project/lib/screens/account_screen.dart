import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/account.dart';
import '../providers/posts.dart';

import '../widgets/avatar_cover_photo_item.dart';
import '../widgets/setting_account.dart';
import '../widgets/post_item.dart';
import '../widgets/education_item.dart';
import '../widgets/position_item.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Accounts>(context).account;
    final listPost = Provider.of<Posts>(context);
    final _controller = ScrollController();

    Widget detailInformation(Icon icon, String title, String detail) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 20),
            Text(
              detail,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(128, 128, 128, 1),
                  ),
            ),
          ],
        ),
      );
    }
    Widget listDetail() {
      return Column(
        children: [
          detailInformation(const Icon(Icons.drive_file_rename_outline),
            'Name', account.user.userName,),
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
        ],
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
        actions: [
          // check is my uid
          if (account.user.id == 'id')
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushNamed(SettingAccount.routeName);
              },
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              AvatarCoverPhoto(
                account.user.userName,
                account.user.avatarUrl,
                account.coverPhotoUrl,
                account.quote,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 0.6,
                ),
              ),
              listDetail(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 0.6,
                ),
              ),
              // PositionItem(),
              // EducationItem(),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller: _controller,
                  itemCount: listPost.items.length,
                  itemBuilder: (ctx, index) {
                    return ChangeNotifierProvider.value(
                      value: listPost.items[index],
                      child: const PostItem(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
