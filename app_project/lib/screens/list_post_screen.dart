import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import '../providers/posts.dart';
import '../providers/user.dart';
import '../widgets/post_item.dart';

class ListPostScreen extends StatelessWidget {
  Post p = Post(
      postTime: DateTime.now(),
      id: "1",
      user: User(
        uid: 'id',
        userName: 'Bopy',
        avatarUrl:
            "https://images.pexels.com/photos/2002719/pexels-photo-2002719.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      ),
      content: "Helo",
      likeCount: 1,
      isBusinessPost: false,
      comments: null,
      imageUrl:
          "https://images.pexels.com/photos/5478188/pexels-photo-5478188.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");

  // use this to scroll to bottom of listview
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final listPost = Provider.of<Posts>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                ),
              ),
              onPressed: () {
                listPost.addPost(p);
                _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              child: Icon(
                Icons.add,
                size: 22,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                ),
              ),
              onPressed: () {
                listPost.removePost(listPost.items.length - 1);
                _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              child: Icon(
                MdiIcons.minus,
                size: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: ListView.builder(
            controller: _controller,
            itemCount: listPost.items.length,
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                value: listPost.items[index],
                child: PostItem(),
              );
            }),
      ),
    );
  }
}
