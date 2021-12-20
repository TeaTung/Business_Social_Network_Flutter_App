import 'package:test_fix/providers/post/post_provider.dart';
import 'package:test_fix/providers/post/posts_provider.dart';
import 'package:test_fix/providers/user_info.dart';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/widgets/post/post_item.dart';
import 'package:test_fix/widgets/search_account_item.dart';

import 'middle_post_create_screen.dart';

class ListPostScreen extends StatelessWidget {
  final _controller = ScrollController();

  late AnimationController controller;

  static const String routeName = '/LIST_POST_SCREEN';

  @override
  Widget build(BuildContext context) {
    final listPost = Provider.of<PostsProvider>(context);
    final userInfoLocal = Provider.of<UserInfoLocal>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          heroTag: "btn2",
          elevation: 0,
          backgroundColor: Colors.black,
          onPressed: () {
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
      ),
      body: StreamBuilder<List<PostProvider>>(
        stream: listPost.getPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SearchAccountItem(),
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return PostItem(
                        postProvider: snapshot.data![index],
                      );
                    },
                  ),
                ),
              ],
            );
          } else
            return const Center(
              child: Text('Loading'),
            );
        },
      ),
    );
  }
}
