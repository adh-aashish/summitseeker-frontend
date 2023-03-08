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

  Future<String> createUser() async {
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

      // print(reqBody);
      var response = await http.post(
        Uri.parse('http://74.225.249.44/api/user/register/'),
        body: reqBody,
      );
      final body = jsonDecode(response.body);
      if (body["token_invalid"]) {
        return "Invalid Token";
      }
      if (body["success"]) {
        // Save the token in the shared preferences or secure storage
        return "Successful";
      } else {
        if (body["validation_error"]) {
          return "Validation Error";
        } else {
          return body["message"];
        }
      }
    } catch (e) {
      return e.toString();
    }
  }
}
