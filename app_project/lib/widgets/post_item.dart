import 'package:app_project/providers/comments.dart';
import 'package:app_project/providers/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//This widget represents for one individual post to load to posts list
class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //The code bellow doesn't work
    //Add logic provider for this
    // Post post = Provider.of<Post>(context);
    // Comment comment = Provider.of<Comment>(context);

    //The code bellow for test without data
    Comments comments = Comments([]);
    Post post = Post(
      id: DateTime.now().toString(),
      uid: 'test',
      content:
          'This is just stupid long content test text for such a great app',
      likeCount: 15,
      userName: 'TungTea',
      isBusinessPost: false,
      postTime: DateTime.now(),
      comments: comments,
      userAvtUrl:
          'https://lwlies.com/wp-content/uploads/2017/04/avatar-2009-1108x0-c-default.jpg',
      imageUrl:
          'https://lwlies.com/wp-content/uploads/2017/04/avatar-2009-1108x0-c-default.jpg',
    );
    return Wrap(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            post.userAvtUrl,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.userName,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('hh:mm - dd/MM/yyyy')
                                  .format(post.postTime),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      post.content,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              if (post.imageUrl != null)
                Image.network(
                  post.imageUrl!,
                  height: 230,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              const Divider(),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (!post.isBusinessPost) ...[
                      _PostButton(
                        icon: const Icon(
                          MdiIcons.heartOutline,
                          color: Colors.black87,
                          size: 20,
                        ),
                        label: 'Love',
                        tapHandler: () {},
                      ),
                      _PostButton(
                        icon: const Icon(
                          MdiIcons.commentOutline,
                          color: Colors.black87,
                          size: 20,
                        ),
                        label: 'Comment',
                        tapHandler: () {},
                      ),
                      _PostButton(
                        icon: const Icon(
                          MdiIcons.sendOutline,
                          color: Colors.black87,
                          size: 20,
                        ),
                        label: 'Message',
                        tapHandler: () {},
                      ),
                    ],
                    if (post.isBusinessPost) ...[
                      _BusinessButton(
                        icon: const Icon(
                          MdiIcons.accountCheckOutline,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: 'Interested',
                        tapHandler: () {},
                      ),
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback tapHandler;

  const _PostButton({
    required this.icon,
    required this.label,
    required this.tapHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: tapHandler,
          child: SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 5),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BusinessButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback tapHandler;

  const _BusinessButton({
    required this.icon,
    required this.label,
    required this.tapHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: tapHandler,
          child: SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 5),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
