import 'dart:convert';
import 'package:frontend/utils/http_utils.dart';

Future<List> submitReview(String url, Map data) async {
  List res = [];
  // List allGuidesOfRoute = [];
  try {
    var response = await HttpService.postReq(url, data);
    print(response.body);
    print(jsonEncode(data));
    Map body = await jsonDecode(response.body);

    if (body["token_invalid"]) {
      res = [false, "token_invalid"];
      // need to implement logout from here
    }
    if (body["success"]) {
      res = [true, "Enquiry Sent"];
    } else {
      if (body["validation_error"]) {
        res = [false, body["errors"]];
      } else {
        res = [false, body["message"]];
      }
    }
    return res;
  } catch (e) {
    res = [false, e.toString()];
    return res;
  }
}
