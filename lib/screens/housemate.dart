import 'package:flutter/material.dart';
import 'package:thsyd/models/post_category.dart';
import 'package:thsyd/screens/create_post.dart';

class HouseMate extends StatelessWidget {
  const HouseMate({super.key});

  static const routeName = "/housemate";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CreatePost.routeName,
            arguments: PostCategoryName.houseMate,
          );
        },
        icon: const Icon(Icons.post_add),
        label: const Text("Create Post"),
      ),
    );
  }
}
