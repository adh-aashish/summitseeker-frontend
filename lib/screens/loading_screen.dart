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
    List allTrailList = [];
    Map userProfile = {};
    String token = await getToken();
    if (token == 'Expired' && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }

    // get all trail list
    try {
      var response = await http.get(
        Uri.parse('http://74.225.249.44/api/trails/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      final body = await jsonDecode(response.body);
      if (body["token_invalid"]) {
        print("Invalid token");
        // need to implement logout from here
      }
      if (body["success"]) {
        List data = body["data"];
        for (Map<String, dynamic> trail in data) {
          Map newMap = {};
          newMap["id"] = trail["id"];
          newMap["name"] = trail["name"];
          newMap["image-url"] = "http://74.225.249.44${trail["image"]}";
          allTrailList.add(newMap);
        }
      } else {
        if (body["validation_error"]) {
          print(body["errors"]);
        } else {
          print(body["message"]);
        }
      }
    } catch (e) {
      print("Error while getting trending list");
    }

    try {
      var response = await http.get(
        Uri.parse('http://74.225.249.44/api/user/profile/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      final body = await jsonDecode(response.body);
      if (body["token_invalid"]) {
        print("Invalid token");
        // need to implement logout from here
      }
      if (body["success"]) {
        final data = body["data"];
        userProfile["first_name"] = data["first_name"];
        userProfile["last_name"] = data["last_name"];
        userProfile["email"] = data["email"];
        userProfile["userType"] = data["userType"];
      } else {
        if (body["validation_error"]) {
          print(body["errors"]);
        } else {
          print(body["message"]);
        }
      }
    } catch (e) {
      print("Error while getting trending list");
    }

    if (mounted) {
      // print("Here");
      Navigator.pushReplacementNamed(context, '/', arguments: {
        'allTrailList': allTrailList,
        'userProfile': userProfile,
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
