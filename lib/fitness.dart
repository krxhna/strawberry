import 'package:flutter/material.dart';
import 'package:strawberry/home.dart';
import 'package:strawberry/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strawberry/functions.dart';
import 'package:strawberry/home.dart';
import 'package:strawberry/fitness.dart';

var selectedlist = [];

//////////////

class fitness extends StatefulWidget {
  fitness({Key key}) : super(key: key);

  @override
  _fitnessState createState() => _fitnessState();
}

//////////////////////////////////
///
///
var sel_list = ['blue'];
var streaming = stream();
var colors = ['red', 'orange', 'yellow'];

class _fitnessState extends State<fitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(height: 300, child: streaming),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: colors.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      print("hagaga");
                      streaming = stream(
                        list: sel_list,
                      );
                    });
                  },
                  child: Container(
                    child: chipwidget(
                      chipname: colors[index],
                      list: sel_list,
                    ),
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                streaming = stream(
                  list: sel_list,
                );
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            streaming = stream(
              list: ['red'],
            );
          });
        },
      ),
    );
  }
}

///

class stream extends StatefulWidget {
  final list;
  stream({Key key, this.list}) : super(key: key);

  @override
  _streamState createState() => _streamState();
}

class _streamState extends State<stream> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // circle_left(-18.0, -90.0),
        // circle_left(400.0, -70.0),
        // circle_left(580.0, 350.0),
        // circle_left(200.0, 300.0),
        Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("tags")
                .where('array', arrayContainsAny: widget.list)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return Center(child: Text(data['tags']));
                      },
                    );
            },
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: Text(
        //     "Hello. ",
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        //   ),
        // )
      ],
    );
  }
}

/////////////////////
///
class chipwidget extends StatefulWidget {
  final String chipname;
  final List list;
  chipwidget({Key key, this.chipname, this.list}) : super(key: key);

  @override
  _chipwidgetState createState() => _chipwidgetState();
}

class _chipwidgetState extends State<chipwidget> {
  var _isselected = false;
  var textcolor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputChip(
        selected: _isselected,
        backgroundColor: Colors.black,
        label: Text(
          widget.chipname,
          style: TextStyle(color: textcolor),
        ),
        onSelected: (isselcted) {
          setState(() {
            widget.list.insert(0, widget.chipname);
            textcolor = Colors.black;
            _isselected = true;
            print(widget.list);
          });
        },
        selectedColor: Colors.amber,
        onDeleted: () {
          setState(() {
            widget.list.remove(widget.chipname);
            textcolor = Colors.white;
            _isselected = false;
            print(widget.list);
            stream();
          });
        },
      ),
    );
  }
}

_chip(chipname) {
  var _isselected = false;
  return InputChip(
    selected: _isselected,
    backgroundColor: Colors.black,
    label: Text(
      chipname,
      style: TextStyle(),
    ),
    onSelected: (isselcted) {
      _isselected = true;
      selectedlist.insert(0, chipname);
    },
    selectedColor: Colors.amber,
    onDeleted: () {
      _isselected = false;
      selectedlist.remove(chipname);
    },
  );
}
