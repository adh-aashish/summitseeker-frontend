import 'package:flutter/material.dart';
import 'package:frontend/screens/my_profile_screen.dart';

class ProfileEditingPage extends StatefulWidget {
  final UserInfo userInfo;

  const ProfileEditingPage({Key? key, required this.userInfo})
      : super(key: key);

  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  late UserInfo _userInfo;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dobController;
  late TextEditingController _contactNumberController;
  late TextEditingController _emailController;
  late String _nationalityValue;
  late String _genderValue;
  late List<String> _languagesSpoken;
  late String _experienceValue;
  late String _passwordValue;
  @override
  void initState() {
    super.initState();
    _userInfo = widget.userInfo;

    _firstNameController = TextEditingController(text: _userInfo.firstName);
    _lastNameController = TextEditingController(text: _userInfo.lastName);
    _dobController = TextEditingController(text: _userInfo.dateOfBirth);
    _contactNumberController =
        TextEditingController(text: _userInfo.contactNumber);
    _emailController = TextEditingController(text: _userInfo.email);
    _nationalityValue = _userInfo.nationality;
    _genderValue = _userInfo.gender;
    _languagesSpoken = _userInfo.languagesSpoken;
    _experienceValue = _userInfo.experience;
    _passwordValue = 'password';
  }

  // List of countries for nationality dropdown
  final List<Map<String, String>> _countries = [
    {'code': 'NP', 'name': 'Nepal'},
    {'code': 'DZ', 'name': 'Algeria'},
    {'code': 'AR', 'name': 'Argentina'},
    {'code': 'AU', 'name': 'Australia'},
    {'code': 'AT', 'name': 'Austria'},
    {'code': 'BE', 'name': 'Belgium'},
    {'code': 'BR', 'name': 'Brazil'},
    {'code': 'CA', 'name': 'Canada'},
    {'code': 'CL', 'name': 'Chile'},
    {'code': 'CN', 'name': 'China'},
    {'code': 'CO', 'name': 'Colombia'},
    {'code': 'CZ', 'name': 'Czech Republic'},
    {'code': 'DK', 'name': 'Denmark'},
    {'code': 'EG', 'name': 'Egypt'},
    {'code': 'FI', 'name': 'Finland'},
    {'code': 'FR', 'name': 'France'},
    {'code': 'DE', 'name': 'Germany'},
    {'code': 'GR', 'name': 'Greece'},
    {'code': 'HU', 'name': 'Hungary'},
    {'code': 'IN', 'name': 'India'},
    {'code': 'ID', 'name': 'Indonesia'},
    {'code': 'IE', 'name': 'Ireland'},
    {'code': 'IL', 'name': 'Israel'},
    {'code': 'IT', 'name': 'Italy'},
    {'code': 'JP', 'name': 'Japan'},
    {'code': 'JO', 'name': 'Jordan'},
    {'code': 'KR', 'name': 'South Korea'},
    {'code': 'KW', 'name': 'Kuwait'},
    {'code': 'LB', 'name': 'Lebanon'},
    {'code': 'MY', 'name': 'Malaysia'},
    {'code': 'MX', 'name': 'Mexico'},
    {'code': 'MA', 'name': 'Morocco'},
    {'code': 'NL', 'name': 'Netherlands'},
    {'code': 'NZ', 'name': 'New Zealand'},
    {'code': 'NG', 'name': 'Nigeria'},
    {'code': 'NO', 'name': 'Norway'},
    {'code': 'OM', 'name': 'Oman'},
    {'code': 'PK', 'name': 'Pakistan'},
    {'code': 'PE', 'name': 'Peru'},
    {'code': 'PH', 'name': 'Philippines'},
    {'code': 'PL', 'name': 'Poland'},
    {'code': 'PT', 'name': 'Portugal'},
    {'code': 'QA', 'name': 'Qatar'},
    {'code': 'RU', 'name': 'Russia'},
    {'code': 'SA', 'name': 'Saudi Arabia'},
    {'code': 'SG', 'name': 'Singapore'},
    {'code': 'ZA', 'name': 'South Africa'},
    {'code': 'ES', 'name': 'Spain'},
    {'code': 'SE', 'name': 'Sweden'},
    {'code': 'CH', 'name': 'Switzerland'},
    {'code': 'TW', 'name': 'Taiwan'},
    {'code': 'TH', 'name': 'Thailand'},
    {'code': 'TR', 'name': 'Turkey'},
    {'code': 'UA', 'name': 'Ukraine'},
    {'code': 'US', 'name': 'USA'},
    {'code': 'UK', 'name': 'United Kingdom'},
  ];

  // List of languages for languages dropdown
  final List<Map<String, String>> _languagesList = [
    {'code': 'EN', 'name': 'English'},
    {'code': 'FR', 'name': 'French'},
    {'code': 'ES', 'name': 'Spanish'},
    {'code': 'DE', 'name': 'German'},
    {'code': 'IT', 'name': 'Italian'},
    {'code': 'PT', 'name': 'Portuguese'},
    {'code': 'RU', 'name': 'Russian'},
    {'code': 'ZH', 'name': 'Chinese (Simplified)'},
    {'code': 'JA', 'name': 'Japanese'},
    {'code': 'KO', 'name': 'Korean'},
    {'code': 'AR', 'name': 'Arabic'},
    {'code': 'TR', 'name': 'Turkish'},
    {'code': 'PL', 'name': 'Polish'},
    {'code': 'NL', 'name': 'Dutch'},
    {'code': 'SV', 'name': 'Swedish'},
    {'code': 'NO', 'name': 'Norwegian'},
    {'code': 'FI', 'name': 'Finnish'},
    {'code': 'DA', 'name': 'Danish'},
    {'code': 'EL', 'name': 'Greek'},
    {'code': 'HE', 'name': 'Hebrew'},
    {'code': 'HU', 'name': 'Hungarian'},
    {'code': 'CS', 'name': 'Czech'},
    {'code': 'SK', 'name': 'Slovak'},
    {'code': 'SL', 'name': 'Slovenian'},
    {'code': 'HR', 'name': 'Croatian'},
    {'code': 'UK', 'name': 'Ukrainian'},
    {'code': 'HI', 'name': 'Hindi'},
    {'code': 'BN', 'name': 'Bengali'},
    {'code': 'TH', 'name': 'Thai'},
    {'code': 'VI', 'name': 'Vietnamese'},
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Theme(
            data: ThemeData.dark(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Implement profile picture editing logic
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('img/hire.png'),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _dobController,
                  decoration:
                      InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _nationalityValue,
                  decoration: InputDecoration(labelText: 'Nationality'),
                  items: _countries
                      .map((country) => DropdownMenuItem<String>(
                            value: country['code'],
                            child: Text(country['name']!),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _nationalityValue = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _genderValue,
                  decoration: InputDecoration(labelText: 'Gender'),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'M',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'F',
                      child: Text('Female'),
                    ),
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      _genderValue = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                // DropdownButtonFormField<String>(
                //   value:
                //       _languagesSpoken.isNotEmpty ? _languagesSpoken[0] : null,
                //   decoration: InputDecoration(labelText: 'Languages Spoken'),
                //   items: _languagesList
                //       .map((language) => DropdownMenuItem<String>(
                //             value: language['code'],
                //             child: Text(language['name']!),
                //           ))
                //       .toList(),
                //   onChanged: (newValue) {
                //     setState(() {
                //       if (_languagesSpoken.isEmpty) {
                //         _languagesSpoken.add(newValue!);
                //       } else {
                //         _languagesSpoken[0] = newValue!;
                //       }
                //     });
                //   },
                // ),
                DropdownButtonFormField<String>(
                  value: null,
                  onChanged: (String? value) {
                    setState(() {
                      if (value != null) {
                        _languagesSpoken.add(value);
                      }
                    });
                  },
                  items: _languagesList.map((language) {
                    return DropdownMenuItem<String>(
                      value: language['code'],
                      child: Text(language['name']!),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    hintText: 'Select languages',
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Selected Languages: ${_languagesSpoken.join(", ")}',
                  style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 224, 224, 224),
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 16.0),
                //-----------------------------------//
                //-----------------------------------//
                //-----------------------------------//
                SizedBox(height: 16),
                TextFormField(
                  controller: _experienceValue.isNotEmpty
                      ? TextEditingController(text: _experienceValue)
                      : null,
                  decoration: InputDecoration(labelText: 'Experience'),
                  onChanged: (newValue) {
                    _experienceValue = newValue;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _contactNumberController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordValue.isNotEmpty
                      ? TextEditingController(text: _passwordValue)
                      : null,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (newValue) {
                    _passwordValue = newValue;
                  },
                ),
                SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement profile editing logic
                    },
                    child: Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
