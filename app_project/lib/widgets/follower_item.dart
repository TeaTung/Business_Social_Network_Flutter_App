import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';

class FollowerItem extends StatefulWidget {
  const FollowerItem({Key? key}) : super(key: key);

  @override
  _FollowerItemState createState() => _FollowerItemState();
}

class _FollowerItemState extends State<FollowerItem> {
  @override
  Widget build(BuildContext context) {
    Account account = Provider.of<Account>(context);
    return Wrap(
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage: NetworkImage(account.getUser.getAvatarUrl),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        account.getUsername,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        account.getGender,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        EvaIcons.personDelete,
                      ),
                      iconSize: 28,
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
