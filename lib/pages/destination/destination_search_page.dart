import 'package:ctrip_exercise/model/destination_search_model.dart';
import 'package:ctrip_exercise/widget/search_bar.dart';
import 'package:flutter/material.dart';

import '../../request/destination/destination_search_request.dart';

const URL = 'https://m.ctrip.com/restapi/soa2/20577/suggest';

class DestinationSearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String? keyword;
  final String? hint;
  const DestinationSearchPage(
      {super.key,
      this.hideLeft = true,
      this.keyword,
      this.hint,
      this.searchUrl = URL});

  @override
  State<DestinationSearchPage> createState() => _DestinationSearchPageState();
}

class _DestinationSearchPageState extends State<DestinationSearchPage> {
  List<Widget> items = [];
  String? keyword;
  DestinationSearchModel? destinationSearchModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _appBar(context),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                flex: 1,
                child: ListView(
                  children: items.length > 0 ? items : [],
                ),
              ))
        ],
      ),
    );
  }

  _appBar(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 30, right: 20, left: 10),
            height: 100,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2, 3),
                  blurRadius: 6,
                  spreadRadius: 0.6)
            ]),
            child: SearchInputBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
              speakClick: _jumpToSpeak,
            ),
          ),
        )
      ],
    );
  }

  void _onTextChange(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        destinationSearchModel = null;
        items.clear();
      });
      return;
    }
    DestinationSearchDao.fetch(widget.searchUrl, text)
        .then((DestinationSearchModel model) {
      if (model.keyword == text) {
        setState(() {
          destinationSearchModel = model;
        });
        items = _createContent();
      }
    }).catchError((e) {
      print(e);
    });
  }

  void _jumpToSpeak() {
    // NavigatorUtil.push(context, SpeakPage());
  }

  List<Widget> _createContent() {
    List<Widget> _contents = [];
    print(destinationSearchModel?.modules?.length);
    destinationSearchModel?.modules?.forEach((DestinationSearchItem model) {
      _contents
          .add(_createSearchItem(model?.style, model?.items, model?.title));
    });
    return _contents;
  }

  Widget _createSearchItem(int? type, List<Items>? items, String? title) {
    if (type == 0) {
      String icon = 'images/lvpai_search_list.png';
      return Column(
        children: items!.map((item) {
          return GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.2, color: Colors.grey)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Image(
                        height: 16,
                        width: 16,
                        image: AssetImage(icon),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    //wrap 换行
                    child: Wrap(
                      children: [
                        _title(item?.displayName ?? ""),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Text(
                          item?.upperName ?? '',
                          style: TextStyle(color: Color(0xff999999)),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        }).toList(),
      );
    } else if (type == 1) {
      String icon = 'images/lvpai_issue_position.png';
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.2, color: Colors.grey)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Image(
                      height: 16,
                      width: 16,
                      image: AssetImage(icon),
                    ),
                  ),
                ),
                Text(title ?? ""),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 20),
              child: Wrap(
                children: _tabItem(items),
              ),
            )
          ],
        ),
      );
    } else {
      return Text("");
    }
  }

  List<Widget> _tabItem(List<Items>? items) {
    return items!.map((item) {
      return GestureDetector(
        onTap: () {},
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 6, 8),
            padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
            width: 0.3 * MediaQuery.of(context).size.width - 12,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xfff7f7f7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
              children: [
                Text(
                  item.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12, fontFamily: ""),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      );
    }).toList();
  }

  _title(String name) {
    if (name == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(name, destinationSearchModel!.keyword!));
    return RichText(text: TextSpan(children: spans));
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle =
        TextStyle(fontFamily: 'PingFang', color: Colors.black87);
    TextStyle keywordStyle =
        TextStyle(fontFamily: 'PingFang', color: Color(0xff0086f6));

    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }

      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
