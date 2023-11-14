class ApiConstants {
  static String localUrl1 = 'http://127.0.0.1:8000/api';
  static String localUrl = 'http://192.168.1.107:8000';
  // static String localUrl = 'http://127.0.0.1:8000';
  // static String localUrl = 'http://192.168.38.1:8000';
  static String liveUrl = 'https://jkeja.vansible.com/api';

  static String baseUrl = localUrl;
  static String signInUrl = '$baseUrl/users/auth/sign-in/';
  static String signUpUrl = '$baseUrl/users/auth/sign-up/';

}
