import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strawberry/landlandpage.dart';
import 'package:strawberry/functions.dart';
import 'dart:math';

final _random = new Random();

class signuppage extends StatefulWidget {
  signuppage({Key key}) : super(key: key);

  @override
  _signuppageState createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  int randomNumber1 = Random().nextInt(10);
  int randomNumber2 = Random().nextInt(10);
  int randomNumber3 = Random().nextInt(10);
  int randomNumber4 = Random().nextInt(10);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
    name,
    email,
    uid,
    password,
  ) {
    return users
        .doc(email)
        .set({
          'name': name,
          'email': email,
          "uid": uid,
          "password": password,
          "tag": randomNumber1.toString() +
              randomNumber2.toString() +
              randomNumber3.toString() +
              randomNumber4.toString(),
          "username": name +
              "#" +
              randomNumber1.toString() +
              randomNumber2.toString() +
              randomNumber3.toString() +
              randomNumber4.toString()
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUsernames(email) {
    return users
        .doc(email)
        .set({
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  TextEditingController email_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();
  TextEditingController comfrm_pass_ctrl = TextEditingController();
  TextEditingController name_contrl = TextEditingController();

  Future<void> _signupEmail(email, password, context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 300,
                child: Column(
                  children: [
                    Text("suceess!🎉"),
                    Text(FirebaseAuth.instance.currentUser.email.toString()),
                    MaterialButton(
                        color: maincolor,
                        child: Text("Countinue!!"),
                        onPressed: () async {
                          await addUser(
                            name_contrl.text,
                            FirebaseAuth.instance.currentUser.email.toString(),
                            FirebaseAuth.instance.currentUser.uid.toString(),
                            password,
                          );

                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      landlandpage()));
                        })
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          });

      // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: maincolor,
          title: Text(
            "signup",
            style: TextStyle(color: text_color),
          )),
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            children: [
              textform(name_contrl, "username", false),
              textform(email_ctrl, "email", false),
              textform(password_ctrl, "password", true),
              textform(comfrm_pass_ctrl, "retype password", true),
              // Text(conform),
              RaisedButton(
                  elevation: 0,
                  color: maincolor,
                  child: Text('Sign up'),
                  onPressed: () {
                    _signupEmail(email_ctrl.text, password_ctrl.text, context);
                    email_ctrl.clear();
                    password_ctrl.clear();

                    comfrm_pass_ctrl.clear();
                  }),

              RaisedButton(
                  splashColor: maincolor,
                  elevation: 0,
                  color: Colors.white,
                  child: Text("sign in"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),

              // RaisedButton(onPressed: () {
              //   addUser("jfkdajf", "dkfkajdf");
              // })
            ],
          ),
        ),
      ),
    );
  }
}
