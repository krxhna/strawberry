import 'package:flutter/material.dart';
import 'package:strawberry/home.dart';
import 'package:strawberry/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strawberry/functions.dart';
import 'package:strawberry/home.dart';

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

class _feedState extends State<feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => Home()),
      //       );
      //     },
      //     child: update()),
      body: Stack(
        children: [
          circle_left(-18.0, -90.0),
          circle_left(400.0, -70.0),
          circle_left(580.0, 350.0),
          circle_left(200.0, 300.0),
          StreamBuilder(
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
        ],
      ),
    );
  }
}
