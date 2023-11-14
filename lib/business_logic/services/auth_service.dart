import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:travpass/business_logic/api/api_constants.dart';
import 'package:travpass/business_logic/models/user.dart';
import 'package:travpass/core/flutter_secure_storage_helper.dart';
import 'package:travpass/core/shared_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  // final FlutterSecureStorage _storage;
  final SharedPreferences _prefs;

  bool _isLoggedIn = false;

  User? _loggedInUser;

  AuthService(this._prefs);

  bool get isLoggedIn => _isLoggedIn;

  User? get loggedInUser => _loggedInUser;

  // Future<void> checkLoginStatus() async {
  //   final value = _prefs.getBool('isLoggedIn') ?? false;
  //   _isLoggedIn = value;
  //   notifyListeners();
  // }
  //
  // Future<void> checkIsIntroViewed() async {
  //   final value = _prefs.getBool('isIntroViewed') ?? false;
  //   _isIntroViewed = value;
  //   notifyListeners();
  // }

  Future<void> checkLoginStatus() async {
    _isLoggedIn = SharedPrefHelper(_prefs).isLoggedIn();
    notifyListeners();
  }

 
  //login user
  Future<String> loginUser(Map<String, dynamic> body) async {
    String res = "";
    try {
      // Call the API to authenticate the user
      var url = Uri.parse(ApiConstants.signInUrl);
      var headers = {
        'accept': 'application/json',
        'content-type': 'application/json'
      };

      //post data to api using HTTP
      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      // Check if authentication was successful
      if (response.statusCode == 200) {
        // print('body: [${response.body}]');
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          res = "ok";

          // Get the token and user details from the response
          final token = json['token'];
          final id = json['data']['id'];
          final name = json['data']['name'];
          final email = json['data']['email'];

          // Store the token and user details using SharedPrefHelper
          await SharedPrefHelper(_prefs).saveUserInfo(
            token: token,
            id: id.toString(),
            name: name,
            email: email,
            isLoggedIn: true,
          );

          // Update the AuthProvider state
          _isLoggedIn = true;
        } else {
          // Authentication failed
          res = jsonDecode(response.body)["message"];
          // print("Status code: ${response.statusCode}");
        }
      } else {
        res = jsonDecode(response.body)["message"] ?? "Unknown error occurred";
      }
    } catch (e) {
      if (e is SocketException) {
        // res = "Network error occurred";
        res = "Unable to connect to the network. Please check your internet connection and try again.";
      } else if (e is FormatException || e is JsonUnsupportedObjectError) {
        res = "Unknown error occurred";
        // print("=------------------> ${res.toString()}");
      } else {
        res = "An error occurred while authenticating the user";
      }
    }

    // Notify the listeners
    notifyListeners();
    return res;
  }


  Future<String> signUpUser(Map<String, dynamic> body) async {
    String res = "";

    try {
      // Call the API to authenticate the user
      var url = Uri.parse(ApiConstants.signUpUrl);
      var headers = {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

      // Post data to the API using HTTP
      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      print("=------------------> ${response.statusCode}");
      print("=------------------> ${response.body}");

      // Check the response status code
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == false) {
          res = json['message'];


          // Check for specific errors in the "errors" field
          if (json.containsKey('errors')) {
            Map<String, dynamic> errors = json['errors'];
            errors.forEach((field, errorList) {
              // Capitalize the first letter of each word and replace underscores with spaces
              String formattedField = field.splitMapJoin('_',
                  onMatch: (m) => ' ',
                  onNonMatch: (n) =>
                  n.isEmpty ? '' : n[0].toUpperCase() + n.substring(1));

              for (var error in errorList) {
                res += " $formattedField Error: $error";
              }
            });
          }


        } else {
          res = "ok"; // Sign-up was successful
        }
      } else {
        res = jsonDecode(response.body)["message"] ?? "Unknown error occurred";
      }
    } catch (e) {
      if (e is SocketException) {
        res = "Unable to connect to the network. Please check your internet connection and try again.";
      } else if (e is FormatException || e is JsonUnsupportedObjectError) {
        res = "Unknown error occurred";
      } else {
        res = "An error occurred while authenticating the user";
      }
    }

    // Notify the listeners
    notifyListeners();
    return res;
  }

}