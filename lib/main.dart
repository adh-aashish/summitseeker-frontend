import 'package:flutter/material.dart';
import 'package:frontend/screens/loading_screen.dart';
import 'package:frontend/screens/mother_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        initialRoute: '/login',
        routes: {
          '/': (context) => const MotherScreen(),
          '/login': (context) => const LoginScreen(),
          '/loading': (context) => const LoadingScreen(),
        },
      ),
    );
