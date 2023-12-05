import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travpass/business_logic/models/user.dart';
import 'package:travpass/components/transaction_summary.dart';
import 'package:travpass/components/transaction_tile.dart';
import 'package:travpass/core/shared_pref_helper.dart';
import 'package:travpass/data/transaction_data.dart';
// import 'package:travpass/business_logic/models/transactions.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Future<User?> userFuture;
  late String userId;

  _StatisticsPageState() {
    userFuture = getUserDetails();
  }

  @override
  void initState() {
    super.initState();
    // You can access userId here and call prepareData
    userFuture.then((user) {
      userId = user?.id ?? '';
      Provider.of<TransactionData>(context, listen: false).prepareData(userId);
    });
  }

  Future<User?> getUserDetails() async {
    return SharedPrefHelper(await SharedPreferences.getInstance())
        .getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[100],
        body: FutureBuilder<User?>(
          future: userFuture,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (userSnapshot.hasError) {
              return Center(child: Text('Error: ${userSnapshot.error}'));
            } else {
              return ListView(
                children: [
                  TransactionSummary(
                    startOfWeek: value.startofWeekDate(),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getAllTransactionList().length,
                    itemBuilder: (context, index) => TransactionTile(
                      name: value.getAllTransactionList()[index].routeName,
                      dateTime: value.getAllTransactionList()[index].timestamps,
                      amount: value
                          .getAllTransactionList()[index]
                          .fareValue
                          .toString(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
