import 'package:http/http.dart' as http;


class LoripsumApi {
  static Future<String> getLoripsum() async {
    final String url = "http://loripsum.net/api";
    print(">> GET $url");
    var response = await http.get(url);
    String text = response.body;
    // remove tags html
    text = text.replaceAll("<p>", "").replaceAll("</p>", "");
    return text;
  }
}

