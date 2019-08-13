import 'package:flutter/material.dart';
import 'package:fun_refresh/components/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  final Map args;
  Browser({@required this.args});
  @override
  createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: widget.args['title'],
        centerTitle: true,
        context: context,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: WebView(
        initialUrl: widget.args['link'],
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
