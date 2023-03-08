import 'package:http/http.dart' as http;
import 'package:frontend/utils/token.dart';
import 'dart:convert';

class HttpService {
  static Future<http.Response> postReq(String url, Map data,
      {bool withToken = true}) async {
    print(url);
    String token = await getToken();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (withToken) {
      headers["Authorization"] = "Bearer $token";
    }
    // print(data);
    return await http.post(Uri.parse(url),
        headers: headers,
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
  }

  static Future<http.Response> getReq(String url,
      {bool withToken = true}) async {
    print(url);
    String token = await getToken();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (withToken) {
      headers["Authorization"] = "Bearer $token";
    }
    print(headers);
    return await http.get(Uri.parse(url), headers: headers);
  }
}
