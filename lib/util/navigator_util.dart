import 'package:flutter/material.dart';

class NavigatorUtil {
  static push(BuildContext context, Widget page, {Function? callback}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((res) {
      callback != null ? callback() : print('not fount callBack');
    });
  }
}
