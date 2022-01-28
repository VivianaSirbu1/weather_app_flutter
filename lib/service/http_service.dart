import 'package:http/http.dart' as http;
import 'package:wwather_app_a/utils/string.dart';

class HttpService {
  static Future<http.Response> getRequest(endPoint) async {
    http.Response response;

    final url = Uri.parse("$baseUrl$endPoint&appid=$apiKey&units=metric");

    try {
      response = await http.get(url);
    } on Exception {
      rethrow;
    }

    return response;
  }
}
