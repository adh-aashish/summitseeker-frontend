import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/utils/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void setupAllImages() async {
    List trendingList = [];
    String token = await getToken();
    if (token == 'Expired' && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
    var response = await http.get(
      Uri.parse('http://74.225.249.44/api/trails/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final decodedBody = await jsonDecode(response.body);
      List data = decodedBody["data"];
      for (Map<String, dynamic> trail in data) {
        Map newMap = {};
        newMap["name"] = trail["name"];
        newMap["image-url"] = "http://74.225.249.44${trail["image"]}";
        trendingList.add(newMap);
      }
    } else {
      print("Error fetching images");
    }

    if (mounted) {
      // print("Here");
      Navigator.pushReplacementNamed(context, '/', arguments: {
        'trendingList': trendingList,
      });
    }
  }

  @override
  void initState() {
    setupAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 18, 31),
                Color.fromARGB(129, 0, 138, 180)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SpinKitCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
