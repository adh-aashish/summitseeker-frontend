import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/drawer.dart';
import 'home_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MotherScreen extends StatefulWidget {
  const MotherScreen({super.key});

  @override
  State<MotherScreen> createState() => _MotherScreenState();
}

class _MotherScreenState extends State<MotherScreen> {
  int _selectedIndex = 0;
  List trendingList = [];
  Map userProfile = {};
  Map data = {};

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final parameters =
        (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    // parameters = jsonDecoder(jsonEncode(parameters));
    data = data.isNotEmpty ? data : jsonDecode(jsonEncode(parameters));
    trendingList = trendingList.isNotEmpty
        ? trendingList
        : ((data['trendingList'] ?? []) as List);
    userProfile = userProfile.isNotEmpty
        ? userProfile
        : ((data['userProfile'] ?? {}) as Map);
    // print("in mother screen\n");
    // print(parameters);
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
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Text(
        //           'Drawer Header',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Settings'),
        //         onTap: () {
        //           // code to handle onTap
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.info),
        //         title: Text('About'),
        //         onTap: () {
        //           // code to handle onTap
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        // appBar: AppBar(
        //   toolbarHeight: 0,
        //   backgroundColor: Colors.white.withOpacity(0),
        //   elevation: 0.0,
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.sort,
        //       color: Colors.grey,
        //       size: 30.0,
        //     ),
        //     onPressed: () {},
        //   ),
        //   actions: [
        //     Padding(
        //         padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
        //         child: IconButton(
        //           onPressed: () {},
        //           icon: const CircleAvatar(
        //             radius: 15.0,
        //             backgroundImage: AssetImage('assets/traveller_avatar.png'),
        //           ),
        //         )),
        //   ],
        // ),
        body: Container(
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [Colors.blue, Colors.green],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          // ),
          child: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
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
    HomeScreen(trendingList: trendingList),
    const Icon(
      Icons.explore,
      size: 150,
    ),
    const Icon(
      Icons.hiking,
      size: 150,
    ),
    const Icon(
      Icons.notifications,
      size: 150,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
