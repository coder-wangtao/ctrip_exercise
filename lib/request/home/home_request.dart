import 'dart:convert';

import 'package:ctrip_exercise/model/home_model.dart';
import 'package:http/http.dart' as http;
//首页大接口

const HOME_URL = "https://cdn.lishaoy.net/ctrip/homeConfig.json";

class HomeRequest {
  static Future fetch() async {
    final response = await http.get(Uri.parse(HOME_URL));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
