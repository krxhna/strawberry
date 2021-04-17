import 'package:flutter/material.dart';
import 'package:strawberry/home.dart';
import 'package:strawberry/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strawberry/functions.dart';
import 'package:strawberry/home.dart';
import 'package:strawberry/fitness.dart';
import 'package:strawberry/admob_services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:strawberry/ads.dart';

//data
//
//
//
class article {
  String img_url;
  String title;
  String description;

  article(img_url, title, description) {
    this.img_url = img_url;
    this.title = title;
    this.description = description;
  }
}

class feed extends StatefulWidget {
  feed({Key key}) : super(key: key);

  @override
  _feedState createState() => _feedState();
}

update() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("data").snapshots(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      DocumentSnapshot data = snapshot.data.docs[1];
      return !snapshot.hasData ? Text('PLease Wait') : Text(data['price']);
    },
  );
}

BannerAd ban_ad = BannerAd(
    size: AdSize.banner,
    adUnitId: 'ca-app-pub-5524841399774996/4589938318',
    listener: AdListener(
        onAdLoaded: (Ad ad) => print('ad loaded'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('adopened'),
        onAdClosed: (Ad ad) => print('onadclose')),
    request: AdRequest());

InterstitialAd interstitialAd = InterstitialAd(
  // adUnitId: 'ca-app-pub-5524841399774996/6970868692',
  //test
  adUnitId: 'ca-app-pub-3940256099942544/1033173712',
  request: AdRequest(),
  listener: AdListener(
    onAdClosed: (ad) {
      print("Closed Ad");
    },
    onAdOpened: (ad) {
      print("Opened Ad");
    },
  ),
);

class _feedState extends State<feed> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _interstitialAd.load();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: AdWidget(key: UniqueKey(), ad: ban_ad..load()),
      ),
      // backgroundColor: Color(0xff211E2D),
      // appBar: AppBar(),
      // backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       interstitialAd.load();
      //       interstitialAd.show();
      //       // interstitialAd.dispose();
      //       // Navigator.push(
      //       //   context,
      //       //   MaterialPageRoute(builder: (context) => adspage()),
      //       // );
      //     },
      //     child: update()),
      body: Stack(
        children: [
          circle_left(-18.0, -90.0),
          circle_left(400.0, -70.0),
          circle_left(580.0, 350.0),
          circle_left(200.0, 300.0),
          Container(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("articles").snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return !snapshot.hasData
                    ? Text('PLease Wait')
                    : PageView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];
                          return cont(data['urlToImage'], data['title'],
                              data['description'], data['url'], context);
                        },
                      );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Text(
          //     "Hello. ",
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          //   ),
          // )
        ],
      ),
    );
  }
}
