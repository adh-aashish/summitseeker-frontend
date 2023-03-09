import 'dart:convert';
import 'package:frontend/utils/http_utils.dart';

Future<List> getTrailGuides(int routeIndex, String startDate) async {
  List res = [];
  List allGuidesOfRoute = [];
  try {
    Map data = {};
    data["start_date"] = startDate;
    var response = await HttpService.postReq(
        'http://74.225.249.44/api/trails/$routeIndex/guides/', data);
    print(response.body);
    Map body = await jsonDecode(response.body);

    if (body["token_invalid"]) {
      print("Invalid token");
      // need to implement logout from here
    }
    if (body["success"]) {
      List data = body["data"];
      for (Map<String, dynamic> guide in data) {
        Map newMap = {};
        newMap["id"] = guide["guide"]["id"];
        newMap["first_name"] = guide["guide"]["user"]["first_name"];
        newMap["last_name"] = guide["guide"]["user"]["last_name"];
        newMap["gender"] = guide["guide"]["user"]["gender"];
        newMap["languages"] = guide["guide"]["user"]["languages"];
        newMap["money_rate"] = guide["money_rate"];
        newMap["availability"] = guide["guide"]["availability"];
        newMap["total_trek_count"] = guide["guide"]["total_trek_count"];

        allGuidesOfRoute.add(newMap);
        print(newMap);
      }
      res = [true, allGuidesOfRoute];
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
