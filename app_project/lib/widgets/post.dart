import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String userPostImageUrl;
  final String userPostName;
  final String postDescription;
  String postImageUrl;

  Post(
      this.userPostImageUrl,
      this.userPostName,
      this.postDescription,
      this.postImageUrl,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userPostImageUrl),
                      radius: 30,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        userPostName,
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    postDescription,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Divider(thickness: 1,),
                if (postImageUrl.isNotEmpty)
                  Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      postImageUrl,
                      loadingBuilder: (ctx, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
              ],
            ),
        ),
        const Divider(thickness: 1,),
      ],
    );
  }
}
