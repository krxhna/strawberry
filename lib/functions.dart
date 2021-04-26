import 'package:flutter/material.dart';
import 'package:strawberry/fitness.dart';
import 'Web.dart';
import 'package:strawberry/feed.dart';

// const maincolor = Color(0xff12c2e9);
// const secondary_color = Color(0xffc471ed);
const maincolor = Color(0xff00dc64);
const secondary_color = Color(0xff00dc64);

var ran_colors = [Colors.amber, Colors.red, Colors.green, Colors.blue];

dec_container(Color1, Color2) {
  return Stack(
    children: [
      Container(
        height: 170,
        width: 170,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color1, Color2])),
      ),
    ],
  );
}

circle_left(top, left, Color1, Color2) {
  return Positioned(
    top: top,
    left: left,
    child: Wrap(
      children: [
        dec_container(Color1, Color2),
      ],
    ),
  );
}

circle_right(top, left, Color1, Color2) {
  return Positioned(
    top: top,
    left: left,
    child: Wrap(
      children: [
        dec_container(Color1, Color2),
      ],
    ),
  );
}

cont(img_url, title, description, url, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40, bottom: 40),
    child: Container(
      child: Wrap(
        children: [
          Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // gradient:
                    //     LinearGradient(colors: [maincolor, secondary_color])
                  ),
                  child: Image.network(img_url)),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
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
                    child: Text(
                      "read more..",
                      style: TextStyle(
                          color: maincolor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      height: 500.00,
      width: 327.00,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.3)
        ]),
        // border: Border.all(
        //     // color: Colors.red[500],
        //     ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // color: Color(0xffffffff),

        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
    ),
  );
}
