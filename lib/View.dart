import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SView extends StatefulWidget {
  String url;
  SView(this.url);

  @override
  State<SView> createState() => _ViewState();
}

class _ViewState extends State<SView> {
 late String finalurl;
  final Completer<WebViewController> controller=Completer<WebViewController>();
  @override
  void initState() {
    if(widget.url.toString().contains("http://")){
      finalurl=widget.url.toString().replaceAll("http://", "https://");
    }
    else{
      finalurl=widget.url;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff885566),
        title: Text("Food Reciepe Viewer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

      ),
      body:Container(

            child: WebView(
              initialUrl: finalurl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController){
                setState(() {
                  controller.complete(webViewController);
                });
              },
            ),

      ),
    );
  }


}


