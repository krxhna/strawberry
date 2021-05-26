import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:strawberry/vain/fitness.dart';
import 'package:strawberry/functions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strawberry/vain/landingpage.dart';
// import 'auth/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strawberry/feed.dart';
import 'package:strawberry/landlandpage.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    update(email1) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          DocumentSnapshot data = snapshot.data.docs[email1];
          return !snapshot.hasData ? Text('PLease Wait') : Text(data['uid']);
        },
      );
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Navigator.push(context, _createRoute());
      // }),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home),
            Icon(Icons.tv),
            Icon(Icons.add),
            Icon(Icons.chat_bubble),
            Icon(Icons.account_box_rounded),
          ],
        ),
        color: maincolor,
        height: 50,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: maincolor,
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: maincolor,
                maxRadius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "lol",
                // FirebaseAuth.instance.currentUser.email.toString(),
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => feed(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
