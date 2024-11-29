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
    destinationSearchModel?.modules?.forEach((DestinationSearchItem model) {
      _contents.add(_createPoiInfo(
          model.title ?? "", 1, model.name ?? "", model.name ?? ""));
    });
    return _contents;
  }

  Widget _createPoiInfo(
      String searchName, int poid, String upperName, String dataType) {
    String icon = 'images/lvpai_search_list.png';
    if (dataType == 'D') icon = 'images/lvpai_issue_position.png';
    if (dataType == '') icon = 'images/lvpai_search_list.png';
    if (dataType == 'SS') icon = 'images/lvpai_issue_sight.png';
    return GestureDetector(
      onTap: () {
        //todo
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Image(
                height: 16,
                width: 16,
                image: AssetImage(icon),
              ),
            ),
            Expanded(
                child: Container(
              child: Wrap(
                children: [
                  Text('111'),
                  Padding(padding: EdgeInsets.only(right: 6)),
                  Text(
                    upperName,
                    style: TextStyle(color: Color(0xff999999)),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
