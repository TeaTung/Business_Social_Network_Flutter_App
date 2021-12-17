import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_fix/screens/authentication/sigin_in_screen/sign_in_screen.dart';
import 'package:test_fix/screens/change_password_screen.dart';
import 'package:test_fix/screens/change_picture_screen.dart';
import 'package:test_fix/screens/education_screen.dart';
import 'package:test_fix/screens/positon_screen.dart';

import '../screens/change_information_screen.dart';
import 'information_can_change_item.dart';

class ListInformationCanChangeItem extends StatelessWidget {
  const ListInformationCanChangeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void changeInformation() {
      Navigator.of(context).pushNamed(ChangeInformationScreen.routeName);
    }

    void changePassword() {
      Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
    }

    void changeCarrier() {
      Navigator.of(context).pushNamed(PositionScreen.routeName);
    }

    void changeEducation() {
      Navigator.of(context).pushNamed(EducationScreen.routeName);
    }

    void changePicture() {
      Navigator.of(context).pushNamed(ChangePictureScreen.routeName);
    }

    Future<void> logout() async {
      showDialog(
          context: context,
          builder: (BuildContext builder) {
            return AlertDialog(
              title: const Text('Confirm'),
              content: const Text('Are you sure you wish to logout ?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      SignInScreen.routeName,
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text("Yes"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No"),
                ),
              ],
            );
          });
    }

    return Card(
      elevation: 0,
      child: Column(
        children: [
          InformationCanChangeItem(
            icon: Icons.person_outline,
            onPress: changeInformation,
            title: 'Detail information',
          ),
          InformationCanChangeItem(
            icon: MdiIcons.shieldAccountOutline,
            onPress: changePassword,
            title: 'Security',
          ),
          InformationCanChangeItem(
            icon: Icons.work_outline,
            onPress: changeCarrier,
            title: 'Carrier',
          ),
          InformationCanChangeItem(
            icon: Icons.school_outlined,
            onPress: changeEducation,
            title: 'Education',
          ),
          InformationCanChangeItem(
            icon: MdiIcons.accountBoxMultipleOutline,
            onPress: changePicture,
            title: 'Avatar',
          ),
          InformationCanChangeItem(
            icon: Icons.login_outlined,
            onPress: logout,
            title: 'Logout',
          ),
        ],
      ),
    );
  }
}
