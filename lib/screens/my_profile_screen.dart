import 'package:flutter/material.dart';
import 'package:frontend/services/my_profile.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'edit_profile.dart';

class UserInfo {
  final String profilePicture;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String gender;
  final String nationality;
  final List<String> languagesSpoken;
  final String contactNumber;
  final String experience;
  final String userType;

  UserInfo({
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.languagesSpoken,
    required this.contactNumber,
    required this.experience,
    required this.userType,
  });
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserInfo _userInfo;
  bool isLoading = true;
  List reviewList = [];
  Map userProfile = {};

  final ScrollController _scrollController = ScrollController();

  void showSnackBar(bool success,
      [String message = "Unknown error occurred."]) {
    final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {},
        ),
        backgroundColor:
            (success = true) ? Colors.green[800] : Colors.red[800]);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(message);
  }

  void getUserInfo() async {
    // enquired guide list
    try {
      List response = await getMyReviews();

      setState(() {
        if (response[0]) {
          reviewList = response[1];
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, response[1]);
        }
        List hardreviewList = [
          {
            "first_name": "Aashish",
            "last_name": "Adhikari",
            "rating": 4.5,
            "comment":
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ",
            "photo":
                "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png",
          },
          {
            "first_name": "Aashish",
            "last_name": "Adhikari",
            "rating": 4.5,
            "comment":
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ",
            "photo":
                "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png",
          }
        ];
        for (int i = 0; i < hardreviewList.length; i++) {
          reviewList.add(hardreviewList[i]);
        }
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }

    try {
      List response = await getUserProfile();

      setState(() {
        if (response[0]) {
          userProfile = response[1];
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, response[1]);
        }
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the user info data here
    getUserInfo();
    _userInfo = UserInfo(
      profilePicture: 'img/hire.png',
      firstName: "Avishek",
      lastName: "Sharma",
      email: 'avisek@pcampus.com',
      dateOfBirth: '1990-03-11',
      gender: 'M',
      nationality: 'NP',
      languagesSpoken: ['EN', 'ES'],
      contactNumber: '9804234243',
      experience: 'Beginner',
      userType: 'Guide',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SpinKitFadingFour(
                          color: Colors.white,
                          size: 30.0,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const CircleAvatar(
                            backgroundImage: AssetImage("img/hire.png"),
                            radius: 40,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${userProfile["first_name"]} ${userProfile["last_name"]}',
                            style: TextStyle(
                              color: Colors.amberAccent[200],
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(width: 5),
                              Text(
                                userProfile["email"],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.phone_callback,
                                color: Colors.grey[400],
                              ),
                              Text(
                                userProfile["contactNum"].toString(),
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Text(
                            '${userProfile["userType"] == "TR" ? "Tourist" : "Guide"}, ${userProfile["gender"] == 'M' ? 'Male' : 'Female'}',
                            style: const TextStyle(
                              // color: Colors.grey[400],
                              color: Color(0xffBB86FC),
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 90.0,
                        color: Colors.grey[800],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'DOB',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        userProfile["date_of_birth"].toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 2.0,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nationality',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      userProfile["nationality"].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Languages',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      userProfile["languages"]
                                          .join(',')
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Experience',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      userProfile["trekking_experience"] == 'P'
                                          ? "Professional"
                                          : userProfile[
                                                      "trekking_experience"] ==
                                                  "B"
                                              ? "Beginner"
                                              : userProfile[
                                                          "trekking_experience"] ==
                                                      "S"
                                                  ? "Seasoned"
                                                  : "Never Done",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                      Divider(
                        height: 60.0,
                        color: Colors.grey[800],
                      ),
                      // const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Reviews",
                          style: TextStyle(
                            color: Color.fromARGB(255, 174, 171, 171),
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: (() {
                          List<Widget> widgets = [];
                          if (reviewList.isEmpty) {
                            return [const Center(child: Text("No Reviews."))];
                          } else {
                            for (int index = 0;
                                index < reviewList.length;
                                index++) {
                              widgets.add(const SizedBox(height: 20));
                              widgets.add(Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                reviewList[index]["photo"]),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text(
                                                  '${reviewList[index]["first_name"]} ${reviewList[index]["last_name"]}'),
                                              const SizedBox(height: 2),
                                              RatingBarIndicator(
                                                rating: 3.5,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemSize: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(reviewList[index]["comment"]),
                                    ],
                                  ),
                                ),
                              ));
                            }
                          }
                          return widgets;
                        }()),
                      ),
                    ],
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditingPage(userInfo: _userInfo),
              ),
            );
            // Add your onPressed code here!
            // Navigator.pop(context);
          },
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
