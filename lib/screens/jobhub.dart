import 'package:flutter/material.dart';
import 'package:thsyd/models/post_category.dart';
import 'package:thsyd/screens/create_post.dart';

class JobHub extends StatelessWidget {
  const JobHub({super.key});

  static const routeName = "/jobhub";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CreatePost.routeName,
            arguments: PostCategoryName.jobHub,
          );
        },
        icon: const Icon(Icons.post_add),
        label: const Text("Create Post"),
      ),
    );
  }
}
