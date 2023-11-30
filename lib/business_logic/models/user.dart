class User {
  final String id; // If your API provides a unique user ID
  final String userName;
  final String emailAddress;
  final String token;
  final String balance;

  User({
    required this.id,
    required this.userName,
    required this.emailAddress,
    required this.token,
    required this.balance,
  });

  //When receiving JSON responses from the server, you can create a User object using the fromJson factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      emailAddress: json['emailAddress'],
      token: json['token'],
      balance: json['balance'],
    );
  }

  //When sending user data to the server, you can convert the user object to JSON using the toJson method:
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'emailAddress': emailAddress,
      'token': token,
      // 'balance': balance,
    };
  }
}
