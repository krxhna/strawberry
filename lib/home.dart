import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

_text(text) {
  return Padding(
    padding: const EdgeInsets.only(left: 100.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

final Completer<WebViewController> _controller = Completer<WebViewController>();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Container(
            height: 300,
            width: 300,
            color: Colors.deepPurpleAccent,
            child: WebView(
              initialUrl:
                  "https://in.tradingview.com/chart/?symbol=NSE%3ANIFTY",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            )),
      ),
    );
  }
}
