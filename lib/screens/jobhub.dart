import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:thsyd/models/post.dart';
import 'package:thsyd/models/post_category.dart';
import 'package:thsyd/repositories/post_repository.dart';
import 'package:thsyd/screens/create_post.dart';

class JobHub extends StatefulWidget {
  const JobHub({super.key});

  static const routeName = "/jobhub";

  @override
  State<JobHub> createState() => _JobHubState();
}

class _JobHubState extends State<JobHub> {
  BannerAd? _bannerAd;
  bool isAdLoaded = false;
  final adUnitId = Platform.isAndroid
      ? "ca-app-pub-6272836017246600/1918497963"
      : 'ca-app-pub-3940256099942544/2934735716';

  void loadAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            isAdLoaded = true;
          });
          log("$ad loaded.");
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          log("Banner failed to loaded: $err");
        },
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  String timeAgoFromTimestamp(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = now - timestamp;

    if (difference < 60 * 1000) {
      // Less than a minute ago
      return 'a few seconds ago';
    } else if (difference < 60 * 60 * 1000) {
      // Less than an hour ago
      final minutes = (difference / (60 * 1000)).round();
      return '$minutes minute${minutes != 1 ? 's' : ''} ago';
    } else if (difference < 24 * 60 * 60 * 1000) {
      // Less than a day ago
      final hours = (difference / (60 * 60 * 1000)).round();
      return '$hours hour${hours != 1 ? 's' : ''} ago';
    } else {
      // More than a day ago
      final days = (difference / (24 * 60 * 60 * 1000)).round();
      return '$days day${days != 1 ? 's' : ''} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _bannerAd != null
                  ? SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    )
                  : SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
              StreamBuilder<List<Post>>(
                stream: context.read<PostRepository>().jobhubs,
                builder: (context, snapshot) {
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

                  List<Post> postList = snapshot.data ?? [];

                  if (postList.isEmpty) {
                    return const Center(
                      child: Text('No post available.'),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Image.network(
                                          postList[index].ownerPhotoURL),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        postList[index].owner,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      Text(
                                        timeAgoFromTimestamp(
                                          postList[index]
                                              .createdAt
                                              .millisecondsSinceEpoch,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Colors.black38,
                                            ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      postList[index].content,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 8.0);
                    },
                    itemCount: postList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  );
                },
              ),
            ],
          ),
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
