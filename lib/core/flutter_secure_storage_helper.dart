import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travpass/business_logic/models/user.dart';

class FlutterSecureStorageHelper {
  final FlutterSecureStorage _storage;

  FlutterSecureStorageHelper(this._storage);

  // Keys for storing user information
  static const String tokenKey = 'token';
  static const String idKey = 'id';
  static const String nameKey = 'userName';
  static const String emailKey = 'emailAddress';
  // static const String balanceKey = 'balance';
  static const String isLoggedInKey = 'isLoggedIn';

  // Function to save user information
  Future<void> saveUserInfo({
    required String token,
    required String id,
    required String userName,
    required String emailAddress,
    // required double balance,
    required bool isLoggedIn,
  }) async {
    await _storage.write(key: tokenKey, value: token);
    await _storage.write(key: idKey, value: id);
    await _storage.write(key: nameKey, value: userName);
    await _storage.write(key: emailKey, value: emailAddress);
    // await _storage.write(key: balanceKey, value: balance.toString());
    await _storage.write(key: isLoggedInKey, value: isLoggedIn.toString());
  }

  // Function to retrieve user details
  Future<User?> getUserDetails() async {
    final id = await _storage.read(key: idKey);
    final userName = await _storage.read(key: nameKey);
    final emailAddress = await _storage.read(key: emailKey);
    // final balance = await _storage.read(key: balanceKey);
    final token = await _storage.read(key: tokenKey);

    if (id != null &&
        userName != null &&
        emailAddress != null &&
        token != null 
        ) {
      return User(
        id: id,
        userName: userName,
        // balance: double.tryParse(balance) ?? 0.0, // Ensure balance is treated as a double
        emailAddress: emailAddress,
        token: token,
      );
    } else {
      return null;
    }
  }

  // Function to clear user information
  Future<void> clearUserInfo() async {
    await _storage.delete(key: tokenKey);
    await _storage.delete(key: idKey);
    await _storage.delete(key: nameKey);
    await _storage.delete(key: emailKey);
    // await _storage.delete(key: balanceKey);
    await _storage.delete(key: isLoggedInKey);
  }

  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: isLoggedInKey);

    return value?.toLowerCase() == 'true';
  }
}
