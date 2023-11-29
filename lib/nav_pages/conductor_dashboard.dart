import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travpass/business_logic/api/api_constants.dart';
import 'package:travpass/business_logic/models/transaction.dart';
import 'package:travpass/business_logic/models/user.dart';
import 'package:travpass/business_logic/models/wallet.dart';

import 'package:travpass/core/shared_pref_helper.dart';

class UserWithWallet {
  final User? user;
  final Wallet? wallet;

  UserWithWallet({this.user, this.wallet});
}

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

  Future<UserWithWallet> getUserDetailsWithWallet() async {
    final user = await getUserDetails();
    final wallet = await fetchWalletData(user!.id);

    // Return a UserWithWallet object instead of null
    return UserWithWallet(user: user, wallet: wallet);
  }

  Future<Wallet?> fetchWalletData(String userId) async {
    final response =
        await http.get(Uri.parse('${ApiConstants.getWalletUrl}/$userId'));

    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      print(responseData);

      if (responseData is Map<String, dynamic>) {
        // If the response is a Map, directly convert it to Wallet
        return Wallet.fromJson(responseData);
      } else if (responseData is List<dynamic> && responseData.isNotEmpty) {
        // If the response is a List, take the first item and convert it to Wallet
        return Wallet.fromJson(responseData[0]);
      } else {
        // If the response is not in the expected format, throw an exception
        throw Exception('Invalid wallet data format');
      }
    } else {
      throw Exception('Failed to load wallet data');
    }
  }

  Future<User?> getUserDetails() async {
    return SharedPrefHelper(await SharedPreferences.getInstance())
        .getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    FutureBuilder<UserWithWallet>(
      future: getUserDetailsWithWallet(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            User user = snapshot.data!.user!;
            Wallet wallet = snapshot.data!.wallet!;
            print(user);
            return SafeArea(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: 14,
                      top: 89,
                      child: Container(
                        width: width / 2 + width / 2 - 50,
                        height: 150,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0B2031),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: [
                            BoxShadow(
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
                      top: height - 800,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
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
                              style: TextStyle(
                                color: Color(0xFFFF9F00),
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                height: 0.09,
                              ),
                            ),
                            TextSpan(
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
                      top: height - 830,
                      child: ImageIcon(AssetImage("images/Alert.png")),
                    ),
                    Positioned(
                      left: 128,
                      top: height - 700,
                      child: Text(
                        'Kshs. ' + '${wallet.balance}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      child: Text(
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
                      left: 60,
                      top: height - 600,
                      child: Row(
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
                          const SizedBox(
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
                          const SizedBox(
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
                          const SizedBox(
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
                    Positioned(
                      left: 10,
                      top: 352,
                      child: SizedBox(
                        width: 263,
                        height: 26,
                        child: Text(
                          'RECENT TRANSACTIONS',
                          style: TextStyle(
                            color: Color(0xFF0B2031),
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
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
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data
                                          ?.length, // The number of items in the list
                                      itemBuilder: (context, index) {
                                        Transaction transaction =
                                            snapshot.data![index];
                                        // The function that returns the widget for each item
                                        return ListTile(
                                          title: Text(
                                            transaction.routeName,
                                            style: TextStyle(
                                              color: Color(0xFF0B2031),
                                              fontSize: 20,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                              height: 0.09,
                                            ),
                                          ),
                                          subtitle: Text(
                                            transaction.getFormattedTimestamp(),
                                            style: TextStyle(
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
                                            style: TextStyle(
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
                                }),
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
            return Scaffold(
              body: Center(
                child: Text('User information not available.'),
              ),
            );
          }
        } else {
          // Handle loading state
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
    return Container(); // Add this line at the end
  }
}
