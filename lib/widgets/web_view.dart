import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestWebViewPage extends StatefulWidget {
  // final String url;

  TestWebViewPage();

  @override
  _TestWebViewPageState createState() => _TestWebViewPageState();
}

class _TestWebViewPageState extends State<TestWebViewPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://www.youtube.com'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sokoni.com'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
