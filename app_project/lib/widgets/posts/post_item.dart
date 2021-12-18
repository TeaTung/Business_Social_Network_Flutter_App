import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import 'package:test_fix/providers/comments_provider.dart';
import 'package:test_fix/screens/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:test_fix/screens/posts/detail_post_screen.dart';
import 'package:test_fix/widgets/posts/list_comments.dart';
import '../../providers/comments.dart';
import '../../providers/post_provider.dart';

//This widget represents for one individual post to load to posts list
class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.postProvider}) : super(key: key);

  final PostProvider postProvider;
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;

    return Wrap(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
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
                        // postProvider.imageUrl != null
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            postProvider.userInfoLocal!.avatarUrl.toString(),
                          ),
                        ),

                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: c_width,
                              child: Text(postProvider.userInfoLocal!.userName,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.workSans().copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )),
                            ),
                            const SizedBox(height: 5),
                            Text(
                                DateFormat('hh:mm - dd/MM/yyyy')
                                    .format(postProvider.postTime),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.workSans().copyWith(
                                  fontSize: 15,
                                  color: Colors.black26,
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      postProvider.content,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.workSans(),
                    ),
                  ],
                ),
              ),
              if (postProvider.imageUrl != null)
                CachedNetworkImage(
                  imageUrl: postProvider.imageUrl,
                  height: 280,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                    height: 30,
                    child: LinearProgressIndicator(
                      value: downloadProgress.progress,
                      color: const Color.fromRGBO(248, 145, 71, 1),
                    ),
                  ),
                  width: double.infinity,
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                    if (!false) ...[
                      LikePostButton(
                        postProvider: postProvider,
                      ),
                      CommentPostButton(
                        postProvider: postProvider,
                      ),
                      _SharePostButton(
                        postProvider: postProvider,
                      ),
                    ],
                    if (postProvider.isBusinessPost) ...[
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

class LikePostButton extends StatelessWidget {
  PostProvider postProvider;
  final bool darkTheme;

  LikePostButton({required this.postProvider, this.darkTheme = false});

  @override
  Widget build(BuildContext context) {
    final _primaryColor = darkTheme ? Colors.white : Colors.black;
    final _secondaryColor = darkTheme ? Colors.white : Colors.black;

    if (!darkTheme) {
      return Expanded(
        child: SizedBox(
          height: 30.0,
          child: LikeButton(
            onTap: (liked) async {
              if (!liked) {
                postProvider.updateLikeCount(
                    likeCount: postProvider.likeCount + 1, increment: true);
                if (darkTheme) {
                  postProvider.likedUsers
                      .add(FirebaseChatCore.instance.firebaseUser!.uid);
                }
              } else {
                postProvider.updateLikeCount(
                    likeCount: postProvider.likeCount - 1, increment: false);

                if (darkTheme) {
                  postProvider.likedUsers
                      .remove(FirebaseChatCore.instance.firebaseUser!.uid);
                }
              }
              return !false;
            },
            circleColor: const CircleColor(
              start: Color(0xff000000),
              end: Color(0xca000000),
            ),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Color(0xA9000000),
              dotSecondaryColor: Color(0xa3000000),
            ),
            size: 20,
            isLiked: postProvider.isLikedAlready(),
            likeBuilder: (bool isLiked) {
              if (isLiked) {
                return Icon(
                  MdiIcons.heart,
                  color: _primaryColor,
                  size: 20,
                );
              } else {
                return Icon(
                  MdiIcons.heartOutline,
                  color: _secondaryColor,
                  size: 20,
                );
              }
            },
            likeCount: postProvider.likeCount,
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
                if (count! > 1000) {
                  result = Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(
                      text,
                      style: TextStyle(color: color, fontSize: 14),
                    ),
                  );
                } else {
                  result = Text(
                    text,
                    style: TextStyle(color: color),
                  );
                }
              }
              return result;
            },
          ),
        ),
      );
    }
    return SizedBox(
      height: 30.0,
      child: LikeButton(
        onTap: (liked) async {
          if (!liked) {
            postProvider.updateLikeCount(
                likeCount: postProvider.likeCount + 1, increment: true);
          } else {
            postProvider.updateLikeCount(
                likeCount: postProvider.likeCount - 1, increment: false);
          }
          return !false;
        },
        circleColor: const CircleColor(
          start: Colors.white,
          end: Colors.white,
        ),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Colors.white,
          dotSecondaryColor: Colors.white,
        ),
        size: 20,
        isLiked: postProvider.isLikedAlready(),
        likeBuilder: (bool isLiked) {
          if (isLiked) {
            return Icon(
              MdiIcons.heart,
              color: _primaryColor,
              size: 20,
            );
          } else {
            return Icon(
              MdiIcons.heartOutline,
              color: _secondaryColor,
              size: 20,
            );
          }
        },
        likeCount: postProvider.likeCount,
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
            if (count! > 1000) {
              result = Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Text(
                  text,
                  style: TextStyle(color: color, fontSize: 14),
                ),
              );
            } else {
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            }
          }
          return result;
        },
      ),
    );
  }
}

class CommentPostButton extends StatelessWidget {
  CommentPostButton({required this.postProvider, this.darkTheme = false});

  final PostProvider postProvider;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    final _primaryColor = darkTheme ? Colors.white : Colors.black;
    final _secondaryColor = darkTheme ? Colors.white : Colors.black;
    if (!darkTheme) {
      return Expanded(
        child: SizedBox(
          height: 40.0,
          child: LikeButton(
            size: 22,
            onTap: (liked) {
              Navigator.pushNamed(
                context,
                DetailPostScreen.routeName,
                arguments: postProvider,
              );
              return Future.value(liked);
            },
            isLiked: postProvider.isCommentAlready(),
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
                    size: 20,
                  ),
                );
              } else {
                return Icon(
                  MdiIcons.messageOutline,
                  color: isLiked ? _primaryColor : _secondaryColor,
                  size: 20,
                );
              }
            },
            likeCount: postProvider.commentCount,
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
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: 40.0,
        child: LikeButton(
          size: 22,
          onTap: (liked) {
            if (!darkTheme) {
              Navigator.pushNamed(
                context,
                DetailPostScreen.routeName,
                arguments: postProvider,
              );
            } else {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (builder) {
                    return Container(
                      decoration: const BoxDecoration(),
                      child: ChangeNotifierProvider(
                        create: (BuildContext context) => CommentsProvider(),
                        child: ListComments(
                          postId: postProvider.id,
                        ),
                      ),
                    );
                  });
            }

            return Future.value(liked);
          },
          isLiked: postProvider.isCommentAlready(),
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
                  size: 20,
                ),
              );
            } else {
              return Icon(
                MdiIcons.messageOutline,
                color: isLiked ? _primaryColor : _secondaryColor,
                size: 20,
              );
            }
          },
          likeCount: postProvider.commentCount,
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
    );
  }
}

class _SharePostButton extends StatelessWidget {
  _SharePostButton({required this.postProvider});

  PostProvider postProvider;

  final _primaryColor = Colors.black;
  final _secondaryColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40.0,
        child: LikeButton(
          onTap: (isLiked) async {
            if (!isLiked) {
              postProvider.updateShareCount(
                shareCount: postProvider.shareCount + 1,
                increment: true,
              );
            } else {
              postProvider.updateShareCount(
                shareCount: postProvider.shareCount - 1,
                increment: false,
              );
            }
            return !isLiked;
          },
          isLiked: postProvider.isShareAlready(),
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
                size: 22,
              );
            } else {
              return Icon(
                Icons.link_rounded,
                color: isLiked ? _primaryColor : _secondaryColor,
                size: 26,
              );
            }
          },
          likeCount: postProvider.shareCount,
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
