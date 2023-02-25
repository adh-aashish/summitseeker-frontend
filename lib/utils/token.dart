import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  bool isExpired = await isTokenExpired();
  if (isExpired) {
    token = "Expired";
  }
  return token!;
}

Future<bool> isTokenExpired() async {
  // Map<String, dynamic> payload = Jwt.parseJwt(token);
  // DateTime? expiryDate = Jwt.getExpiryDate(token);
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  if (token != null) {
    bool isExpired = Jwt.isExpired(token);
    return isExpired;
  } else {
    return true;
  }
}

void clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
}
