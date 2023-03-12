import 'package:flutter/material.dart';
import 'package:frontend/services/user_profile.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        reviewList = [1];
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }
  }

  // bool _showMore = false;
  void getMyProfile() async {
    // enquired guide list
  }

  @override
  void initState() {
    super.initState();

    // Initialize the user info data here
    getUserInfo();
    _userInfo = UserInfo(
      profilePicture: 'img/hire.png',
      firstName: 'Avisek',
      lastName: 'Sharma',
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
        body: Padding(
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
                        CircleAvatar(
                          backgroundImage: AssetImage(_userInfo.profilePicture),
                          radius: 40,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${_userInfo.firstName} ${_userInfo.lastName}',
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
                              _userInfo.email,
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
                              _userInfo.contactNumber,
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '${_userInfo.userType}, ${_userInfo.gender == 'M' ? 'Male' : 'Female'}',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      _userInfo.dateOfBirth,
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
                                    _userInfo.nationality,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
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
                                      _userInfo.languagesSpoken.join(','),
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
                                    'Experience',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    _userInfo.experience,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: reviewList.length,
                        itemBuilder: (context, index) {
                          final review = reviewList[index];
                          return GestureDetector(
                            onTap: () {
                              //TODO: prompt hiring the guide.
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: SizedBox(
                                height: 115,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      top: 8.0, left: 5, right: 5),
                                  leading: const CircleAvatar(
                                    backgroundImage: AssetImage('img/hire.png'),
                                  ),
                                  // title: Text(
                                  //     '${guide["first_name"]} ${guide["last_name"]}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
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
