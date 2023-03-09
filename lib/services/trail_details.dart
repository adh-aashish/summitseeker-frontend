import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/utils/token.dart';
import 'package:frontend/services/trail_guides.dart';

Future<Map> getTrailDetails(int routeId) async {
  Map routeDetails = {};
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
      Uri.parse('http://74.225.249.44/api/trails/$routeId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final body = await jsonDecode(response.body);
    if (body["token_invalid"]) {
      print("Invalid token");
      // need to implement logout from here
    }
    if (body["success"]) {
      Map data = body["data"];
      routeDetails["id"] = data["id"];
      routeDetails["name"] = data["name"];
      routeDetails["image"] = data["image"];
      routeDetails["mapImage"] = data["mapImage"];
      routeDetails["days"] = data["days"];
      routeDetails["average_rating"] = data["average_rating"];
      routeDetails["average_difficulty"] = data["average_difficulty"];
      routeDetails["links"] = data["links"];
      routeDetails["reviews"] = await getTrailReviews(routeId);
      // routeDetails["guides"] = await getTrailGuides(routeId);
    } else {
      if (body["validation_error"]) {
        print(body["errors"]);
      } else {
        print(body["message"]);
      }
    }
    return routeDetails;
  } catch (e) {
    throw "Error while getting trending list";
  }
}

Future<List> getTrailReviews(int routeId) async {
  List trailReviews = [];
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
      Uri.parse('http://74.225.249.44/api/trails/$routeId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final body = await jsonDecode(response.body);
    if (body["token_invalid"]) {
      print("Invalid token");
      // need to implement logout from here
    }
    if (body["success"]) {
      Map data = body["data"];
      // routeDetails["id"] = data["id"];
      // routeDetails["name"] = data["name"];
      // routeDetails["image"] = data["image"];
      // routeDetails["mapImage"] = data["mapImage"];
      // routeDetails["days"] = data["days"];
      // routeDetails["average_rating"] = data["average_rating"];
      // routeDetails["average_difficulty"] = data["average_difficulty"];
      // routeDetails["links"] = data["links"];
    } else {
      if (body["validation_error"]) {
        print(body["errors"]);
      } else {
        print(body["message"]);
      }
    }
    return trailReviews;
  } catch (e) {
    throw "Error while getting trending list";
  }
}
