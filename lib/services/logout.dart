import 'package:flutter/material.dart';
import 'package:frontend/utils/token.dart';
import 'package:frontend/screens/login_screen.dart';

void logout(BuildContext context) async {
  clearSharedPreferences();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false,
  );
}
