import 'package:flutter/material.dart';

import 'package:strawberry/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strawberry/functions.dart';

import 'package:strawberry/fitness.dart';
import 'package:strawberry/admob_services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:strawberry/home.dart';
import 'Web.dart';
import 'package:strawberry/feed.dart';

class home extends StatefulWidget {
//    MediaQueryData queryData;
//  final coqueryData = MediaQuery.of(context);
  home({Key key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
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

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      
        backgroundColor: maincolor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: maincolor,
          title: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Center(child: Text('Green bags')),
          ),
        ),
        body: ListView(
          children: [
            Container(
              color: maincolor,
              height: _height * 0.08,
              width: _width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // _emoji("📺"),
                    // _emoji("💸"),
                    // _emoji("🛢️"),
                    // _emoji("📈"),
                    _firsticon(Icons.tv),
                    _firsticon(Icons.money),
                    _firsticon(Icons.graphic_eq),
                    _firsticon(Icons.pin_drop),
                    _firsticon(Icons.work),
                  ]),
            ),
            Container(
              height: _height * 0.155,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _secondicon(Icons.dashboard, Colors.amber),
                      _secondicon(Icons.eco_outlined, Colors.red),
                      _secondicon(Icons.kitchen_sharp, Colors.blue),
                      _secondicon(Icons.ac_unit, Colors.green),
                      _secondicon(Icons.next_plan_outlined, Colors.yellow),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _secondicon(Icons.monetization_on, Colors.blue),
                      _secondicon(Icons.gamepad_outlined, Colors.lime),
                      _secondicon(Icons.gradient_sharp, Colors.deepPurple),
                      _secondicon(Icons.accessibility_new, Colors.red),
                      _secondicon(Icons.elevator_rounded, Colors.indigo),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
            Container(
              color: Colors.white,
              height: _height * 0.07,
              child: AdWidget(key: UniqueKey(), ad: ban_ad..load()),
            ),
            Container(
              color: Colors.white,
              height: _height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: Text("tag1")),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: Text("tag1")),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: Text("tag1")),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: Text("tag1")),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: Text("tag1")),
                ],
              ),
            ),
            _feed(_height * 0.8)
          ],
        ));
  }
}

_firsticon(Icon1) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Icon(
      Icon1,
      color: Colors.white,
    ),
  );
}

_secondicon(Icon1, color) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Icon(
      Icon1,
      color: color,
      size: 30,
    ),
  );
}

_feed(heightt) {
  return Container(
    color: Colors.white,
    height: heightt,
    width: 200,
    child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("articles").snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return !snapshot.hasData
            ? Text('PLease Wait')
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return _newstile(
                      data['title'], data['urlToImage'], data['url'], context);
                },
              );
      },
    ),
  );
}

_newstile(Title, img_url, url, context) {
  return GestureDetector(
    onTap: () {
      interstitialAd.load();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Web(
                  url: url,
                )),
      );
      interstitialAd.show();
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Container(
          child: Row(
            children: [
              Container(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Title),
                  )),
              Container(
                  color: Colors.white,
                  height: 90,
                  width: 90,
                  child: Image.network(img_url))
            ],
          ),
          height: 120.00,
          width: 319.00,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
            borderRadius: BorderRadius.circular(20.00),
          ),
        )),
  );
}

_emoji(data) {
  return Column(
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            data,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      Text(
        "wassup",
        style: TextStyle(color: Colors.white),
      )
    ],
  );
}
