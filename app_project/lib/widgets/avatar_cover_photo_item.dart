import 'package:flutter/material.dart';

class AvatarCoverPhoto extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final String coverPhotoUrl;
  final String quote;

  AvatarCoverPhoto(
    this.userName,
    this.avatarUrl,
    this.coverPhotoUrl,
    this.quote,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // avatar and cover photo
        SizedBox(
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(17),
                        topLeft: Radius.circular(17),
                      ),
                      color: Color.fromRGBO(224, 224, 224, 1),
                    ),
                    child: coverPhotoUrl == ''
                        ? null
                        : Image.network(
                            coverPhotoUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
              Positioned(
                top: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  backgroundColor: Colors.grey,
                  maxRadius: 70,
                ),
              ),
            ],
          ),
        ),
        // user name and quote
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                userName,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                quote,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: const Color.fromRGBO(128, 128, 128, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
