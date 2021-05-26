import 'package:flutter/material.dart';
import 'package:strawberry/functions.dart';
import 'package:strawberry/landlandpage.dart';
import 'package:strawberry/vain/fitness.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chat extends StatefulWidget {
  chat({Key key}) : super(key: key);

  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  var search_Ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Container(
            color: maincolor,
            height: height * 0.3,
            width: width,
            child: Column(
              children: [
                textform(search_Ctrl, "search", false),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

searchstream(name) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("users")
        .where("email" "array-contains-any"[name])
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      DocumentSnapshot data = snapshot.data.docs[name];
      return !snapshot.hasData ? Text('PLease Wait') : Text(data['price']);
    },
  );
}

searchcarad() {
  return Card(
    child: Text("lol"),
  );
}

onpressdadd() {
  //create chat room

  //addchatroom to our lis tof chatroom

  //addchatroom to their list of chatrooms
}
