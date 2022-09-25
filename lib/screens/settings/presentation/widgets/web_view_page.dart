import 'dart:async';
import 'dart:io';
import 'package:agent/resources/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String selectedUrl;

  const WebViewPage({
    required this.title,
    required this.selectedUrl,
  });

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  Future<String> get _url async {
    await Future.delayed(Duration(seconds: 1));
    return widget.selectedUrl;
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(widget.title,
            style: sAppBarTitle.copyWith(
                color: secColor,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: 25,
                  tablet: 40,
                  desktop: 50,
                ))),
      ),
      body: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return FutureBuilder(
              future: _url,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  snapshot.hasData
                      ? Container(
                          color: Colors.transparent,
                          child: WebView(
                            initialUrl: Uri.encodeFull(snapshot.data),
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              if (!_controller.isCompleted)
                                _controller.complete(webViewController);
                            },
                            onWebResourceError: (error) {
                              Center(
                                  child: Text(
                                error.toString(),
                                style: TextStyle(color: Colors.black),
                              ));
                            },
                            onPageStarted: (String page) async {},
                            gestureNavigationEnabled: true,
                          ),
                        )
                      : Center(
                          child: const CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ));
        }),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data!;
        return Row(
          children: <Widget>[
            ///Go back Icon
            // InkWell(
            //   onTap: !webViewReady
            //       ? null
            //       : () async {
            //           if (await controller.canGoForward()) {
            //             await controller.goForward();
            //           } else {
            //             Scaffold.of(context).showSnackBar(
            //               const SnackBar(
            //                   content: Text("No forward history item")),
            //             );
            //             return;
            //           }
            //         },
            //   child: Icon(
            //     Icons.arrow_back_ios,
            //     color: primaryColor,
            //     size: 20.0,
            //   ),
            // ),
            SizedBox(
              width: 20.0,
            ),
            //Go forward icon
            // InkWell(
            //   onTap: !webViewReady
            //       ? null
            //       : () async {
            //           if (await controller.canGoBack()) {
            //             await controller.goBack();
            //           } else {
            //             Scaffold.of(context).showSnackBar(
            //               const SnackBar(content: Text("No back history item")),
            //             );
            //             return;
            //           }
            //         },
            //   child: Icon(
            //     Icons.arrow_forward_ios,
            //     color: primaryColor,
            //     size: 20.0,
            //   ),
            // ),
            const SizedBox(
              width: 20.0,
            ),
            InkWell(
              onTap: !webViewReady
                  ? null
                  : () {
                      controller.reload();
                    },
              child: Icon(
                Icons.replay,
                color: primaryColor,
                size: 20.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        );
      },
    );
  }
}
