import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  bool isExpired = await isTokenExpired(token);
  if (isExpired) {
    token = "Expired";
  }
  return token!;
}

Future<bool> isTokenExpired(String? token) async {
  if (token != null) {
    // Map<String, dynamic> payload = Jwt.parseJwt(token);
    // DateTime? expiryDate = Jwt.getExpiryDate(token);
    bool isExpired = Jwt.isExpired(token);
    return isExpired;
  } else {
    return true;
  }
}
