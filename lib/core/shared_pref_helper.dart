import 'package:travpass/business_logic/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences _prefs;

  //constructor
  SharedPrefHelper(this._prefs);

  // Keys for storing user information
  static const String tokenKey = 'token';
  static const String idKey = 'id';
  static const String nameKey = 'userName';
  static const String emailKey = 'emailAddress';
  static const String isLoggedInKey = 'isLoggedIn';
  static const String balanceKey = 'balance';
   static const String phoneKey = 'phoneNumber';

  // Function to save user information
  Future<void> saveUserInfo({
    required String token,
    required String id,
    required String userName,
    required String emailAddress,
    required String balance,
    required String phoneNumber,
    required bool isLoggedIn,
  }) async {
    try {
      await _prefs.setString(tokenKey, token);
      await _prefs.setString(idKey, id);
      await _prefs.setString(nameKey, userName);
      await _prefs.setString(emailKey, emailAddress);
      await _prefs.setString(balanceKey, balance);
      await _prefs.setBool(isLoggedInKey, isLoggedIn);
      await _prefs.setString(phoneKey, phoneNumber);
    } catch (e) {
      print("Error saving user info to SharedPreferences: $e");
      // Handle the error appropriately, e.g., throw an exception or log it.
    }
  }

  // Function to retrieve user details
  Future<User?> getUserDetails() async {
    final id = _prefs.getString(idKey);
    final userName = _prefs.getString(nameKey);
    final emailAddress = _prefs.getString(emailKey);
    final token = _prefs.getString(tokenKey);
    final balance = _prefs.getString(balanceKey);
    final phoneNumber = _prefs.getString(phoneKey);

    if (id != null &&
        userName != null &&
        emailAddress != null &&
        token != null &&
        balance != null &&
        phoneNumber != null) {
      return User(
        id: id,
        userName: userName,
        emailAddress: emailAddress,
        token: token,
        balance: balance,
        phoneNumber: phoneNumber,
      );
    } else {
      return null;
    }
  }

  // Function to clear user information
  Future<void> clearUserInfo() async {
    await _prefs.remove(tokenKey);
    await _prefs.remove(idKey);
    await _prefs.remove(nameKey);
    await _prefs.remove(emailKey);
    await _prefs.remove(balanceKey);
    await _prefs.setBool(isLoggedInKey, false);
  }

  // Function to check login status
  bool isLoggedIn() {
    return _prefs.getBool(isLoggedInKey) ?? false;
  }
}
