class ApiConstants {
  static String localUrl1 = 'http://127.0.0.1:8000/api';
  static String localUrl = 'http://192.168.56.1:8000/api';

  static String liveUrl = 'https://96af-41-204-187-5.ngrok-free.app/api';

  static String baseUrl = localUrl;
  static String signInUrl = '$baseUrl/passengerLogin';
  static String conductorSignInUrl = '$baseUrl/login';

  static String signUpUrl = '$baseUrl/register';
  static String passengerSignUpUrl = '$baseUrl/passengerRegister';

  static String transactionUrl = '$baseUrl/initiateTransaction';

  static String getTransactionsUrl = '$baseUrl/allTransactions';

  static String getWalletUrl = '$baseUrl/walletDetails';

  static String updatePassengerUrl = '$baseUrl/updatePassenger';

  static String updateConductorUrl = '$baseUrl/updateConductor';
}
