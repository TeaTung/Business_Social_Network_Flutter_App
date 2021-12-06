import 'package:flutter/material.dart';

class PostDetailScreenItem extends StatelessWidget {
  final String postDescription;
  final String? postImageUrl;

  PostDetailScreenItem({
    required this.postDescription,
    this.postImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          alignment: Alignment.topLeft,
          child: Text(
            postDescription,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        if (postImageUrl != null)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 17),
            alignment: Alignment.center,
            child: Image.network(
              postImageUrl!,
              loadingBuilder: (ctx, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              },
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}
