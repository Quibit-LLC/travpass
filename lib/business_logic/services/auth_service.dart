import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:travpass/business_logic/api/api_constants.dart';
import 'package:travpass/business_logic/models/transaction.dart';
import 'package:travpass/business_logic/models/user.dart';
import 'package:travpass/core/shared_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  // final FlutterSecureStorage _storage;
  SharedPreferences _prefs;

  bool _isLoggedIn = false;

  User? _loggedInUser;

  AuthService(this._prefs);

  bool get isLoggedIn => _isLoggedIn;

  User? get loggedInUser => _loggedInUser;

  Future<void> checkLoginStatus() async {
    _isLoggedIn = SharedPrefHelper(_prefs).isLoggedIn();
    notifyListeners();
  }

  //login user
  Future<String> loginUser(Map<String, dynamic> body) async {
    String res = "";
    try {
      // Call the API to authenticate the user
      if (body.containsKey('saccoID')) {
        var url = Uri.parse(ApiConstants.conductorSignInUrl);
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
        // print(response.body);

        // Check if authentication was successful
        if (response.statusCode == 200) {
          // print('body: [${response.body}]');
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            // Get the token and user details from the response
            final token = json['data']['token'];
            final conductorID = json['data']['conductor']['conductorID'];
            final userName = json['data']['conductor']['userName'];
            final emailAddress = json['data']['conductor']['emailAddress'];
            // final balance = json['data']['conductor']['balance'];

            // Store the token and user details using SharedPrefHelper
            await SharedPrefHelper(_prefs).saveUserInfo(
              token: token,
              id: conductorID,
              userName: userName,
              emailAddress: emailAddress,
              // balance: balance,
              isLoggedIn: true,
            );
            // print(emailAddress);
            // Update the AuthProvider state
            _isLoggedIn = true;

            res = "ok";
          } else {
            // Authentication failed
            res = jsonDecode(response.body)["message"];
            // print("Status code: ${response.statusCode}");
          }
        } else {
          res =
              jsonDecode(response.body)["message"] ?? "Unknown error occurred";
        }
      } else {
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
        // print(response.body);

        // Check if authentication was successful
        if (response.statusCode == 200) {
          // print('body: [${response.body}]');
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            // Get the token and user details from the response
            final token = json['data']['token'];
            final passengerID = json['data']['passenger']['passengerID'];
            final userName = json['data']['passenger']['userName'];
            final emailAddress = json['data']['passenger']['emailAddress'];
            // final balance = json['data']['passenger']['balance'];
            //print(userName);
            // Store the token and user details using SharedPrefHelper
            await SharedPrefHelper(_prefs).saveUserInfo(
              token: token,
              id: passengerID,
              userName: userName,
              emailAddress: emailAddress,
              // balance: balance,
              isLoggedIn: true,
            );
            // print(emailAddress);
            // Update the AuthProvider state
            _isLoggedIn = true;

            res = "ok";
          } else {
            // Authentication failed
            res = jsonDecode(response.body)["message"];
          }
        } else {
          res =
              jsonDecode(response.body)["message"] ?? "Unknown error occurred";
        }
      }
    } catch (e) {
      if (e is SocketException) {
        res =
            "Unable to connect to the network. Please check your internet connection and try again.";
      } else if (e is FormatException || e is JsonUnsupportedObjectError) {
        res = "Unknown error occurred";
      } else {
        print("Error in loginUser: $e");
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
      if (body.containsKey('saccoID')) {
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
        if (response.statusCode == 201) {
          final json = jsonDecode(response.body);

          if (json['status'] != 'success') {
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
          res = jsonDecode(response.body)["data"] ?? "Unknown error occurred";
        }
      } else {
        // Call the API to authenticate the user
        var url = Uri.parse(ApiConstants.passengerSignUpUrl);
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
        if (response.statusCode == 201) {
          final json = jsonDecode(response.body);

          if (json['status'] != 'success') {
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
          res =
              jsonDecode(response.body)["message"] ?? "Unknown error occurred";
        }
      }
    } catch (e) {
      if (e is SocketException) {
        res =
            "Unable to connect to the network. Please check your internet connection and try again.";
      } else if (e is FormatException || e is JsonUnsupportedObjectError) {
        res = "Unknown error occurred";
      } else {
        print("Error in loginUser: $e");
        res = "An error occurred while authenticating the user";
      }
    }

    // Notify the listeners
    notifyListeners();
    return res;
  }

  Future<String> initiateTransaction(Map<String, dynamic> body) async {
    String res = "";
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.transactionUrl),
        body: jsonEncode(body),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Transaction successful
        print(jsonDecode(response.body)['status']);
        res = "ok";
      } else {
        res = jsonDecode(response.body)["message"] ?? "Unknown error occurred";
      }
    } catch (e) {
      if (e is SocketException) {
        res =
            "Unable to connect to the network. Please check your internet connection and try again.";
      } else if (e is FormatException || e is JsonUnsupportedObjectError) {
        res = "Unknown error occurred";
      } else {
        print("Error in transaction: $e");
        res = "An error occurred while initiating transaction";
      }
    }

    // Notify the listeners
    notifyListeners();
    return res;
  }
Future<List<Transaction>> fetchTransactions(String userId) async {
  final response = await http.get(Uri.parse('${ApiConstants.getTransactionsUrl}/userId'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response,
    // parse the transactions from the response.
    Iterable jsonResponse = json.decode(response.body);
    return jsonResponse.map((transaction) => Transaction.fromJson(transaction)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // throw an exception.
    throw Exception('Failed to load transactions');
  }
}

  Future<void> logout() async {
    await SharedPrefHelper(_prefs).clearUserInfo();
    _isLoggedIn = false;
    notifyListeners();
  }
}
