import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CreateBusinessPostScreen extends StatefulWidget {
  static var routeName = '/CREATEBUSINESSPOSTSCREEN';

  const CreateBusinessPostScreen({Key? key}) : super(key: key);

  @override
  _CreateBusinessPostScreenState createState() =>
      _CreateBusinessPostScreenState();
}

class _CreateBusinessPostScreenState extends State<CreateBusinessPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return CachedNetworkImage(
            imageUrl: "https://source.unsplash.com/random",
            fit: BoxFit.contain,
          );
        },
        itemCount: 10,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
