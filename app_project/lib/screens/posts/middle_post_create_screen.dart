import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_fix/screens/posts/create_business_post_screen.dart';
import 'package:test_fix/screens/posts/create_normal_post_screen.dart';

class MiddlePostCreateScreen extends StatelessWidget {
  static var routeName = '/MIDDLEPOSTCREATESCREEN';

  const MiddlePostCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                CreateNormalPostScreen.routeName,
              ),
              child: Container(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://i.pinimg.com/736x/75/a1/e2/75a1e21a7da456ea467a80563510d89e.jpg',
                      fit: BoxFit.cover,
                      width: 2000,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                        height: 30,
                        child: LinearProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        'SOCIAL',
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      bottom: 3,
                      right: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 2,
            color: Colors.white,
          ),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                CreateBusinessPostScreen.routeName,
              ),
              child: Container(
                padding: null,
                margin: null,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://i.pinimg.com/564x/8d/7f/b0/8d7fb022b74e2d027e14f545f39f38eb.jpg',
                      fit: BoxFit.cover,
                      width: 2000,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                        height: 30,
                        child: LinearProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        'BUSINESS',
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      bottom: 10,
                      left: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


      // // child: Column(
          // //   mainAxisAlignment: MainAxisAlignment.center,
          // //   children: [
          // // Text(
          // //   'Choose type of post',
          // //   style: GoogleFonts.workSans(fontSize: 19),
          // // ),
          // // const SizedBox(
          // //   height: 15,
          // // ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TextButton.icon(
          //       onPressed: () {
          //         Navigator.pushNamed(
          //           context,
          //           CreateNormalPostScreen.routeName,
          //         );
          //       },
          //       style: ButtonStyle(
          //           overlayColor: MaterialStateProperty.all(
          //               const Color.fromRGBO(248, 145, 71, 0.2))),
          //       icon: const Icon(
          //         MdiIcons.nodejs,
          //         size: 30,
          //         color: Color.fromRGBO(248, 145, 71, 1),
          //       ),
          //       label: Text(
          //         'Normal',
          //         style: GoogleFonts.workSans(
          //           color: const Color.fromRGBO(248, 145, 71, 1),
          //         ),
          //       ),
          //     ),
          //     TextButton.icon(
          //       onPressed: () {},
          //       icon: const Icon(
          //         MdiIcons.zodiacScorpio,
          //         size: 30,
          //         color: Color.fromRGBO(248, 145, 71, 1),
          //       ),
          //       style: ButtonStyle(
          //           overlayColor: MaterialStateProperty.all(
          //               const Color.fromRGBO(248, 145, 71, 0.2))),
          //       label: Text('Business',
          //           style: GoogleFonts.workSans(
          //             color: const Color.fromRGBO(248, 145, 71, 1),
          //           )),
          //     ),
          //   ],
          // ),