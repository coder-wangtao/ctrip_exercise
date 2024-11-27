import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/destination_model.dart';

var Params = {
  "contentType": "json",
  "head": {
    "cid": "09031043410934928682",
    "ctok": "",
    "cver": "1.0",
    "lang": "01",
    "sid": "8888",
    "syscode": "09",
    "auth": "",
    "extension": []
  },
  "channel": "H5",
  "businessUnit": 14,
  "startCity": 2
};
var Url =
    'https://sec-m.ctrip.com/restapi/soa2/14422/navigationInfo?_fxpcqlniredt=09031043410934928682';

class DestinationDao {
  static Future<DestinationModel> fetch() async {
    final response = await http.post(Uri.parse(Url), body: jsonEncode(Params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return DestinationModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel');
    }
  }
}
