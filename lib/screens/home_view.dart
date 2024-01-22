import 'package:flutter/material.dart';
import 'package:thsyd/widgets/wise_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = "/homeview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("THSYD"),
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WiseWidget()
            )
          ],
        ),
      ),
    );
  }
}
