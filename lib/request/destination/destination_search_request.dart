import 'dart:convert';

import 'package:ctrip_exercise/model/destination_search_model.dart';
import 'package:http/http.dart' as http;

var param = {
  "client": {
    "locale": "zh-CN",
    "currency": "CNY",
    "source": "前端中台",
    "cid": "09031172111130952952",
    "variables": [
      {"key": "CHANNEL_ID", "value": "114"},
      {"key": "221011_VAC_lylxc", "value": "B"}
    ]
  },
  "tab": 2,
  "keyword": "三亚",
  "channel": "ONLINE",
  "geo": {
    "departure": {"id": 2, "type": "base", "category": 3},
    "location": {},
    "lonlat": {"type": 0}
  }
};

class DestinationSearchDao {
  static Future<DestinationSearchModel> fetch(String url, keyword) async {
    param["keyword"] = keyword;
    final response = await http.post(Uri.parse(url), body: jsonEncode(param));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      DestinationSearchModel model = DestinationSearchModel.fromJson(result);
      model.keyword = keyword;
      return model;
    } else {
      throw Exception('Failed to load travel');
    }
  }
}
