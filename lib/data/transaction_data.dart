import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travpass/business_logic/api/api_constants.dart';
import 'package:travpass/business_logic/models/user.dart';
import 'package:travpass/core/shared_pref_helper.dart';
// import 'package:travpass/data/hive_database.dart';
import 'package:travpass/datetime/date_time_helper.dart';
import 'package:travpass/business_logic/models/transactions.dart';
// import 'package:travpass/nav_pages/conductor_dashboard.dart';

late Future<User?> userFuture;

class TransactionData extends ChangeNotifier {
  // list of all transactions
  List<TransactionItem> overallTransactionList = [];

  // get transaction list
  List<TransactionItem> getAllTransactionList() {
    return overallTransactionList;
  }

  // prepare data to display
  Future<List<TransactionItem>> prepareData(String userId) async {
    final response =
        await http.get(Uri.parse('${ApiConstants.getTransactionsUrl}/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> transactionList = json.decode(response.body);
      // print(transactionList);
      overallTransactionList = transactionList
          .map((transaction) => TransactionItem.fromJson(transaction))
          .toList();
      notifyListeners();
      // Return the list of transactions
      return overallTransactionList;
    } else {
      // Throw an exception if the status code is not 200
      throw Exception('Failed to load transactions');
    }
  }

  Future<User?> getUserDetails() async {
    return SharedPrefHelper(await SharedPreferences.getInstance())
        .getUserDetails();
  }

  //get weekday, from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get the date for the start of the week
  DateTime startofWeekDate() {
    DateTime? startOfWeek;

    //get Today's date
    DateTime today = DateTime.now();

    //go backwards from today to find Sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;

    /*
  convert overall list of transactions into a daily/weekly/monthly expense summary
  */
  }

  Map<String, double> calculateDailyTransactionSummary() {
    Map<String, double> dailyTransactionSummary = {
      // date(yyyymmdd) : amountTotalForDay
    };

    for (var transaction in overallTransactionList) {
      String date = convertDateTimeToString(transaction.timestamps);
      double amount = double.parse(transaction.fareValue);

      if (dailyTransactionSummary.containsKey(date)) {
        double currentAmount = dailyTransactionSummary[date]!;
        currentAmount += amount;
        dailyTransactionSummary[date] = currentAmount;
      } else {
        dailyTransactionSummary.addAll({date: amount});
      }
    }

    return dailyTransactionSummary;
  }
}
