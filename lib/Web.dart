import 'dart:async';

import 'package:flutter/material.dart';
import 'package:strawberry/fitness.dart';
import 'package:strawberry/functions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:math';

Random random = new Random();

class Web extends StatefulWidget {
  final String url;
  Web({Key key, this.url}) : super(key: key);

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(colors: [maincolor, secondary_color])),
          // ),
          elevation: 0,
          title: Text(
            widget.url,
            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
          backgroundColor: maincolor,
          // backgroundColor: ran_colors[random.nextInt(ran_colors.length)],
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
