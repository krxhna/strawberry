import 'package:flutter/material.dart';
import 'Web.dart';

const maincolor = Colors.red;
const secondary_color = Colors.amber;

dec_container() {
  return Container(
    height: 170,
    width: 170,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [maincolor, secondary_color])),
  );
}

circle_left(top, left) {
  return Positioned(
    top: top,
    left: left,
    child: Wrap(
      children: [
        dec_container(),
      ],
    ),
  );
}

circle_right(top, left) {
  return Positioned(
    top: top,
    left: left,
    child: Wrap(
      children: [
        dec_container(),
      ],
    ),
  );
}

cont(img_url, title, description, url, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40, bottom: 40),
    child: new Container(
      child: Wrap(
        children: [
          Column(
            children: [
              Container(
                  height: 250,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [maincolor, secondary_color])),
                  child: Image.network(img_url)),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 150,
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
                  height: 150,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Web(
                                  url: url,
                                )),
                      );
                    },
                    child: Chip(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      label: Text(
                        "read more..",
                        style: TextStyle(
                            color: maincolor, fontWeight: FontWeight.bold),
                      ),
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
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
      ),
    ),
  );
}
