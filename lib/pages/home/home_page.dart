import 'package:ctrip_exercise/model/common_model.dart';
import 'package:ctrip_exercise/model/home_model.dart';
import 'package:ctrip_exercise/pages/home/widget/banner_widget.dart';
import 'package:ctrip_exercise/pages/home/widget/grid_nav_widget.dart';
import 'package:ctrip_exercise/pages/home/widget/sales_box_widget.dart';
import 'package:ctrip_exercise/pages/home/widget/sub_nav_widget.dart';
import 'package:ctrip_exercise/request/home/home_request.dart';
import 'package:ctrip_exercise/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widget/loading_container.dart';

const SEARCH_BAR_DEFAULT_TEXT = '目的地 | 酒店 | 景点 | 航班号';
const APPBAR_SCROLL_OFFSET = 100;

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
  GridNavModel? gridNavModel;
  SalesBoxModel? salesBoxModel;

  @override
  void initState() {
    // TODO: implement initState]
    _handleRefresh();
    super.initState();
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
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                      color: appBarAlpha == 1.0
                          ? Colors.black12
                          : Colors.transparent,
                      offset: Offset(10, 3), // 阴影向右偏移10个单位，向下偏移3个单位
                      blurRadius: 6, // 阴影边缘模糊6个单位
                      spreadRadius: 0.6 // 阴影扩散0.6个单位
                      )
                ]),
            child: SearchInputBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: () {},
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
              speakClick: () {},
              rightButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
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
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    //滚动发生时触发 && 0 表示这是根级别的滚动通知,确保你只处理主视图的滚动，而不去处理嵌套视图的滚动。
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      //scrollNotification.metrics.pixels 表示当前滚动视图的垂直滚动位置（单位是像素）。
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return true;
                  },
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
                            children: [
                              GridNavWidget(),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              SubNavWidget(
                                subNavList: subNavList,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              SalesBoxWidget(salesBoxModel: salesBoxModel)
                            ],
                          ),
                        ),
                      ],
                    ),
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

  void _onScroll(double offset) {
    if (offset.toInt() == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
}
