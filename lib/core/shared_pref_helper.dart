import 'package:travpass/business_logic/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences _prefs;

  //constructor
  SharedPrefHelper(this._prefs);

  // Keys for storing user information
  static const String tokenKey = 'token';
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String isLoggedInKey = 'isLoggedIn';
  static const String balanceKey = 'balance';

  // Function to save user information
  Future<void> saveUserInfo({
    required String token,
    required String id,
    required String userName,
    required String email,
    required double balance,
    required bool isLoggedIn,
  }) async {
    print(email);
    await _prefs.setString(tokenKey, token);
    await _prefs.setString(idKey, id);
    await _prefs.setString(nameKey, userName);
    await _prefs.setString(emailKey, email);
    await _prefs.setDouble(balanceKey, balance);
    await _prefs.setBool(isLoggedInKey, isLoggedIn);
    print(userName);
  }

  // Function to retrieve user details
  Future<User?> getUserDetails() async {
    final id = _prefs.getString(idKey);
    final userName = _prefs.getString(nameKey);
    final email = _prefs.getString(emailKey);
    final token = _prefs.getString(tokenKey);
    final balance = _prefs.getString(balanceKey);

    if (id != null && userName != null && email != null && token != null) {
      return User(
        id: int.tryParse(id) ?? 0, // Convert id to int or use a default value
        name: userName,
        email: email,
        token: token,
        balance: double.tryParse(balance!) ?? 0,
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
    await _prefs.remove(isLoggedInKey);
  }

  // Function to check login status
  bool isLoggedIn() {
    return _prefs.getBool(isLoggedInKey) ?? false;
  }
}
