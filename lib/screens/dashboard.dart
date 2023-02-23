import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/screens/login_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard ({super.key});

  @override
  State<DashBoard > createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard > {
  String token = "";
  @override 
  void initState() {
    super.initState();
    getCredentials();
  }

  void getCredentials() async {
    // get shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token")!;
    });
  }

  Future logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()), 
        (route)=>false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text("Welcome User"),
              const SizedBox(height:20.0),
              Text("Token : $token"),
              Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Logout'),
                    onPressed: ()async {
                      await logout();
                    },
                  )
              ),
            ],
          ),
        ), 
      ),
    );
  }
}
