import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _selectedGender;
  String? _selectedUserType = 'TR';
  String? _selectedExperience;
  String? _dateOfBirth;
  String? _contactNumber;
  String? _languagesSpoken;
  String? _firstName;
  String? _lastName;
  bool? _availability = true;
  int _totalTrekCount = 0;
  String _nationality = 'US'; // default value for nationality dropdown
  List<String> _languages = []; // selected languages will be stored here
  TextEditingController _dobController = TextEditingController();

  // List of countries for nationality dropdown
  final List<Map<String, String>> _countries = [
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
    _dobController.dispose();
    super.dispose();
  }

  final List<String> _genders = ['M', 'F'];
  final List<String> _userTypes = ['TR', 'GD'];
  final List<String> _experiences = ['N', 'B', 'S', 'P'];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
            // inputDecorationTheme: const InputDecorationTheme(
            //   labelStyle: TextStyle(
            //     fontSize: 13.0,
            //     color: Color.fromARGB(255, 255, 0, 0),
            //   ),
            //   hintStyle: TextStyle(
            //     color: Colors.grey,
            //   ),
            // ),
            // textTheme: const TextTheme(
            //   bodyMedium: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //     color: Color.fromARGB(255, 0, 144, 31),
            //     fontStyle: FontStyle.italic,
            //   ),
            //   titleMedium: TextStyle(
            //     color: Color.fromARGB(255, 157, 83, 77),
            //     fontWeight: FontWeight.normal,
            //     fontSize: 20.0,
            //   ),
            // ),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 14, 25, 28),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _firstName = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lastName = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                    ),
                    controller: _dobController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid date of birth';
                      }
                      // You can add more validation here if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Nationality',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your nationality';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     _nationality = value;
                  //   },
                  // ),
                  DropdownButtonFormField<String>(
                    value: _nationality,
                    decoration: const InputDecoration(
                      labelText: 'Nationality',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _nationality = value!;
                      });
                    },
                    items: _countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country['code'],
                        child: Text(country['name']!),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a nationality';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Text('Languages Spoken'),
                  DropdownButtonFormField<String>(
                    value: null,
                    onChanged: (String? value) {
                      setState(() {
                        if (value != null) {
                          _languages.add(value);
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
                    'Selected Languages: ${_languages.join(", ")}',
                    style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 224, 224, 224),
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contact Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _contactNumber = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Languages Spoken',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter the languages you speak';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     _languagesSpoken = value;
                  //   },
                  // ),

                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    items: _genders
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender == 'M' ? 'Male' : 'Female'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedUserType,
                    decoration: InputDecoration(
                      labelText: 'User Type',
                      border: OutlineInputBorder(),
                    ),
                    items: _userTypes
                        .map((userType) => DropdownMenuItem(
                              value: userType,
                              child:
                                  Text(userType == 'TR' ? 'Tourist' : 'Guide'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUserType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  (_selectedUserType == 'TR')
                      ? DropdownButtonFormField<String>(
                          value: _selectedExperience,
                          decoration: InputDecoration(
                            labelText: 'Experience',
                            border: OutlineInputBorder(),
                          ),
                          items: _experiences
                              .map((experience) => DropdownMenuItem(
                                    value: experience,
                                    child: Text(experience == 'N'
                                        ? 'Never Done'
                                        : experience == 'B'
                                            ? 'Beginner'
                                            : experience == 'S'
                                                ? 'Seasoned'
                                                : 'Professional'),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedExperience = value;
                            });
                          },
                        )
                      : Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Total Trek Count',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: '$_totalTrekCount',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                final intNumber = int.tryParse(value);
                                if (intNumber == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _totalTrekCount = int.parse(value!);
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<bool>(
                              decoration: InputDecoration(
                                labelText: 'Availability',
                                border: OutlineInputBorder(),
                              ),
                              value: _availability,
                              onChanged: (value) {
                                setState(() {
                                  _availability = value;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  value: true,
                                  child: Text('Available'),
                                ),
                                DropdownMenuItem(
                                  value: false,
                                  child: Text('Not Available'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an option';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _availability = value;
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        // print('Name: $_name');
                        // print('Email: $_email');
                        // print('Password: $_password');
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
