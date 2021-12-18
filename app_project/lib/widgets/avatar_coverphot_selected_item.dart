import 'package:flutter/material.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/widgets/user_information_item.dart';
import 'package:test_fix/widgets/user_information_selected_item.dart';

class AvatarCoverPhotoSelectedItem extends StatelessWidget {
  final Account account;

  const AvatarCoverPhotoSelectedItem({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 225,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(224, 224, 224, 1),
              ),
              child: account.coverPhotoUrl == ''
                  ? null
                  : ClipRRect(
                      child: Image.network(
                        account.coverPhotoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 195,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 23,
                    horizontal: 22,
                  ),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(37),
                      topLeft: Radius.circular(37),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(account.avatarUrl),
                        backgroundColor: Colors.grey,
                        maxRadius: 55,
                      ),
                      const SizedBox(width: 20),
                      UserInformationSelectedItem(account: account),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
