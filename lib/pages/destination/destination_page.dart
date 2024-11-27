import 'package:ctrip_exercise/model/destination_model.dart';
import 'package:ctrip_exercise/widget/loading_container.dart';
import 'package:ctrip_exercise/widget/search_bar.dart';
import 'package:flutter/material.dart';

import '../../plugin/vertical_tab_view.dart';
import '../../request/destination/destination_request.dart';

const DEFAULT_TEXT = '目的地 | 主题 | 关键字';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage>
    with AutomaticKeepAliveClientMixin {
  late DestinationModel destinationModel;
  late List<NavigationPopList> navigationList;
  List<Tab> tabs = [];
  List<Widget> tabPages = [];

  @override
  void initState() {
    // TODO: implement initState
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingContainer(
        isLoading: false,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Theme.of(context).platform == TargetPlatform.iOS
                      ? 92
                      : 86),
              child: VerticalTabView(
                tabsWidth: 88,
                tabsElevation: 0,
                selectedTabBackgroundColor: Colors.white,
                backgroundColor: Colors.white,
                tabTextStyle: TextStyle(
                  height: 60,
                  color: Color(0xff333333),
                ),
                tabs: tabs,
                contents: [
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab'),
                  Text('Tab')
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 6, 6, 10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(10, 0, 0, 0),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(1, 1))
              ]),
              child: SafeArea(
                child: SearchInputBar(
                  searchBarType: SearchBarType.homeLight,
                  inputBoxClick: () {},
                  defaultText: DEFAULT_TEXT,
                  speakClick: () {},
                  rightButtonClick: () {},
                  rightIcon: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _loadData() {
    DestinationDao.fetch().then((DestinationModel model) {
      print(model);
      setState(() {
        destinationModel = model;
        navigationList = model.navigationPopList!;
      });
      _createTab();
      _createTabPage();
    }).catchError((e) => print(e));
  }

  void _createTab() {
    if (navigationList == null) return null;
    navigationList.forEach((model) {
      tabs.add(Tab(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            model.categoryName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color(0xff666666), fontSize: 15),
          ),
        ),
      ));
    });
  }

  void _createTabPage() {
    if (navigationList == null) return;
    for (int i = 0; i < navigationList.length; i++) {
      List<Widget> tabPage = [];
      for (int j = 0; j < navigationList[i].destAreaList!.length; j++) {
        String text = navigationList[i].destAreaList![j]!.text!;
        tabPage.add(Container(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ));
        List<Widget> imageItems = [];
        List<Widget> spanContent = [];
        List<Widget> visibleSpans = [];
        List<Widget> unVisibleSpans = [];
        List<Row> unVisibleRows = [];
        for (int k = 0;
            k < navigationList[i].destAreaList![j]!.child!.length;
            k++) {
          String imgName =
              navigationList[i]!.destAreaList![j]!.child![k]!.text!;
          String tagName = navigationList![i]!
                      .destAreaList![j]!
                      .child![k]!
                      .tagList!
                      .length! >
                  0
              ? navigationList[i]!
                  .destAreaList![j]!
                  .child![k]!
                  .tagList![0]!
                  .tagName!
              : '';
          String spanText = navigationList![i].destAreaList![j].child![k].text!;
          String picUrl = navigationList[i].destAreaList![j].child![k].picUrl!;
          if (picUrl != '' && picUrl != null) {
            // imageItems.add(cr)
          }
        }
      }
    }
  }
}
