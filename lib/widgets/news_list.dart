import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thsyd/models/news.dart';
import 'package:thsyd/repositories/news_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "News",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: StreamBuilder<List<News>>(
            stream: context.read<NewsRepository>().news,
            builder:
                (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<News> newsList = snapshot.data ?? [];

              if (newsList.isEmpty) {
                return const Center(
                  child: Text('No news available.'),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        launchUrl(Uri.parse(newsList[index].url));
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Image.network(
                              newsList[index].urlToImage,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                              child: Text(
                                newsList[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                newsList[index].description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Column(
                      children: [
                        SizedBox(height: 8.0),
                        Divider(),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
