import 'package:flutter/material.dart';

import 'navigator/tab_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //设置状态栏的颜色
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FCtrip', //运行在后台展示的上部分标题
      //主题
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        splashFactory: NoSplash.splashFactory, // 全局移除水波纹效果
        highlightColor: Colors.transparent, // 全局移除点击高亮效果
      ),
      home: TabNavigator(),
    );
  }
}
