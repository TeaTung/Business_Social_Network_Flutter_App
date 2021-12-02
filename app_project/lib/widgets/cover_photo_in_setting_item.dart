import 'package:flutter/material.dart';
import 'package:test_fix/widgets/title_change_in_setting_item.dart';

class CoverPhotoInSettingItem extends StatelessWidget {
  final String coverPhotoUrl;
  final VoidCallback changePicture;

  const CoverPhotoInSettingItem({
    Key? key,
    required this.coverPhotoUrl,
    required this.changePicture,
  }) : super(key: key);

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
              changeHandler: changePicture,
              title: 'Cover Photo',
            ),
            const SizedBox(height: 13),
            Center(
              child: coverPhotoUrl == ''
                  ? Container(
                      padding: const EdgeInsets.all(30),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(224, 224, 224, 1),
                      ),
                      child: coverPhotoUrl == ''
                          ? null
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                coverPhotoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                    )
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          coverPhotoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
