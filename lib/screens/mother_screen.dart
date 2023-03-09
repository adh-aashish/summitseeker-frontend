import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/notification_screen.dart';
import 'package:frontend/widgets/drawer.dart';
import 'hire_screen.dart';
import 'home_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MotherScreen extends StatefulWidget {
  const MotherScreen({super.key});

  @override
  State<MotherScreen> createState() => _MotherScreenState();
}

class _MotherScreenState extends State<MotherScreen> {
  int _selectedIndex = 0;
  List allTrailList = [];
  Map userProfile = {};
  Map data = {};

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final parameters =
        (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    // parameters = jsonDecoder(jsonEncode(parameters));
    data = data.isNotEmpty ? data : jsonDecode(jsonEncode(parameters));
    allTrailList = allTrailList.isNotEmpty
        ? allTrailList
        : ((data['allTrailList'] ?? []) as List);
    userProfile = userProfile.isNotEmpty
        ? userProfile
        : ((data['userProfile'] ?? {}) as Map);
    return Container(
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white.withOpacity(0),
        drawer: MyDrawer(
          userProfile: userProfile,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            unselectedFontSize: 0,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black.withOpacity(0.25),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.apps)),
              BottomNavigationBarItem(
                  label: "Explore", icon: Icon(Icons.explore)),
              BottomNavigationBarItem(label: "Hire", icon: Icon(Icons.hiking)),
              BottomNavigationBarItem(
                  label: "Me", icon: Icon(Icons.notifications)),
            ]),
      ),
    );
  }

  late final List<Widget> _pages = <Widget>[
    HomeScreen(allTrailList: allTrailList),
    const Icon(
      Icons.explore,
      size: 150,
    ),
    TrekkingRoutesPage(allTrailList: allTrailList),
    const NotificationScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
