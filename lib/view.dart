import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SView extends StatefulWidget {
  final String url;
  const SView(this.url, {super.key});

  @override
  State<SView> createState() => _ViewState();
}

class _ViewState extends State<SView> {
  final _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff885566),
        title: const Text(
          "Food Reciepe Viewer",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(() {
            _controller.complete(webViewController);
          });
        },
      ),
    );
  }
}
