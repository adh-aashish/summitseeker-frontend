import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/notification_screen.dart';
import 'package:frontend/widgets/drawer.dart';
import 'hire_screen.dart';
import 'home_screen.dart';
import 'bookings_screen.dart';

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
  late bool isGuide;

  // Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
  //   0: GlobalKey<NavigatorState>(),
  //   1: GlobalKey<NavigatorState>(),
  //   2: GlobalKey<NavigatorState>(),
  // };

  // final List<GlobalKey<NavigatorState>> _navigatorKeys = [
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>()
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void moveToHiringPage() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void moveToLeaderBoard() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void moveToNotificationPage() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  // buildNavigator() {
  //   return Navigator(
  //     key: navigatorKeys[_selectedIndex],
  //     onGenerateRoute: (RouteSettings settings) {
  //       return MaterialPageRoute(
  //           builder: (_) => _pages.elementAt(_selectedIndex));
  //     },
  //   );
  // }
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

    isGuide = userProfile["userType"] == "TR" ? false : true;
    //print(userProfile['userType'].toString());
    late final List<Widget> _pages = <Widget>[
      HomeScreen(
          allTrailList: allTrailList,
          userProfile: userProfile,
          hiringPage: moveToHiringPage,
          leaderboard: moveToLeaderBoard),
      isGuide
          ? BookingPage()
          : TrekkingRoutesPage(
              allTrailList: allTrailList,
              notificationPage: moveToNotificationPage,
            ),
      NotificationPage(
        isGuide: isGuide,
      ),
    ];
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Color.fromARGB(255, 0, 18, 31),
          //     Color.fromARGB(129, 0, 138, 180)
          //   ],
          //   begin: Alignment.bottomCenter,
          //   end: Alignment.topCenter,
          // ),
          color: Color.fromARGB(255, 48, 48, 48),
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white.withOpacity(0),
          drawer: MyDrawer(
            userProfile: userProfile,
          ),
          // body: IndexedStack(
          //   index: _selectedIndex,
          //   children: _pages,
          // ),
          body: _pages[_selectedIndex],
          // body: buildNavigator(),

          //-----------------------------------------------------------------
          // body: CommonBottomNavigationBar(
          //   selectedIndex: _selectedIndex,
          //   navigatorKeys: _navigatorKeys,
          //   childrens: [
          //     HomeScreen(
          //         allTrailList: allTrailList,
          //         userProfile: userProfile,
          //         hiringPage: moveToHiringPage),
          //     TrekkingRoutesPage(
          //       allTrailList: allTrailList,
          //       notificationPage: moveToNotificationPage,
          //     ),
          //     const NotificationPage(),
          //   ],
          // ),
          //-----------------------------------------------------------------

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
              items: [
                const BottomNavigationBarItem(
                    label: "Home", icon: Icon(Icons.apps)),
                isGuide
                    ? const BottomNavigationBarItem(
                        label: "LeaderBoard", icon: Icon(Icons.event_available))
                    : const BottomNavigationBarItem(
                        label: "Hire", icon: Icon(Icons.hiking)),
                const BottomNavigationBarItem(
                    label: "Me", icon: Icon(Icons.notifications)),
              ]),
        ),
      ),
    );
  }
}
