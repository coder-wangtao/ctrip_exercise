import 'package:ctrip_exercise/pages/destination/destination_page.dart';
import 'package:ctrip_exercise/pages/home/home_page.dart';
import 'package:ctrip_exercise/pages/my/my_page.dart';
import 'package:ctrip_exercise/pages/travel/travel_page.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late PageController _controller;
  int _currentIndex = 0;
  final _defaultColor = Color(0xff8a8a8a);
  final _activeColor = Color(0xff50b4ed);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: PageView(
          controller: _controller,
          children: <Widget>[
            HomePage(),
            DestinationPage(),
            TravelPage(),
            MyPage()
          ],
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.animateToPage(index,
                duration: Duration(microseconds: 260), curve: Curves.easeIn);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: _defaultColor,
          selectedItemColor: _activeColor,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/xiecheng.png",
                width: 22,
                height: 22,
              ),
              activeIcon: Image.asset(
                "images/xiecheng_active.png",
                width: 22,
                height: 22,
              ),
              label: "首页",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/mude.png",
                width: 24,
                height: 24,
              ),
              activeIcon: Image.asset(
                "images/mude_active.png",
                width: 24,
                height: 24,
              ),
              label: "目的地",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/lvpai.png",
                width: 23,
                height: 23,
              ),
              activeIcon: Image.asset(
                "images/lvpai_active.png",
                width: 23,
                height: 23,
              ),
              label: "旅拍",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/wode.png",
                width: 23,
                height: 23,
              ),
              activeIcon: Image.asset(
                "images/wode_active.png",
                width: 23,
                height: 23,
              ),
              label: "我的",
            )
          ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
