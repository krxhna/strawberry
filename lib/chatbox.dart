import 'package:flutter/material.dart';
import 'package:strawberry/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class chatbox extends StatefulWidget {
  String chatroomid;
  chatbox({Key key, this.chatroomid}) : super(key: key);

  @override
  _chatboxState createState() => _chatboxState();
}

class _chatboxState extends State<chatbox> {
  @override
  Widget build(BuildContext context) {
    var roomid = widget.chatroomid;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: maincolor,
            title: Text(
              widget.chatroomid,
              style: TextStyle(color: text_color),
            )),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms/$roomid/messagess")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  : PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return Text(data["message"]);
                      },
                    );
            },
          ),
        ));
  }
}

chat_bubble(text1) {
  return Container(
    child: Text("text1"),
  );
}
