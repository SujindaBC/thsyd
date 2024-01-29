import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:thsyd/models/post_category.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  static const routeName = "create-post";

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String categoryNameString(PostCategoryName postCategoryName) {
    switch (postCategoryName) {
      case PostCategoryName.jobHub:
        return "JobHub";
      case PostCategoryName.houseMate:
        return "HouseMate";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final postCategory =
        ModalRoute.of(context)!.settings.arguments as PostCategoryName;
    log(postCategory.toString());
    return Scaffold(
      appBar: AppBar(
          title: postCategory == PostCategoryName.jobHub
              ? Text("Post to ${categoryNameString(postCategory)}")
              : Text("Post to ${categoryNameString(postCategory)}")),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "What's on your mind?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.image),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () {},
                label: const Text("Publish"),
                icon: const Icon(Icons.send),
              ),
              const Divider(thickness: 8.0)
            ],
          ),
        ),
      ]),
    );
  }
}
