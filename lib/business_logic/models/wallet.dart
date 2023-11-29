class Wallet {
  String walletID;
  String balance;
  String passengerID;
  String conductorID;
  String ownerType;

  Wallet({
    required this.walletID,
    required this.balance,
    required this.passengerID,
    required this.conductorID,
    required this.ownerType,
  });

  factory Wallet.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    
    return Wallet(
      walletID: json['walletID'] ?? '',
      balance: json['balance'] ?? '',
      passengerID: json['passenger_id'] ?? '',
      conductorID: json['conductor_id'] ?? '',
      ownerType: json['owner_type'] ?? '',
    );
  }
}
