import 'dart:convert';

import 'package:ctrip_exercise/model/travel_model.dart';
import 'package:http/http.dart' as http;

class TravelDao {
  static Future<TravelItemModel> fetch(String url, Map params,
      String? groupChannelCode, int pageIndex, int pageSize) async {
    Map params = {
      "pageIndex": pageIndex,
      "pageSize": pageSize,
      "sortType": 9,
      "sortDirection": 0,
      "groupChannelCode": groupChannelCode
    };
    final response = await http.post(Uri.parse(url), body: jsonEncode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel');
    }
  }
}
