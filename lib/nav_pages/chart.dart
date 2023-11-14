import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travpass/components/transaction_summary.dart';
import 'package:travpass/components/transaction_tile.dart';
import 'package:travpass/data/transaction_data.dart';
import 'package:travpass/business_logic/models/transactions.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final newTransactionNameController = TextEditingController();
  final newTransactionAmountController = TextEditingController();

  void initState() {
    super.initState();
    // prepare data on startup

    Provider.of<TransactionData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newTransactionNameController,
            ),
            TextField(
              controller: newTransactionAmountController,
            ),
          ],
        ),
        actions: [
          MaterialButton(onPressed: save, child: Text("Save")),
          MaterialButton(onPressed: cancel, child: Text("Cancel")),
        ],
      ),
    );
  }

  void save() {
    // only save if all fields are filled
    if (newTransactionNameController.text.isNotEmpty &&
        newTransactionAmountController.text.isNotEmpty) {
      TransactionItem newTransaction = TransactionItem(
          name: newTransactionNameController.text,
          amount: newTransactionAmountController.text,
          dateTime: DateTime.now());
      Provider.of<TransactionData>(context, listen: false)
          .addNewTransaction(newTransaction);
    }
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newTransactionAmountController.clear();
    newTransactionNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: addNewExpense,
            child: Icon(Icons.add)),
        body: ListView(
          children: [
            TransactionSummary(
              startOfWeek: value.startofWeekDate(),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.getAllTransactionList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllTransactionList()[index].name,
                dateTime: value.getAllTransactionList()[index].dateTime,
                amount: value.getAllTransactionList()[index].amount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
