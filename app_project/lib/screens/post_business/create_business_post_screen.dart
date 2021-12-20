import 'dart:io';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/post/posts_provider.dart';
import 'package:test_fix/providers/user_info.dart';
import 'package:test_fix/screens/post_business/create_process_post_screen.dart';
import 'package:uuid/uuid.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_fix/providers/post/post_provider.dart';

class CreateBusinessPostScreen extends StatefulWidget {
  static var routeName = '/CREATEBUSINESSPOSTSCREEN';

  const CreateBusinessPostScreen({Key? key}) : super(key: key);

  @override
  _CreateBusinessPostScreenState createState() =>
      _CreateBusinessPostScreenState();
}

class _CreateBusinessPostScreenState extends State<CreateBusinessPostScreen> {
  var _back_color = Color.fromRGBO(248, 227, 203, 1);
  var imageFile = null;
  final _form = GlobalKey<FormState>();

  late PostProvider _post;

  @override
  Widget build(BuildContext context) {
    var userInforLocal = Provider.of<UserInfoLocal>(context);
    var posts = Provider.of<PostsProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DESCRIPTIONS
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 20,
                bottom: 10,
                top: 30,
              ),
              child: Text("Description",
                  style: GoogleFonts.workSans()
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                minLines: 4,
                maxLines: 10,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    Text(
                        (currentLength > 1)
                            ? (currentLength.toString() + " words")
                            : (currentLength.toString() + " word"),
                        style: GoogleFonts.workSans().copyWith(fontSize: 18)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  hintText: 'Post what you want',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.6), width: 1.5),
                  ),
                ),
                style: GoogleFonts.workSans().copyWith(fontSize: 20),
                onSaved: (value) {
                  _post = PostProvider(
                    id: const Uuid().v4(),
                    content: value as String,
                    isBusinessPost: false,
                    likeCount: 0,
                    postTime: DateTime.now(),
                    commentCount: 0,
                    commentUsers: [],
                    imageUrl: 'https://source.unsplash.com/random',
                    likedUsers: [],
                    postCreatedUserId: '',
                    shareCount: 0,
                    shareUsers: [],
                  );
                },
              ),
            ),

            //images
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 20,
                bottom: 10,
                top: 20,
              ),
              child: Text("Image",
                  style: GoogleFonts.workSans()
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            InkWell(
              onTap: () {
                _showChoiceDialog(context);
                print(imageFile.runtimeType.toString());
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 10,
                  top: 10,
                ),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: (imageFile != null)
                        ? DecorationImage(
                            image:
                                FileImage(File((imageFile as PickedFile).path)),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: Icon(
                  Icons.image,
                  color: Colors.black.withOpacity(0.4),
                  size: 30,
                ),
              ),
            ),

            // POST button
            Container(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: 10,
                top: 20,
              ),
              margin: const EdgeInsets.only(bottom: 20),
              width: double.infinity,
              height: 100,
              child: ElevatedButton(
                child: Text("NEXT",
                    style: GoogleFonts.workSans().copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  // savePost(
                  //   posts,
                  //   userInforLocal,
                  //);
                  // int count = 0;
                  // Navigator.of(context).popUntil((_) => count++ >= 2);

                  savePost(posts, userInforLocal);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateProcessPostScreen(
                        businessPostProvider: _post,
                        imageFile: imageFile,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 1,
                    primary: const Color.fromRGBO(248, 145, 71, 1)),
              ),
            ),
          ],
        ),
      )),
    );
  }

  // HANDLE IMAGES
  void _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // SAVE
  // I use default url here
  void savePost(PostsProvider posts, UserInfoLocal userInfoLocal) {
    _form.currentState!.save();
    if (imageFile != null) {
      _post = PostProvider(
        id: _post.id,
        content: _post.content,
        isBusinessPost: false,
        likeCount: 0,
        userInfoLocal: userInfoLocal,
        postTime: DateTime.now(),
        imageUrl: '',
        commentCount: 0,
        commentUsers: [],
        likedUsers: [],
        postCreatedUserId: '',
        shareCount: 0,
        shareUsers: [],
      );

      // _post.savePostToDatabase(
      //   postsProvider: posts,
      //   myUserInfoLocal: userInfoLocal,
      //   imageFile: imageFile,
      // );
    } else {
      _post = PostProvider(
        id: _post.id,
        content: _post.content,
        isBusinessPost: true,
        userInfoLocal: userInfoLocal,
        likeCount: 0,
        postTime: DateTime.now(),
        imageUrl: '',
        commentCount: 0,
        commentUsers: [],
        likedUsers: [],
        postCreatedUserId: '',
        shareCount: 0,
        shareUsers: [],
      );

      // _post.savePostToDatabase(
      //   postsProvider: posts,
      //   myUserInfoLocal: userInfoLocal,
      //   imageFile: imageFile,
      // );
    }
  }
}
