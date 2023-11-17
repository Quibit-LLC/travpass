class ApiConstants {
  static String localUrl1 = 'http://127.0.0.1:8000/api';
  static String localUrl = 'http://192.168.56.1:8000/api';
  // static String localUrl = 'http://127.0.0.1:8000';
  // static String localUrl = 'http://192.168.38.1:8000';
  static String liveUrl = 'https://jkeja.vansible.com/api';

  static String baseUrl = localUrl;
  static String signInUrl = '$baseUrl/passengerLogin';
  static String conductorSignInUrl = '$baseUrl/login';

  static String signUpUrl = '$baseUrl/register';
  static String passengerSignUpUrl = '$baseUrl/passengerRegister';
}
