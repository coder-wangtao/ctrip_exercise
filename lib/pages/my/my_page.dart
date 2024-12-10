import 'package:flutter/material.dart';

import '../../widget/webview.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      url: 'https://m.ctrip.com/webapp/myctrip/',
      hideAppBar: true,
      backForbid: true,
      hideHead: true,
    );
  }
}
