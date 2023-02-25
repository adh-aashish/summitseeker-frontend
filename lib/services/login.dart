import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> login(String email, String password) async {
  try {
    var response = await http.post(
      Uri.parse('http://74.225.249.44/api/user/login/'),
      body: {
        'email': email,
        'password': password,
      },
    );
    final body = jsonDecode(response.body);
    if (body["token_invalid"]) {
      return "Invalid Token";
    }
    if (body["success"]) {
      final data = body["data"];
      String accessToken = data["access"];
      // Save the token in the shared preferences or secure storage
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", accessToken.toString());
      return "Successful";
    } else {
      if (body["validation_error"]) {
        return "Validation Error";
      } else {
        return body["message"];
      }
    }
  } catch (e) {
    return "ConnectionError";
  }
}
