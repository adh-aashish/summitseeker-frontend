import 'package:flutter/material.dart';

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
  });
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserInfo _userInfo;
  bool _showMore = false;

  @override
  void initState() {
    super.initState();

    // Initialize the user info data here
    _userInfo = UserInfo(
      profilePicture: 'img/hire.png',
      firstName: 'Sharma',
      lastName: 'Avisek',
      email: 'avisek@pcampus.com',
      dateOfBirth: '1990-03-11',
      gender: 'M',
      nationality: 'NP',
      languagesSpoken: ['EN', 'ES'],
      contactNumber: '9804234243',
      experience: 'Beginner',
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                CircleAvatar(
                  backgroundImage: AssetImage(_userInfo.profilePicture),
                  radius: 50,
                ),
                const SizedBox(height: 40),
                Text(
                  '${_userInfo.firstName} ${_userInfo.lastName}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _userInfo.email,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 40),
                _showMore
                    ? Column(children: [
                        const SizedBox(height: 16),
                        Text(
                          'Date of Birth: ${_userInfo.dateOfBirth}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Gender: ${_userInfo.gender}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Nationality: ${_userInfo.nationality}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Languages Spoken: ${_userInfo.languagesSpoken.join(", ")}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Contact Number: ${_userInfo.contactNumber}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Experience: ${_userInfo.experience}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ])
                    : Container(),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                  child: Text(
                    _showMore ? 'Show less' : 'Show more',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // TODO: goto profile editing page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileEditingPage(userInfo: _userInfo),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 27, 27, 27)),
                  ),
                  child: const Text('edit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
