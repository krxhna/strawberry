import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class fitness extends StatefulWidget {
  fitness({Key key}) : super(key: key);

  @override
  _fitnessState createState() => _fitnessState();
}

class _fitnessState extends State<fitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('fitnessS'),
    );
  }
}
