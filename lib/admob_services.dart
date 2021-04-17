import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get BannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createbannerad() {
    BannerAd ad = new BannerAd(
        size: AdSize.largeBanner,
        adUnitId: BannerAdUnitId,
        listener: AdListener(
            onAdLoaded: (Ad ad) => print('ad loaded'),
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            },
            onAdOpened: (Ad ad) => print('adopened'),
            onAdClosed: (Ad ad) => print('onadclose')),
        request: AdRequest());
  }
}
