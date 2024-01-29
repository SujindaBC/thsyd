import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thsyd/widgets/top_story.dart';
import 'package:thsyd/widgets/wise_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = "/homeview";

  Future<String> getDate() async {
    final DateTime currentTime = DateTime.now();
    final String formatedDate = DateFormat.MMMMd().format(currentTime);
    return formatedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "THSYD ",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              initialData: "Loading...",
              builder: (context, snapshot) {
                return Text(
                  "${snapshot.data}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)
                      .copyWith(color: Colors.black45),
                );
              },
              future: getDate(),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: WiseWidget(),
            ),
            SizedBox(height: 12.0),
            TopStory(),
          ],
        ),
      ),
    );
  }
}
