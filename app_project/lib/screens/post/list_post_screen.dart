import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_fix/providers/post/post_provider.dart';
import 'package:test_fix/providers/post/posts_provider.dart';
import 'package:test_fix/providers/user_info.dart';

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/widgets/post/post_item.dart';

import 'middle_post_create_screen.dart';

class ListPostScreen extends StatelessWidget {
  final _controller = ScrollController();

  late AnimationController controller;

  static const String routeName = '/LIST_POST_SCREEN';

  //  var oldThings =
  //     StreamBuilder(
  //       stream: listPost.getPost(),
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.hasError) {
  //           return Text(snapshot.error.toString());
  //         }

  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //         // ignore: avoid_print
  //         return ListView(
  //           shrinkWrap: true,
  //           controller: _controller,
  //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
  //             Map<String, dynamic> data =
  //                 document.data()! as Map<String, dynamic>;
  //             return PostItem(
  //               postProvider: PostProvider(
  //                 postCreatedUserId: data['postCreatedUserId'],
  //                 id: data['id'],
  //                 content: data['content'],
  //                 isBusinessPost: data['isBusinessPost'],
  //                 likeCount: (int.parse(data['likeCount'].toString())),
  //                 postTime: (data['postTime'].toDate()),
  //                 likedUsers: (List<String>.from(
  //                   data["likedUsers"],
  //                 )),
  //                 shareUsers: (List<String>.from(
  //                   data['shareUsers'],
  //                 )),
  //                 shareCount: data['shareCount'],
  //                 commentCount: data['commentCount'],
  //                 commentUsers: (List<String>.from(
  //                   data["commentUsers"],
  //                 )),
  //                 imageUrl: data['imageUrl'],
  //               ),
  //             );
  //           }).toList(),
  //         );
  //       },

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    final listPost = Provider.of<PostsProvider>(context);
    final userInfoLocal = Provider.of<UserInfoLocal>(context);
    myBanner.load();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: "btn2",
              elevation: 0,
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                ),
              ),
              onPressed: () {
                // listPost.createPost(
                //     content:
                //         'The decision about what to put into your paragraphs begins with the germination of a seed of ideas;',
                //     imageUrl: "https://picsum.photos/200/300",
                //     userInfoLocal: userInfoLocal);
                // _controller.animateTo(
                //   _controller.position.maxScrollExtent,
                //   duration: const Duration(seconds: 1),
                //   curve: Curves.fastOutSlowIn,
                // );

                Navigator.pushNamed(
                  context,
                  MiddlePostCreateScreen.routeName,
                );
              },
              child: const Icon(
                Icons.add,
                size: 22,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                ),
              ),
              onPressed: () {
                //listPost.removePost(listPost.items.length - 1);
                _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              child: const Icon(
                MdiIcons.minus,
                size: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 60, width: 600, child: AdWidget(ad: myBanner)),
          StreamBuilder<List<PostProvider>>(
            stream: listPost.getPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return PostItem(
                        postProvider: snapshot.data![index],
                      );
                    },
                  ),
                );
              } else
                return Center(
                  child: Text('Loading'),
                );
            },
          ),
        ],
      ),
    );
  }
}
