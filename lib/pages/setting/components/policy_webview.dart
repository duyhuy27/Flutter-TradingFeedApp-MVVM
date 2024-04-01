import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyWebview extends StatefulWidget {
  String url;
  PolicyWebview({super.key, required this.url});

  @override
  State<PolicyWebview> createState() => _PolicyWebviewState();
}

class _PolicyWebviewState extends State<PolicyWebview> {
  WebViewController controller = WebViewController();
  var loadingPercentage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.url);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Privacy policy',
            style: GoogleFonts.openSans(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              WebViewWidget(
                controller: controller,
              ),
              if (loadingPercentage < 100)
                LinearProgressIndicator(
                  value: loadingPercentage / 100,
                )
            ],
          ),
        ));
  }
}
