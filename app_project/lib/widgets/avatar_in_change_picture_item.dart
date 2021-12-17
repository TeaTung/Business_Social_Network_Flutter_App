import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';

class AvatarInChangePictureItem extends StatefulWidget {
  const AvatarInChangePictureItem({Key? key}) : super(key: key);

  @override
  State<AvatarInChangePictureItem> createState() =>
      _AvatarInChangePictureItemState();
}

class _AvatarInChangePictureItemState extends State<AvatarInChangePictureItem> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);

    final ImagePicker _picker = ImagePicker();
    File pickedImageFile;

    void takePhoto() async {
      await _picker.pickImage(source: ImageSource.camera).then((value) {
        pickedImageFile = File(value!.path);
        account.setAndFetchAvatar(pickedImageFile);
      });
    }

    void chooseFromGallery() async {
      await _picker.pickImage(source: ImageSource.gallery).then((value) {
        pickedImageFile = File(value!.path);
        account.setAndFetchAvatar(pickedImageFile);
      });
    }

    Widget takeAvatar() {
      return FractionallySizedBox(
        heightFactor: 0.16,
        child: Column(
          children: [
            const SizedBox(height: 7),
            TextButton(
              onPressed: chooseFromGallery,
              child: Row(
                children: const [
                  SizedBox(width: 10),
                  Icon(
                    Icons.image,
                    color: Color.fromRGBO(248, 145, 71, 1),
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Choose from library',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: takePhoto,
              child: Row(
                children: const [
                  SizedBox(width: 10),
                  Icon(
                    Icons.camera_alt,
                    color: Color.fromRGBO(248, 145, 71, 1),
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Take a picture',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    void changeAvatar() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return takeAvatar();
        },
        isScrollControlled: true,
      );
    }

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                const Text(
                  'Avatar',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: changeAvatar,
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(248, 145, 71, 1),
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 3),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  account.avatarUrl.isEmpty
                      ? 'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'
                      : account.avatarUrl,
                ),
                maxRadius: 70,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
