import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/widgets/coverphoto_in_change_picture_item.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/avatar_in_change_picture_item.dart';

class ChangePictureScreen extends StatefulWidget {
  static const routeName = '/ChangePictureScreen';

  const ChangePictureScreen({Key? key}) : super(key: key);

  @override
  State<ChangePictureScreen> createState() => _ChangePictureScreenState();
}

class _ChangePictureScreenState extends State<ChangePictureScreen> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);


    Widget takeCoverPhoto() {
      return FractionallySizedBox(
        heightFactor: 0.16,
        child: Column(
          children: [
            const SizedBox(height: 7),
            TextButton(
              onPressed: () {},
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
              onPressed: () {},
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


    void changeCoverPhoto() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return takeCoverPhoto();
        },
        isScrollControlled: true,
      );
    }


    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 246, 250, 1.0),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Change Picture',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(248, 145, 71, 1),
              fontFamily: 'Helvetica',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(248, 145, 71, 1),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: const [
              AvatarInChangePictureItem(),
              SizedBox(height: 10),
              CoverPhotoInChangePictureItem(),
            ],
          ),
        ));
  }
}
