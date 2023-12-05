import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travpass/business_logic/api/api_constants.dart';
import 'package:travpass/business_logic/models/transaction.dart';
import 'package:travpass/business_logic/models/user.dart';

import 'package:travpass/core/shared_pref_helper.dart';

class ConductorDashboard extends StatefulWidget {
  const ConductorDashboard({super.key});

  @override
  State<ConductorDashboard> createState() => _ConductorDashboardState();
}

class _ConductorDashboardState extends State<ConductorDashboard> {
  late Future<User?> userFuture;
  late Future<List<Transaction>> transactionFuture;

  _ConductorDashboardState() {
    userFuture = getUserDetails();
  }
  Future<List<Transaction>> fetchTransactions(String userId) async {
    final response =
        await http.get(Uri.parse('${ApiConstants.getTransactionsUrl}/$userId'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<User?> getUserDetails() async {
    return SharedPrefHelper(await SharedPreferences.getInstance())
        .getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    // var user = FlutterSecureStorageHelper(const FlutterSecureStorage())
    //     .getUserDetails();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder<User?>(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            User user = snapshot.data!;

            return SafeArea(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: 14,
                      top: 89,
                      child: Container(
                        width: width / 2 + width / 2 - 50,
                        height: 150,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF0B2031),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: [
                            const BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: height - 850,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Hello ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            ),
                            TextSpan(
                              text: '${user.userName}',
                              style: const TextStyle(
                                color: Color(0xFFFF9F00),
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                height: 0.09,
                              ),
                            ),
                            const TextSpan(
                              text: '.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 370,
                      top: height - 850,
                      child: const ImageIcon(AssetImage("images/Alert.png")),
                    ),
                    Positioned(
                      left: 100,
                      top: height - 705,
                      child: Text(
                        'Kshs. ' '${user.balance}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF34DD59),
                          fontSize: 32,
                          fontFamily: 'Montserrat Alternates',
                          fontWeight: FontWeight.w500,
                          height: 0.05,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100,
                      top: height - 750,
                      child: const Text(
                        'Account Balance;',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFF9F00),
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                          height: 0.12,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: height - 600,
                      child: const Row(
                        children: [
                          Column(
                            children: [
                              ImageIcon(
                                AssetImage("images/deposit.png"),
                                color: Colors.black,
                                size: 24.0,
                                semanticLabel: "Top-up via M-Pesa",
                              ),
                              Text("Deposit"),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.mobile_friendly,
                                color: Colors.black,
                                size: 24.0,
                                semanticLabel: "Transferring Money",
                              ),
                              Text("Trasfers"),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              ImageIcon(
                                AssetImage("images/withdraw.png"),
                                color: Colors.black,
                                size: 24.0,
                                semanticLabel: "Withdrawing Money",
                              ),
                              Text("Withdraw"),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              ImageIcon(
                                AssetImage("images/more.png"),
                                color: Colors.black,
                                size: 24.0,
                                semanticLabel: "More Options",
                              ),
                              Text("More"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 10,
                      top: 352,
                      child: SizedBox(
                        width: 263,
                        height: 26,
                        child: Text(
                          'RECENT TRANSACTIONS',
                          style: TextStyle(
                            color: Color(0xFF0B2031),
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 330,
                      top: 350,
                      child: SizedBox(
                        width: 100,
                        height: 35,
                        child: Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFFFF9F00),
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                          ),
                        ),
                      ),
                    ),
                    // Define a list of data

                    // Use ListView.builder to create a list of widgets
                    // Use Positioned to place the listview.builder at a fixed location
                    Positioned(
                      left: 0,
                      top: height - 490,
                      child: Column(
                        children: [
                          Container(
                            width: 430,
                            height: 300,
                            child: FutureBuilder<List<Transaction>>(
                              future: fetchTransactions('${user.id}'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.data == null ||
                                    snapshot.data!.isEmpty) {
                                  // Display a message when there is no data
                                  return const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      'No transactions available yet.\n ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 0.09,
                                        letterSpacing: 0.30,
                                      ),
                                    ),
                                  ));
                                } else {
                                  // Display the list when there is data
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      Transaction transaction =
                                          snapshot.data![index];
                                      return ListTile(
                                        title: Text(
                                          transaction.routeName,
                                          style: const TextStyle(
                                            color: Color(0xFF0B2031),
                                            fontSize: 20,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            height: 0.09,
                                          ),
                                        ),
                                        subtitle: Text(
                                          transaction.getFormattedTimestamp(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Josefin Sans',
                                            fontWeight: FontWeight.w500,
                                            height: 0.09,
                                          ),
                                        ),
                                        trailing: Text(
                                          '+ Kshs. ${transaction.fareValue}'
                                              .toString(),
                                          style: const TextStyle(
                                            color: Color(0xFF2BC112),
                                            fontSize: 20,
                                            fontFamily: 'Josefin Sans',
                                            fontWeight: FontWeight.w500,
                                            height: 0.09,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Handle the case when user information is not available
            return const Scaffold(
              body: Center(
                child: Text('User information not available.'),
              ),
            );
          }
        } else {
          // Handle loading state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
