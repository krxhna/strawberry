import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strawberry/chatbox.dart';
import 'package:strawberry/functions.dart';
import 'package:strawberry/landlandpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strawberry/vain/fitness.dart';
import 'chat.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:strawberry/profile.dart';

class profile extends StatefulWidget {
  profile({Key key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  getActual(doc) {
    var data = FirebaseFirestore.instance.collection("users").doc(doc).get();
    return "lol";
  }

  var list_er = getList();

  update(name) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        DocumentSnapshot data = snapshot.data.docs[name];
        return !snapshot.hasData ? Text('PLease Wait') : Text(data['price']);
      },
    );
  }

  Stream<DocumentSnapshot> getUserStream() async* {
    final uid = FirebaseAuth.instance.currentUser.email.toString();
    yield* FirebaseFirestore.instance.doc("users/$uid").snapshots();
  }

  stream_builder(section, height) {
    return Container(
      height: height * 0.02,
      child: StreamBuilder(
        stream: getUserStream(),
        initialData: "loading..",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return !snapshot.hasData
              ? Text('PLease Wait')
              : Container(
                  child: Text(snapshot.data[section]),
                );
        },
      ),
    );
  }

  stream_builder_text(section, height) {
    return Container(
      height: height * 0.1,
      child: StreamBuilder(
        stream: getUserStream(),
        initialData: "loading..",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return !snapshot.hasData
              ? Text('PLease Wait')
              : Container(
                  child: Text(
                    snapshot.data[section],
                    style: TextStyle(fontSize: 30),
                  ),
                );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var iseditable = false;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: maincolor,
        onPressed: () {
          getList();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (BuildContext context) => chat()));
        },
      ),
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Row(
          children: [
            Text("op"),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: [
                IconButton(
                    icon: Icon(LineIcons.addressBook),
                    onPressed: () {
                      print("awesome platform to share code and ideas");
                    }),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: text_color,
                  ),
                ),
              ],
            ),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            stream_builder_text("username", height),
            Column(
              children: [
                Container(
                  color: maincolor,
                  width: width * 0.8,
                  height: height * 0.05,
                  child: TextField(
                    decoration: InputDecoration(hintText: "op"),
                    enabled: iseditable,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // s
                    // height: height * 0.5,
                    width: width,
                    child: FutureBuilder(
                      future: getList(),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return Center(
                            child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          chatbox(
                                                            chatroomid: snapshot
                                                                .data[index],
                                                          )));
                                            },
                                            child: Container(
                                                height: height * 0.1,
                                                width: width * 0.9,
                                                color: maincolor,
                                                child:
                                                    Text(snapshot.data[index])),
                                          ),
                                        )),
                                  );
                                }),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> getList() async {
  var firestore = FirebaseFirestore.instance;

  DocumentReference docRef = firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.email.toString());

  return docRef.get().then((datasnapshot) {
    if (datasnapshot.exists) {
      List<dynamic> info = datasnapshot.data()['chatrooms'].toList();
      print('#');
      print(info);
      print(info.length);
      return info;
    }
  });
}
