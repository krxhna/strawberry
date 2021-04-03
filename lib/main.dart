// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strawberry/feed.dart';
import 'package:strawberry/functions.dart';

Future<void> main() async {
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Your title',
    home: feed(),
  ));
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    print("lol");
                    addUser('hello');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser(nah) {
  return users
      .doc(nah)
      .set({'full_name': "Mary Jane", 'age': 18})
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
