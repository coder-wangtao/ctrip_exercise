import 'package:ctrip_exercise/model/common_model.dart';
import 'package:ctrip_exercise/model/home_model.dart';
import 'package:ctrip_exercise/pages/home/widget/banner_widget.dart';
import 'package:ctrip_exercise/pages/home/widget/grid_nav_widget.dart';
import 'package:ctrip_exercise/request/home/home_request.dart';
import 'package:flutter/material.dart';

import '../../widget/loading_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  bool _isLoading = true;
  List<CommonModel>? bannerList = [];
  List<CommonModel>? localNavList = [];
  List<CommonModel>? subNavList = [];
  late GridNavModel? gridNavModel;
  late SalesBoxModel? salesBoxModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.fromLTRB(14, 20, 0, 0),
            height: 86,
            decoration: BoxDecoration(color: Colors.red, boxShadow: [
              BoxShadow(
                  color:
                      appBarAlpha == 1.0 ? Colors.black12 : Colors.transparent,
                  offset: Offset(10, 3), // 阴影向右偏移10个单位，向下偏移3个单位
                  blurRadius: 6, // 阴影边缘模糊6个单位
                  spreadRadius: 0.6 // 阴影扩散0.6个单位
                  )
            ]),
            child: Center(
              child: Text("111"),
            ),
          ),
        ),
        Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafc),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView(
                    children: [
                      BannerWidget(
                        bannerList: bannerList,
                        localNavList: localNavList,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [GridNavWidget()],
                        ),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      ),
                      ListTile(
                        title: Text("1"),
                      )
                    ],
                  ),
                )),
            _appBar
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel homeModel = await HomeRequest.fetch();
      setState(() {
        bannerList = homeModel.bannerList;
        localNavList = homeModel.localNavList;
        gridNavModel = homeModel.gridNav;
        subNavList = homeModel.subNavList;
        salesBoxModel = homeModel.salesBox;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
