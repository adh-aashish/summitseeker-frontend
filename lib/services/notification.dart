import 'dart:convert';
import 'package:frontend/utils/http_utils.dart';

Future<List> getNotifications() async {
  List res = [];
  try {
    var response =
        await HttpService.getReq('http://74.225.249.44/api/user/notifications');
    // print(response.body);
    Map body = await jsonDecode(response.body);

    if (body["token_invalid"]) {
      res = [false, "token_expired"];
      // need to implement logout from here
    }
    if (body["success"]) {
      Map data = body["data"];
      res = [true, data];
    } else {
      if (body["validation_error"]) {
        // print(body["errors"]);
        res = [false, body["errors"]];
      } else {
        // print(body["message"]);
        res = [false, body["message"]];
      }
    }
    return res;
  } catch (e) {
    res = [false, e.toString()];
    return res;
  }
}
