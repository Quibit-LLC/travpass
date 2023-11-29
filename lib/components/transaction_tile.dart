import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;

  const TransactionTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Josefin Sans',
              fontWeight: FontWeight.w500,
              height: 0.09,
            )),
        subtitle: Text(dateTime.day.toString() +
            '/' +
            dateTime.month.toString() +
            '/' +
            dateTime.year.toString()),
        trailing: Text(
          '\Kshs.' + amount,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Josefin Sans',
            fontWeight: FontWeight.w300,
            height: 0.09,
          ),
        ));
  }
}
