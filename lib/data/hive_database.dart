import 'package:hive_flutter/hive_flutter.dart';
import 'package:travpass/business_logic/models/transactions.dart';

class HiveDataBase {
  // reference the box
  final _myBox = Hive.box("Transaction_Database");

// wrire data
  void saveData(List<TransactionItem> allTransaction) {
    // Hive can only store strings, dateTime, and not CustomObjects like TransactionItem
    // So we convert TransactionItem objects into types that can be stored

    List<List<dynamic>> allTransactionsFormatted = [];

    for (var transaction in allTransaction) {
      List<dynamic> transactionFormatted = [
        transaction.routeName,
        transaction.fareValue,
        transaction.timestamps,
      ];
      allTransactionsFormatted.add(transactionFormatted);
    }

    // finally store
    _myBox.put("ALL_TRANSACTIONS", allTransactionsFormatted);
  }

  // read data
  List<TransactionItem> readData() {
    List savedTransactions = _myBox.get("ALL_TRANSACTIONS") ?? [];
    List<TransactionItem> allTransactions = [];

    for (int i = 0; i < savedTransactions.length; i++) {
      // collect individual transaction data
      // String name = savedTransactions[i][0];
      // String amount = savedTransactions[i][1];
      // DateTime dateTime = savedTransactions[i][2];

      // create transactionitem
      // TransactionItem transaction =
      //     TransactionItem(routeName: name, fareValue: amount, timestamps: dateTime);

      // add transaction to overall list of transactions
      // allTransactions.add(transaction);
    }

    return allTransactions;
  }
}
