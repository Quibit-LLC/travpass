import 'package:intl/intl.dart';

class Transaction {
  final String transactionId;
  final DateTime timestamps;
  final String fareValue;
  final String routeName;
  final String passengerId;
  final String conductorId;
  // final String tripId;

  Transaction({
    required this.transactionId,
    required this.timestamps,
    required this.fareValue,
    required this.routeName,
    required this.passengerId,
    required this.conductorId,
    // required this.tripId,
  });

  // Use the ? operator to indicate that the parameter can be null
  factory Transaction.fromJson(Map<String, dynamic>? json) {
    // Use the ?? operator to provide a default value in case the parameter is null
    json ??= {};
    return Transaction(
      // Use the ?? operator to provide a default value in case the map entry is null
      transactionId: json['transactionID'] ?? '',
      // Use the ?? operator to provide a default value in case the map entry is null
      // Use the ! operator to assert that the map entry is not null after the ?? operator
      timestamps: DateTime.parse(json['created_at'] ?? '2023-11-27T05:11:21'),
      // Use the ?? operator to provide a default value in case the map entry is null
      // Use the toDouble() method to convert the map entry to a double
      fareValue: json['fareValue'] ?? '0',

      // Use the ?? operator to provide a default value in case the map entry is null
      routeName: json['routeName'] ?? '',
      // Use the ?? operator to provide a default value in case the map entry is null
      passengerId: json['passengerID'] ?? '',
      // Use the ?? operator to provide a default value in case the map entry is null
      conductorId: json['conductorID'] ?? '',
      // tripId: json['tripId'] ?? '',
    );
  }
  // A method that returns the formatted timestamp
  String getFormattedTimestamp() {
    // Create a DateFormat object with the desired pattern
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    // Format the timestamp field and return the result
    return formatter.format(timestamps);
  }
}
