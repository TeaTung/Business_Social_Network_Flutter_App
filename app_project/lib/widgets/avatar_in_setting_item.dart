import 'package:flutter/material.dart';
import 'package:test_fix/widgets/title_change_in_setting_item.dart';

class AvatarInSettingItem extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback changePicture;

  const AvatarInSettingItem(
      {Key? key, required this.avatarUrl, required this.changePicture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        child: Column(
          children: [
            TitleChangeInSettingItem(
              title: 'Avatar',
              changeHandler: changePicture,
            ),
            const SizedBox(height: 7),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  avatarUrl.isEmpty
                      ? 'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'
                      : avatarUrl,
                ),
                maxRadius: 80,
              ),
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
