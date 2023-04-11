import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HtmlTranslationService {
  static Future<String> translateDescrition(String html, {bool? isHtml}) async {
    String des = html;
    String lanCode = 'en';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var res1 = await prefs.getString('locale');
    if (res1 != null) {
      Map map = jsonDecode(res1);
      lanCode = map.keys.first;
    }
    if (isHtml != null) des = html.replaceAll(RegExp("&nbsp;"), '');
    http.Response res = await http.get(Uri.parse(
        "https://translation.googleapis.com/language/translate/v2?target=$lanCode&key=AIzaSyBLQ7EU0ZAUZ4UWNfZ-gpsQnx5fdhIbKao&q=$des"));

    print(jsonDecode(res.body)["data"]["translations"][0]["translatedText"]);

    return jsonDecode(res.body)["data"]["translations"][0]["translatedText"];
  }
}
