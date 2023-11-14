import 'package:flutter/material.dart';
import 'package:travpass/data/hive_database.dart';
import 'package:travpass/datetime/date_time_helper.dart';
import 'package:travpass/business_logic/models/transactions.dart';

class TransactionData extends ChangeNotifier {
  // list of all transactions
  List<TransactionItem> overallTransactionList = [];

  // get transaction list
  List<TransactionItem> getAllTransactionList() {
    return overallTransactionList;
  }

  // prepare data to display
  final db = HiveDataBase();
  void prepareData() {
    // if there exists data, get it
    if (db.readData().isNotEmpty) {
      overallTransactionList = db.readData();
    }
  }

  // add a new transaction
  void addNewTransaction(TransactionItem newTransaction) {
    overallTransactionList.add(newTransaction);

    notifyListeners();
    db.saveData(overallTransactionList);
  }
  // delete transaction*

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
      String date = convertDateTimeToString(transaction.dateTime);
      double amount = double.parse(transaction.amount);

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
