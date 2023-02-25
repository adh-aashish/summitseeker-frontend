import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageURL =
        "https://yt3.googleusercontent.com/9A5rzNCvhYMJq9cJGvn2dIUCkqREZNhmhTPQeHy7tORKWixbkLe79HIlsy2TklYYO-lvADtUbg=s176-c-k-c0x00ffffff-no-rj";

    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        color: Color.fromARGB(255, 0, 53, 81),
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
                  accountName: Text("Hrishav Khadka"),
                  accountEmail: Text("notrisavKhadka@gmail.com"),
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
            const ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: Icon(
                CupertinoIcons.profile_circled,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
              ),
            ),
            const ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: Icon(
                CupertinoIcons.return_icon,
              ),
              title: Text(
                "Log Out",
                textScaleFactor: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
