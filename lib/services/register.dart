// import 'dart:html';
// import 'dart:io';

import "package:http/http.dart" as http;
import "dart:convert";

class Registration {
  String? email;
  String? password;
  String? gender;
  String? userType = 'TR';
  String? experience;
  String? dateOfBirth;
  String? contactNumber;
  String? languagesSpoken;
  String? firstName;
  String? lastName;
  bool? availability = true;
  // update api to remove this
  int totalTrekCount = 0;
  String? nationality = 'US'; // default value for nationality dropdown
  List<String> languages = []; // selected languages will be stored here

  Registration(
      {this.email,
      this.password,
      this.gender,
      this.userType,
      this.experience,
      this.dateOfBirth,
      this.contactNumber,
      this.languagesSpoken,
      this.firstName,
      this.lastName,
      this.availability,
      required this.nationality,
      required this.languages});

  Future<List> createUser() async {
    List res = [];
    try {
      Map reqBody = {
        "email": email,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "nationality": nationality,
        "password": password,
        "contactNum": contactNumber,
        "languages": languages,
        "first_name": firstName,
        "last_name": lastName,
        "userType": userType,
      };

      if (userType == "TR") {
        if (experience != null) {
          reqBody["experience"] = experience;
        }
      } else {
        if (availability != null) {
          reqBody["availability"] = availability;
        }
      }

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.post(
        Uri.parse('http://74.225.249.44/api/user/register/'),
        body: jsonEncode(reqBody),
        headers: requestHeaders,
        encoding: Encoding.getByName('utf-8'),
      );
      final body = jsonDecode(response.body);
      if (body["token_invalid"]) {
        res = [false, "token_invalid"];
        // return "Invalid Token";
      }
      if (body["success"]) {
        res = [true, "Successful"];
      } else {
        if (body["validation_error"]) {
          res = [false, body["errors"]];
        } else {
          res = [false, body["message"]];
        }
      }
    } catch (e) {
      res = [false, e.toString()];
    }
    return res;
  }
}

Future<List> getLanguages() async {
  List languages = [];
  try {
    var response = await http.get(
      Uri.parse('http://74.225.249.44/api/languages'),
    );
    final body = await jsonDecode(response.body);
    if (body["success"]) {
      languages = [true, body["data"]];
    } else {
      if (body["validation_error"]) {
        languages = [false, body["errors"]];
      } else {
        languages = [false, body["message"]];
      }
    }
  } catch (e) {
    languages = [false, e.toString()];
  }
  return languages;
}

Future<List> getCountries() async {
  List countries = [];
  try {
    var response = await http.get(
      Uri.parse('http://74.225.249.44/api/countries'),
    );
    final body = await jsonDecode(response.body);
    if (body["success"]) {
      countries = [true, body["data"]];
    } else {
      if (body["validation_error"]) {
        countries = [false, body["errors"]];
      } else {
        countries = [false, body["message"]];
      }
    }
    return countries;
  } catch (e) {
    return countries = [false, e.toString()];
  }
}
