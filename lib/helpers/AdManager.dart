import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  AdManager._();

  static final AdManager instance = AdManager._();

  late BannerAd _ad;

  BannerAd get ad => _ad;

  Future<void> loadAd() async {
    _ad = BannerAd(
      adUnitId: "ca-app-pub-6272836017246600/8049857709",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (Ad ad) {
        log(ad.toString());
      }, onAdFailedToLoad: (ad, error) {
        log(error.toString());
        ad.dispose();
      }),
    );

    await _ad.load();
  }
}
