import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
  'm.ctrip.com/html5/you/',
  'm.ctrip.com/webapp/you/foods/',
  'm.ctrip.com/webapp/vacations/tour/list'
];

class WebView extends StatefulWidget {
  final bool? hideAppBar;
  final String? title;
  final bool hideHead;
  final String? statusBarColor;
  final String? url;
  final bool? backForbid;
  const WebView(
      {super.key,
      this.hideAppBar,
      this.title,
      this.statusBarColor,
      this.url,
      this.hideHead = false,
      this.backForbid = false});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String? url;
  late WebViewController controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('ctrip.com')) {
      url = url!.replaceAll("http://", "https://");
    }
    _initWebViewController();
  }

  void _initWebViewController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageStarted: (String url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onPageFinished: (String url) {
          // //页面加载完成之后执行js
          // _handleBackForbid();
          setState(() {
            loadingPercentage = 100;
          });
        },
        onWebResourceError: (WebResourceError error) {},
      ))
      ..loadRequest(Uri.parse(url!));
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? "ffffff";
    Color backButtonColor;
    if (statusBarColorStr == "fffffff") {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            children: [
              _appBar(Color(int.parse('0xff' + statusBarColorStr)),
                  backButtonColor),
              Expanded(
                child: Stack(
                  children: [
                    WebViewWidget(
                      controller: controller,
                    ),
                    loadingPercentage < 100
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container()
                  ],
                ),
              )
            ],
          )),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return widget.hideHead
          ? Container()
          : Container(
              color: backgroundColor,
              height:
                  Theme.of(context).platform == TargetPlatform.iOS ? 34 : 29,
              width: double.infinity,
            );
    }
    ;
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 38, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 24,
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? "",
                    style: TextStyle(color: backButtonColor, fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
