import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thsyd/blocs/auth_bloc/auth_bloc.dart';
import 'package:thsyd/models/post.dart';
import 'package:thsyd/models/post_category.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  static const routeName = "create-post";

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _contentController = TextEditingController();

  Future<void> createPost(Post post, PostCategoryName postCategoryName) async {
    CollectionReference posts =
        FirebaseFirestore.instance.collection(postCategoryName.name);
    try {
      final DocumentReference res = await posts.add(post.toMap());
      log(res.toString());
    } catch (error) {
      log("$error");
    }
  }

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: _contentController,
            maxLines: 3,
            decoration: const InputDecoration(
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
                onPressed: () {
                  createPost(
                    Post(
                      owner: context.read<AuthBloc>().state.user!.displayName ??
                          "",
                      ownerPhotoURL:
                          context.read<AuthBloc>().state.user?.photoURL ?? "",
                      content: _contentController.value.text.trim(),
                      createdAt: Timestamp.fromDate(DateTime.now()),
                      updatedAt: Timestamp.fromDate(DateTime.now()),
                      postCategory: postCategory.name,
                    ),
                    postCategory,
                  ).then((value) {
                    Navigator.of(context).pop();
                  });
                },
                label: const Text("Publish 2 coins"),
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
