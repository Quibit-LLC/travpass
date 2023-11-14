import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travpass/business_logic/models/user.dart';

class FlutterSecureStorageHelper {
  final FlutterSecureStorage _storage;

  FlutterSecureStorageHelper(this._storage);


  // Keys for storing user information
  static const String tokenKey = 'token';
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String isLoggedInKey = 'isLoggedIn';
 

  // Function to save user information
  Future<void> saveUserInfo({
    required String token,
    required String id,
    required String name,
    required String email,
    required bool isLoggedIn,
  }) async {
    await _storage.write(key: tokenKey, value: token);
    await _storage.write(key: idKey, value: id);
    await _storage.write(key: nameKey, value: name);
    await _storage.write(key: emailKey, value: email);
    await _storage.write(key: isLoggedInKey, value: isLoggedIn.toString());
  }


  // Function to retrieve user details
  Future<User?> getUserDetails() async {
    final id = await _storage.read(key: idKey);
    final name = await _storage.read(key: nameKey);
    final email = await _storage.read(key: emailKey);
    final token = await _storage.read(key: tokenKey);

    if (id != null && name != null && email != null && token != null) {
      return User(
          // id: id,
          id: int.tryParse(id) ?? 0, // Convert id to int or use a default value
          name: name,
          email: email,
          token: token);
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
    await _storage.delete(key: isLoggedInKey);
  }

  // Function to check login status
  // Future<bool> isLoggedIn() async {
  //   final value = await _storage.read(key: isLoggedInKey);
  //   return value != null && value == 'true';
  // }

  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: isLoggedInKey);
    // if (value != null && value == 'true') {
    //   return true;
    // } else {
    //   return false;
    // }
    return value?.toLowerCase() == 'true';
  }





}