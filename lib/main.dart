import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:travpass/auth_pages/intro.dart';
// import 'package:travpass/auth_pages/register_conductor.dart';

// import 'package:travpass/auth_pages/register_passenger.dart';
// import 'package:travpass/auth_pages/register_success.dart';
// import 'package:travpass/auth_pages/register_page_one.dart';
// import 'package:travpass/auth_pages/conductor_login.dart';
// import 'package:travpass/nav_pages/conductor_dashboard.dart';
import 'package:travpass/nav_pages/main_page.dart';
// import 'package:travpass/auth_pages/passenger_login.dart';

void main() async{
  await Hive.initFlutter();

  await Hive.openBox("Transaction_Database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage());
  }
}
