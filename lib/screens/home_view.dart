import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:thsyd/widgets/news_list.dart';
// import 'package:thsyd/widgets/top_story.dart';
import 'package:thsyd/widgets/wise_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = "/homeview";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late BannerAd? _bannerAd;
  bool isAdLoaded = false;
  final adUnitId = Platform.isAndroid
      ? "ca-app-pub-6272836017246600/8049857709"
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
              // TopStory(),
              NewsList(),
            ],
          ),
        ),
        bottomNavigationBar: isAdLoaded
            ? SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(
                  ad: _bannerAd!,
                ),
              )
            : const SizedBox());
  }
}
