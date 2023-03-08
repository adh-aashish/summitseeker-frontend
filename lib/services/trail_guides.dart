import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/utils/token.dart';

Future<List> getTrailGuides(int routeId) async {
  List allGuidesOfRoute = [];
  String token = await getToken();
  // TODO: handle this
  if (token == 'Expired') {
    throw "TokenInvalid";
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    //   (route) => false,
    // );
  }
  try {
    var response = await http.get(
      Uri.parse('http://74.225.249.44/api/trails/$routeId/guides'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final body = await jsonDecode(response.body);
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
    } else {
      if (body["validation_error"]) {
        print(body["errors"]);
      } else {
        print(body["message"]);
      }
    }

    return allGuidesOfRoute;
  } catch (e) {
    print("Error while getting trending list");
    throw "Error while getting trending list";
  }
}
