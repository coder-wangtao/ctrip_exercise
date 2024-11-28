import 'package:ctrip_exercise/model/destination_model.dart';
import 'package:ctrip_exercise/widget/loading_container.dart';
import 'package:ctrip_exercise/widget/search_bar.dart';
import 'package:flutter/material.dart';

import '../../plugin/vertical_tab_view.dart';
import '../../request/destination/destination_request.dart';
import '../../widget/scalable_box.dart';

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
                contents: tabPages,
                onSelect: (index) {},
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
    if (navigationList == null) return null;
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
        List<Widget> spanContent = [];
        List<Widget> imageItems = [];
        List<Row> visibleRows = [];
        List<Row> unVisibleRows = [];
        List<Widget> visibleSpans = [];
        List<Widget> unVisibleSpans = [];

        for (int k = 0;
            k < navigationList[i].destAreaList![j]!.child!.length;
            k++) {
          String? imgName =
              navigationList[i]?.destAreaList?[j]?.child![k]?.text;
          String? tagName = (navigationList[i]
                          ?.destAreaList?[j]
                          ?.child![k]
                          ?.tagList
                          ?.length ??
                      0) >
                  0
              ? (navigationList?[i]
                      ?.destAreaList?[j]
                      ?.child?[k]
                      ?.tagList?[0]
                      ?.tagName ??
                  '')
              : '';
          String? spanText = navigationList?[i].destAreaList?[j].child?[k].text;
          String? picUrl = navigationList[i].destAreaList?[j].child?[k].picUrl;
          int? tagListL =
              navigationList[i].destAreaList?[j].child?[k].tagList?.length;
          String? kwd = navigationList?[i].destAreaList?[j].child?[k]?.kwd;
          int? id = navigationList[i].destAreaList?[j].child?[k]?.id;

          if (picUrl != '' && picUrl != null) {
            //处理带图片的选项
            imageItems.add(createImage(picUrl, tagListL ?? 0, tagName,
                imgName ?? "", kwd ?? "", id ?? 0));
          } else {
            // //处理标签
            if (k < 9) {
              visibleSpans.add(createSpan(
                  spanText ?? "", tagListL ?? 0, tagName, kwd ?? "", id ?? 0));
            } else if (k >= 9) {
              unVisibleSpans.add(createSpan(
                  spanText ?? "", tagListL ?? 0, tagName, kwd ?? "", id ?? 0));
            }
          }
        }

        // 对图片项处理 每3条数据放到一个row容器
        List<Widget> rowList = [];
        if (imageItems.length % 3 == 1) {
          imageItems.add(Expanded(child: Container()));
          imageItems.add(Expanded(child: Container()));
        } else if (imageItems.length % 3 == 2) {
          imageItems.add(Expanded(child: Container()));
        }

        int start = 0;
        for (var k = 0; k < imageItems.length; k++) {
          if ((k + 1) % 3 == 0 && k != 0) {
            rowList.add(Row(
              children: imageItems.sublist(start, (k + 1)),
            ));
            start = k + 1;
          } else if (imageItems.length - start < 3) {
            //不足3的直接截断
            rowList.add(Row(
              children: imageItems.sublist(start),
            ));
            break;
          }
        }

        tabPage.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowList,
        ));

        //处理标签
        if (visibleSpans.length >= 9) {
          visibleRows.add(Row(
            children: visibleSpans.sublist(0, 3),
          ));
          visibleRows.add(Row(
            children: visibleSpans.sublist(3, 6),
          ));
          visibleRows.add(Row(
            children: visibleSpans.sublist(6, 9),
          ));
        } else if (visibleSpans.length > 0 && visibleSpans.length < 9) {
          if (visibleSpans.length % 3 == 1) {
            visibleSpans.add(Expanded(child: Container()));
            visibleSpans.add(Expanded(child: Container()));
          } else if (visibleSpans.length % 3 == 2) {
            visibleSpans.add(Expanded(child: Container()));
          }
          int vStart = 0;
          for (var k = 0; k < visibleSpans.length; k++) {
            if ((k + 1) % 3 == 0 && k != 0) {
              visibleRows.add(Row(
                children: visibleSpans.sublist(vStart, (k + 1)),
              ));
              vStart = k + 1;
            }
          }
        }

        int unStart = 0;
        if (unVisibleSpans.length % 3 == 1) {
          unVisibleSpans.add(Expanded(child: Container()));
          unVisibleSpans.add(Expanded(child: Container()));
        } else if (unVisibleSpans.length % 3 == 2) {
          unVisibleSpans.add(Expanded(child: Container()));
        }
        for (var k = 0; k < unVisibleSpans.length; k++) {
          if ((k + 1) % 3 == 0 && k != 0) {
            unVisibleRows.add(Row(
              children: unVisibleSpans.sublist(unStart, (k + 1)),
            ));
            unStart = k + 1;
          }
        }

        if (visibleRows.length > 0) {
          tabPage.add(ScalableBox(
            visibleSpans: visibleRows,
            unVisibleSpans: unVisibleRows,
          ));
        }
      }

      tabPages.add(MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tabPage,
                  ))
            ],
          )));
    }
  }

  Widget createImage(String picUrl, int tagListL, String tagName,
      String imgName, String kwd, int id) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        //todo
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
        child: Column(
          children: [
            PhysicalModel(
              borderRadius: BorderRadius.circular(6),
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              elevation: 5, //?
              child: Stack(
                children: [
                  Container(
                    child: Image.network(
                      picUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  tagListL > 0
                      ? Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            height: 18,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffff7600),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8))),
                            child: Text(
                              tagName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ))
                      : Container()
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Text(
                imgName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: Color(0xff333333).withAlpha(220)),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget createSpan(
      String spanText, int tagListL, String tagName, String kwd, int id) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        //todo
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
            decoration: BoxDecoration(
                color: Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(30),
                      offset: Offset(1, 1),
                      spreadRadius: 1,
                      blurRadius: 3)
                ]),
            height: 36,
            child: Text(
              spanText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff333333).withAlpha(220), fontSize: 13),
            ),
          ),
          tagListL > 0
              ? Positioned(
                  top: -8,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffff7600),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(6),
                        )),
                    child: Text(
                      tagName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ))
              : Container()
        ],
      ),
    ));
  }
}
