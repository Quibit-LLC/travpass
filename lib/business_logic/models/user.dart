class User {
  final int id; // If your API provides a unique user ID
  final String name;
  final String email;
  final String token;
  final double balance;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.balance,
  });

  //When receiving JSON responses from the server, you can create a User object using the fromJson factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      balance: json['balance'],
    );
  }

  //When sending user data to the server, you can convert the user object to JSON using the toJson method:
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': name,
      'email': email,
      'token': token,
      'balance':balance,
    };
  }
}