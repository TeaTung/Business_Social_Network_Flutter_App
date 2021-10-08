import 'package:flutter/material.dart';

// each item in notification trat
class NotificationItem extends StatelessWidget {
  String username;
  String factorId;
  String imageUrl;

  NotificationItem(
      {required this.username, required this.factorId, this.imageUrl = ""});

  @override
  Widget build(BuildContext context) {
    var myColor = Colors.black;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          color: Colors.white,
          margin:
              const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 0),
          elevation: 2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/1935370/pexels-photo-1935370.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'http://i.imgur.com/QSev0hg.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        Positioned(
                          child: CircleAvatar(
                            backgroundColor: Colors.lightBlueAccent,
                            child: Icon(
                              Icons.favorite_outline,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          bottom: -2,
                          right: -5,
                          width: 32,
                          height: 32,
                        ),
                      ],
                      overflow: Overflow.visible,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Devil user ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: myColor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "mentioned you in ",
                              style: TextStyle(fontSize: 14, color: myColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              " mentioned you in a comment",
                              style: TextStyle(fontSize: 14, color: myColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 3, bottom: 3, top: 5, right: 3),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "HAPPY",
                              style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              " 08:32",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
