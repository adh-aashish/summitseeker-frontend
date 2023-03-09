import 'package:flutter/material.dart';
import 'package:frontend/services/register.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  // String? _dateOfBirth;
  String? _contactNumber;
  String? _languagesSpoken;
  String? _firstName;
  String? _lastName;
  bool? _availability = true;
  // int _totalTrekCount = 0;
  String _nationality = 'US'; // default value for nationality dropdown
  final List<String> _languages = []; // selected languages will be stored here
  final TextEditingController _dobController = TextEditingController();

  // List of countries for nationality dropdown
  bool isLoading = true;
  Map registrationDetail = {};
  void getRegistrationDetail() async {
    try {
      List responseLanguage = await getLanguages();
      List responseCountries = await getCountries();

      setState(() {
        if (responseLanguage[0]) {
          registrationDetail["languages"] = responseLanguage[1];
        } else if (responseLanguage[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, responseLanguage[1]);
        }

        if (responseCountries[0]) {
          registrationDetail["countries"] = responseCountries[1];
        } else if (responseCountries[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, responseCountries[1]);
        }
        isLoading = false;
      });
    } catch (e) {
      // snackbar
      showSnackBar(false, e.toString());
    }
  }

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
  }

  @override
  void initState() {
    super.initState();
    getRegistrationDetail();
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  final List<String> _genders = ['M', 'F', 'O', 'R'];
  final List<String> _userTypes = ['TR', 'GD'];
  final List<String> _experiences = ['N', 'B', 'S', 'P'];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
          ),
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
              : Form(
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
                          decoration:
                              const InputDecoration(labelText: 'Password'),
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
                          decoration: const InputDecoration(
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

                        DropdownButtonFormField<String>(
                          value: null,
                          decoration: const InputDecoration(
                            labelText: 'Nationality',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              if (value != null) {
                                _nationality = value;
                              }
                            });
                          },
                          items: registrationDetail['countries']
                              .map<DropdownMenuItem<String>>((country) {
                            return DropdownMenuItem<String>(
                              value: country['countryCode'].toString(),
                              child: Text(country['countryName'].toString()),
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
                          items: registrationDetail["languages"]
                              .map<DropdownMenuItem<String>>((language) {
                            return DropdownMenuItem<String>(
                              value: language['languageCode'].toString(),
                              child: Text(language['languageName'].toString()),
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

                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(),
                          ),
                          items: _genders
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender == 'M'
                                        ? 'Male'
                                        : gender == 'F'
                                            ? 'Female'
                                            : gender == 'O'
                                                ? 'Other'
                                                : 'Rather Not Say'),
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
                          decoration: const InputDecoration(
                            labelText: 'User Type',
                            border: OutlineInputBorder(),
                          ),
                          items: _userTypes
                              .map((userType) => DropdownMenuItem(
                                    value: userType,
                                    child: Text(
                                        userType == 'TR' ? 'Tourist' : 'Guide'),
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
                                decoration: const InputDecoration(
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
                                  const SizedBox(height: 20),
                                  DropdownButtonFormField<bool>(
                                    decoration: const InputDecoration(
                                      labelText: 'Availability',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _availability,
                                    onChanged: (value) {
                                      setState(() {
                                        _availability = value;
                                      });
                                    },
                                    items: const [
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
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              Registration reg = Registration(
                                  email: _email,
                                  password: _password,
                                  gender: _selectedGender,
                                  userType: _selectedUserType,
                                  experience: _selectedExperience,
                                  dateOfBirth: _dobController.text,
                                  contactNumber: _contactNumber,
                                  languagesSpoken: _languagesSpoken,
                                  firstName: _firstName,
                                  lastName: _lastName,
                                  availability: _availability,
                                  nationality: _nationality,
                                  languages: _languages);
                              try {
                                List res = await reg.createUser();
                                if (res[0]) {
                                  showSnackBar(true, "Login now");
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (route) => false,
                                  );
                                } else {
                                  showSnackBar(false, res[1]);
                                }
                              } catch (e) {
                                showSnackBar(false, e.toString());
                              }
                            }
                          },
                          child: const Text('Submit'),
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
