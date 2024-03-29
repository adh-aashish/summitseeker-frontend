import 'dart:convert';
import 'package:frontend/utils/http_utils.dart';

Future<List> sendEnquiry(int routeIndex, String startDate, int deadline,
    int guideId, double moneyRate) async {
  List res = [];
  // List allGuidesOfRoute = [];
  try {
    Map data = {};
    data["start_date"] = startDate;
    // data["deadline"] = deadline;
    data["deadLine"] = 3;
    data["status"] = "RQ";
    data["money_rate"] = moneyRate;

    var response = await HttpService.postReq(
        'http://74.225.249.44/api/trails/$routeIndex/guides/$guideId/hire/',
        data);
    print(response);
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

Future<List> cancelEnquiry(int hireId) async {
  List res = [];
  // List allGuidesOfRoute = [];
  try {
    var response = await HttpService.getReq(
        'http://74.225.249.44/api/user/cancelrequest/$hireId');
    print(response);
    print(response.body);
    Map body = await jsonDecode(response.body);

    if (body["token_invalid"]) {
      res = [false, "token_invalid"];
      // need to implement logout from here
    }
    if (body["success"]) {
      res = [true, "Enquiry Cancelled"];
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

Future<List> sendResponse(int hireId, String status) async {
  List res = [];
  // List allGuidesOfRoute = [];
  try {
    Map data = {};
    data["status"] = status;
    // data["deadline"] = deadline;

    var response = await HttpService.postReq(
        'http://74.225.249.44/api/response/$hireId/', data);
    // print(jsonEncode(data));
    print(response.body);
    Map body = await jsonDecode(response.body);

    if (body["token_invalid"]) {
      res = [false, "token_invalid"];
      // need to implement logout from here
    }
    if (body["success"]) {
      res = [true, "Response Sent"];
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

Future<List> finalHire(int hireId) async {
  List res = [];
  // List allGuidesOfRoute = [];
  try {
    Map data = {};
    data["hire_id"] = hireId;

    var response =
        await HttpService.postReq('http://74.225.249.44/api/hire/', data);
    print(response.body);
    Map body = await jsonDecode(response.body);

    if (body["token_invalid"]) {
      res = [false, "token_invalid"];
      // need to implement logout from here
    }
    if (body["success"]) {
      res = [true, "You can see the guides contact now"];
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
