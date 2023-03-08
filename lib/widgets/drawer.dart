import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/logout.dart';

import '../screens/edit_profile.dart';
import '../screens/profile_info.dart';

class MyDrawer extends StatefulWidget {
  final Map userProfile;
  const MyDrawer({required this.userProfile, super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    String imageURL =
        "https://yt3.googleusercontent.com/9A5rzNCvhYMJq9cJGvn2dIUCkqREZNhmhTPQeHy7tORKWixbkLe79HIlsy2TklYYO-lvADtUbg=s176-c-k-c0x00ffffff-no-rj";

    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        color: const Color.fromARGB(255, 0, 53, 81),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  margin: EdgeInsets.zero,
                  accountName: Text(
                      "${widget.userProfile['first_name']} ${widget.userProfile['last_name']}"),
                  accountEmail: Text(widget.userProfile["email"]),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageURL),
                  )),
            ),
            const ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: Icon(
                CupertinoIcons.home,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.2,
              ),
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: const Icon(
                CupertinoIcons.profile_circled,
              ),
              title: const Text(
                "Profile",
                textScaleFactor: 1.2,
              ),
              onTap: () {
                //TODO: get guides for that route by its index no. from the server
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: const Icon(
                CupertinoIcons.return_icon,
              ),
              title: const Text(
                "Log Out",
                textScaleFactor: 1.2,
              ),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
