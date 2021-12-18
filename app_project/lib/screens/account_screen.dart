import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/widgets/avatar_coverphoto_item.dart';
import 'package:test_fix/widgets/list_detail_information_in_account_screen.dart';
import 'package:test_fix/widgets/pageview_custom.dart';
import 'package:test_fix/screens/setting_account_screen.dart';
import 'package:search_widget/search_widget.dart';
import 'package:test_fix/widgets/search_account_item.dart';

import '../providers/account.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/AccountScreen';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    final myAccount =
        Provider.of<Account>(context, listen: false).getMyAccount(id);

    return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            Account account = snapshot.data as Account;
            return Scaffold(
                backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  title: Text(
                    account.userName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromRGBO(248, 145, 71, 1),
                      fontFamily: 'Helvetica',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Color.fromRGBO(248, 145, 71, 1),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SettingAccountScreen.routeName);
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children:  [
                      const AvatarCoverPhotoItem(),
                      const SearchAccountItem(),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 7,
                        ),
                        child: ListDetailInformationInAccountScreen(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: PageViewCustom(id: id),
                      ),
                    ],
                  ),
                ));
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
        future: myAccount);
  }
}
