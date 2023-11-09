import 'package:flutter/material.dart';
// import 'package:travpass/auth_pages/register_conductor.dart';
// import 'package:travpass/auth_pages/register_passenger.dart';
import 'package:travpass/auth_pages/register_success.dart';
// import 'package:travpass/auth_pages/register_page_one.dart';
// import 'package:travpass/auth_pages/conductor_login.dart';
// import 'package:travpass/auth_pages/passenger_login.dart';

void main() {
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
        home: const RegisterSuccess());
  }
}
