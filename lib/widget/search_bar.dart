import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../model/travel_hot_keyword_model.dart';

enum SearchBarType { home, normal, homeLight }

class SearchInputBar extends StatefulWidget {
  SearchBarType? searchBarType;
  void Function()? leftButtonClick;
  void Function()? inputBoxClick;
  void Function()? speakClick;
  void Function()? rightButtonClick;
  ValueChanged<String>? onChanged;
  bool? hideLeft;
  String? hint;
  List<HotKeyword>? hintList;
  String? defaultText;
  bool? rightIcon;
  bool? isUserIcon;

  SearchInputBar(
      {super.key,
      this.searchBarType = SearchBarType.normal,
      this.leftButtonClick,
      this.hideLeft,
      this.hint,
      this.hintList,
      this.onChanged,
      this.defaultText,
      this.inputBoxClick,
      this.speakClick,
      this.rightButtonClick,
      this.rightIcon = false,
      this.isUserIcon = false});

  @override
  State<SearchInputBar> createState() => _SearchInputBarState();
}

class _SearchInputBarState extends State<SearchInputBar> {
  bool showClear = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  _genNormalSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget.hideLeft ?? false
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 24,
                      ),
              ),
              widget.leftButtonClick),
          Expanded(flex: 1, child: _inputBox()),
        ],
      ),
    );
  }

  _genHomeSearch() {
    String sMessage;
    if (widget.searchBarType == SearchBarType.home) {
      sMessage = 'images/xiaoxi_white.png';
    } else {
      sMessage = 'images/xiaoxi_grey.png';
    }

    return Container(
      child: Row(
        children: [
          Expanded(flex: 1, child: _inputBox()),
          _wrapTap(
              widget.rightIcon!
                  ? rightIcon('images/kefu.png')
                  : widget.isUserIcon!
                      ? rightIcon('images/user1.png')
                      : rightIcon(sMessage),
              widget.rightButtonClick)
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse("0xffEDEDED"));
    }
    return Container(
      height: 34,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor, borderRadius: BorderRadius.circular(17)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "images/sousuo.png",
            width: 17,
          ),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      autofocus: true,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              Theme.of(context).platform == TargetPlatform.iOS
                                  ? EdgeInsets.fromLTRB(4, 0, 4, 15)
                                  : EdgeInsets.fromLTRB(4, 0, 4, 15),
                          hintText: widget.hint ?? "",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey)),
                    )
                  : _wrapTap(
                      widget.hintList != null
                          ? CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                scrollPhysics: NeverScrollableScrollPhysics(),
                                autoPlayInterval: Duration(seconds: 3),
                                scrollDirection: Axis.vertical,
                              ),
                              items: widget.hintList!
                                  .map((item) => _hintItem(item))
                                  .toList(),
                            )
                          : Container(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                widget.defaultText!,
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                      widget.inputBoxClick)),
          !showClear
              ? _wrapTap(
                  Image.asset(
                    "images/yuyin.png",
                    width: 17,
                  ),
                  widget.speakClick)
              : _wrapTap(
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged("");
                })
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  Widget _hintItem(HotKeyword item) {
    return Container(
        padding: EdgeInsets.fromLTRB(4, 7, 0, 0),
        child: Text(
          item.prefix! + "\“" + item.content! + "\”",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ));
  }

  rightIcon(String icon) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Image.asset(
        icon,
        width: 24,
        height: 24,
      ),
    );
  }
}
