import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<String> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('http://74.225.249.44/api/user/login/'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // final decodedToken = Jwt.parseJwt(response.body);
      final decodedToken = jsonDecode(response.body);
      String accessToken = decodedToken["access"];
      // Save the token in the shared preferences or secure storage
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", accessToken.toString());
      return "Successful";
    } else {
      final body = jsonDecode(response.body);
      return body["message"];
    }
  } catch (e) {
    throw Exception("Probem in Handling login");
  }
}

Future<bool> isTokenExpired() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  if (token != null) {
    // Map<String, dynamic> payload = Jwt.parseJwt(token);
    // DateTime? expiryDate = Jwt.getExpiryDate(token);
    bool isExpired = Jwt.isExpired(token);
    return isExpired;
  } else {
    return true;
  }
}

Future<bool> isTokenEmpty() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  if (token != null) {
    return false;
  }
  return true;
}
