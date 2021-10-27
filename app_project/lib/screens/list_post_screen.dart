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
      content: "Hello",
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Business Social",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Helvetica',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 0.6,
          ),
          preferredSize: const Size.fromHeight(3),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            listPost.addPost(p);
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          },
          child: const Icon(
            Icons.add,
            size: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        // controller: _controller,
        itemCount: listPost.items.length,
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: listPost.items[index],
            child: PostItem(),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(
          height: 7,
          color: const Color.fromRGBO(200, 200, 200, 1),
        ),
      ),
    );
  }
}
