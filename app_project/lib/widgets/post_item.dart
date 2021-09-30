import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';

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
    var comments = null;
    /*Post post = Post(
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
    );*/
    Post post = Provider.of<Post>(context);
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
                  height: 320,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              /*const Divider(),*/
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (!post.isBusinessPost) ...[
                      _LikePostButton(
                        tapHandler: () {},
                      ),
                      _CommentPostButton(
                        tapHandler: () {},
                      ),
                      _SharePostButton(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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

class _LikePostButton extends StatelessWidget {
  final VoidCallback tapHandler;
  final _primaryColor = Colors.black;
  final _secondaryColor = Colors.black;

  const _LikePostButton({required this.tapHandler});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: tapHandler,
          child: SizedBox(
            height: 40.0,
            child: LikeButton(
              circleColor: const CircleColor(
                start: Color(0xff000000),
                end: Color(0xca000000),
              ),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xA9000000),
                dotSecondaryColor: Color(0xa3000000),
              ),
              size: 20,
              likeBuilder: (bool isLiked) {
                if (isLiked) {
                  return Icon(
                    MdiIcons.heart,
                    color: _primaryColor,
                    size: 23,
                  );
                } else {
                  return Icon(
                    MdiIcons.heartOutline,
                    color: _secondaryColor,
                    size: 22,
                  );
                }
              },
              likeCount: 0,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? _primaryColor : _secondaryColor;
                Widget result;
                if (count == 0) {
                  result = Text(
                    "",
                    style: TextStyle(
                      color: color,
                    ),
                  );
                } else {
                  result = Text(
                    text,
                    style: TextStyle(color: color),
                  );
                }
                return result;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentPostButton extends StatelessWidget {
  final VoidCallback tapHandler;

  const _CommentPostButton({required this.tapHandler});

  final _primaryColor = Colors.black;
  final _secondaryColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: tapHandler,
          child: SizedBox(
            height: 40.0,
            child: LikeButton(
              size: 22,
              circleColor: const CircleColor(
                start: Color(0xff000000),
                end: Color(0xca000000),
              ),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xA9000000),
                dotSecondaryColor: Color(0xa3000000),
              ),
              likeBuilder: (bool isLiked) {
                if (isLiked) {
                  return Container(
                    child: Icon(
                      MdiIcons.message,
                      color: isLiked ? _primaryColor : _secondaryColor,
                      size: 23,
                    ),
                  );
                } else {
                  return Icon(
                    MdiIcons.messageOutline,
                    color: isLiked ? _primaryColor : _secondaryColor,
                    size: 23,
                  );
                }
              },
              likeCount: 0,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? _primaryColor : _secondaryColor;
                Widget result;
                if (count == 0) {
                  result = Text(
                    "",
                    style: TextStyle(color: color),
                  );
                } else {
                  result = Text(
                    text,
                    style: TextStyle(color: color),
                  );
                }
                return result;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SharePostButton extends StatelessWidget {
  final VoidCallback tapHandler;

  const _SharePostButton({required this.tapHandler});

  final _primaryColor = Colors.black;
  final _secondaryColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: tapHandler,
          child: SizedBox(
            height: 40.0,
            child: LikeButton(
              size: 23,
              circleColor: const CircleColor(
                start: Color(0xff000000),
                end: Color(0xca000000),
              ),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xA9000000),
                dotSecondaryColor: Color(0xa3000000),
              ),
              likeBuilder: (bool isLiked) {
                if (isLiked) {
                  return Icon(
                    Icons.check_box,
                    color: isLiked ? _primaryColor : _secondaryColor,
                    size: 23,
                  );
                } else {
                  return Icon(
                    Icons.share,
                    color: isLiked ? _primaryColor : _secondaryColor,
                    size: 23,
                  );
                }
              },
              likeCount: 0,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? _primaryColor : _secondaryColor;
                Widget result;
                if (count == 0) {
                  result = Text(
                    "",
                    style: TextStyle(color: color),
                  );
                } else {
                  result = Text(
                    text,
                    style: TextStyle(color: color),
                  );
                }
                return result;
              },
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
