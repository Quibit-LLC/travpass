// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travpass/bar%20graph/bar_graph.dart';
import 'package:travpass/data/transaction_data.dart';
import 'package:travpass/datetime/date_time_helper.dart';

class TransactionSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const TransactionSummary({
    Key? key,
    required this.startOfWeek,
  }) : super(key: key);

  double calculateMax(
      TransactionData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyTransactionSummary()[sunday] ?? 0,
      value.calculateDailyTransactionSummary()[monday] ?? 0,
      value.calculateDailyTransactionSummary()[tuesday] ?? 0,
      value.calculateDailyTransactionSummary()[thursday] ?? 0,
      value.calculateDailyTransactionSummary()[friday] ?? 0,
      value.calculateDailyTransactionSummary()[saturday] ?? 0,
    ];

    // sort from smallest to largest(which is at the end of the sorted list)
    values.sort();

    // get largest amount
    // and increase the cap slightly so the graph looks almost full

    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  // calculate the week total
  String calculateWeekTotal(
      TransactionData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    List<double> values = [
      value.calculateDailyTransactionSummary()[sunday] ?? 0,
      value.calculateDailyTransactionSummary()[monday] ?? 0,
      value.calculateDailyTransactionSummary()[tuesday] ?? 0,
      value.calculateDailyTransactionSummary()[thursday] ?? 0,
      value.calculateDailyTransactionSummary()[friday] ?? 0,
      value.calculateDailyTransactionSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<TransactionData>(
      builder: (context, value, child) => Column(
        children: [
          // week total
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Text("Week Total: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w400,
                      // height: 0.09,
                    )),
                Text(
                    "\Kshs. " +
                        calculateWeekTotal(value, sunday, monday, tuesday,
                            wednesday, thursday, friday, saturday),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w500,
                      // height: 0.09,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                  thursday, friday, saturday),
              sunAmount: value.calculateDailyTransactionSummary()[sunday] ?? 0,
              monAmount: value.calculateDailyTransactionSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyTransactionSummary()[tuesday] ?? 0,
              wedAmount:
                  value.calculateDailyTransactionSummary()[wednesday] ?? 0,
              thurAmount:
                  value.calculateDailyTransactionSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyTransactionSummary()[friday] ?? 0,
              satAmount:
                  value.calculateDailyTransactionSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
