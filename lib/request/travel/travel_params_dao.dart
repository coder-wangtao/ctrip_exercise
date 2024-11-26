import 'dart:convert';

import 'package:ctrip_exercise/model/travel_params_model.dart';
import 'package:http/http.dart' as http;

class TravelParamsDao {
  static Future<TravelParamsModel> fetch() async {
    final response = await http.get(
        Uri.parse('http://www.devio.org/io/flutter_app/json/travel_page.json'));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelParamsModel.fromJson(result);
    }else{
      throw Exception("Failed to load travel_page.json");
    }
  }
}
