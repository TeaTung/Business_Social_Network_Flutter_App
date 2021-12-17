import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';

class CoverPhotoInChangePictureItem extends StatefulWidget {
  const CoverPhotoInChangePictureItem({
    Key? key,
  }) : super(key: key);

  @override
  State<CoverPhotoInChangePictureItem> createState() => _CoverPhotoInChangePictureItemState();
}

class _CoverPhotoInChangePictureItemState extends State<CoverPhotoInChangePictureItem> {
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
                  'Cover Photo',
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
            Center(
              child: account.coverPhotoUrl == ''
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: const Color.fromRGBO(224, 224, 224, 1),
                      ),
                      child: account.coverPhotoUrl == ''
                          ? null
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                account.coverPhotoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          account.coverPhotoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
