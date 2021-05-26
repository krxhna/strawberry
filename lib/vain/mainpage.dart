import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = 'YOUR_DEVICE_ID';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$BannerAd onApplicationExit.'),
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: _bannerAd);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Mobile Ads'),
        actions: <Widget>[
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: FractionalOffset.topCenter,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  alignment: Alignment.center,
                  child: adWidget,
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                )
            ),
          )
        ],
      ),
    );
  }
}