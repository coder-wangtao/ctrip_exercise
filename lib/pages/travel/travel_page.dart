import 'package:ctrip_exercise/model/travel_params_model.dart';
import 'package:ctrip_exercise/model/travel_tab_model.dart';
import 'package:ctrip_exercise/pages/travel/travel_tab_page.dart';
import 'package:ctrip_exercise/request/travel/travel_hot_keyword_dao.dart';
import 'package:ctrip_exercise/request/travel/travel_params_dao.dart';
import 'package:ctrip_exercise/widget/loading_container.dart';
import 'package:flutter/material.dart';

import '../../model/travel_hot_keyword_model.dart';
import '../../request/travel/travel_tab_dao.dart';
import '../../widget/search_bar.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  String defaultText = '试试搜\“花式过五一\”';
  TravelHotKeywordModel? travelHotKeywordModel;
  TravelParamsModel? travelParamsModel;
  TravelTabModel? travelTabModel;
  List<Groups> tabs = [];
  List<HotKeyword>? hotKeyWords = [];
  late TabController _controller;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    _loadParams();
    _loadHotKeyWord();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      isLoading: _loading,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(8, 8, 6, 0),
              decoration: BoxDecoration(color: Colors.white),
              child: SafeArea(
                child: SearchInputBar(
                  searchBarType: SearchBarType.homeLight,
                  inputBoxClick: () {},
                  defaultText: defaultText,
                  speakClick: () {},
                  hintList: hotKeyWords,
                  isUserIcon: true,
                  rightButtonClick: () {},
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 2),
              child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(8, 6, 8, 0),
                indicatorColor: Color(0xff2FCFBB),
                indicatorPadding: EdgeInsets.all(6),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.2,
                labelStyle: TextStyle(fontSize: 18),
                unselectedLabelStyle: TextStyle(fontSize: 15),
                tabs: tabs.map<Tab>((Groups tab) {
                  return Tab(
                    text: tab.name,
                  );
                }).toList(),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.fromLTRB(6, 3, 6, 0),
                child: TabBarView(
                  controller: _controller,
                  children: tabs.map((Groups tab) {
                    return TravelTabPage(
                        travelUrl: travelParamsModel?.url,
                        params: travelParamsModel?.params,
                        groupChannelCode: tab.code);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _loadHotKeyWord() {
    TravelHotKeywordDao.fetch().then((TravelHotKeywordModel model) {
      setState(() {
        travelHotKeywordModel = model;
        hotKeyWords = model?.hotKeyword;
      });
    }).catchError((e) => print(e));
  }

  void _loadParams() {
    TravelParamsDao.fetch().then((TravelParamsModel model) {
      setState(() {
        travelParamsModel = model;
      });
      _loadTab();
    }).catchError((e) {
      print(e);
    });
  }

  void _loadTab() {
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller =
          TabController(length: model.district!.groups!.length, vsync: this);
      setState(() {
        tabs = model!.district!.groups!;
        travelTabModel = model;
        _loading = false;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
