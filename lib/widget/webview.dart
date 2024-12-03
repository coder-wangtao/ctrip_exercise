import 'package:flutter/material.dart';

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
  const WebView(
      {super.key, this.hideAppBar, this.title, this.hideHead = false});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
