import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
    }
));
