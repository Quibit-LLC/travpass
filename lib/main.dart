import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travpass/auth_pages/passenger_login.dart';
import 'package:travpass/business_logic/services/auth_service.dart';

// import 'package:travpass/auth_pages/intro.dart';
// import 'package:travpass/auth_pages/register_conductor.dart';

// import 'package:travpass/auth_pages/register_passenger.dart';
// import 'package:travpass/auth_pages/register_success.dart';
// import 'package:travpass/auth_pages/register_page_one.dart';
// import 'package:travpass/auth_pages/conductor_login.dart';
// import 'package:travpass/nav_pages/conductor_dashboard.dart';
// import 'package:travpass/nav_pages/main_page.dart';
// import 'package:travpass/auth_pages/passenger_login.dart';

void main() async{

  await Hive.initFlutter();

  await Hive.openBox("Transaction_Database");
    // Ensure Flutter Widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Flutter Secure Storage
  // final storage = FlutterSecureStorage();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(prefs),
        ),
      ],
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatefulWidget {
   // final FlutterSecureStorage storage;

  // Pass SharedPreferences
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(prefs: prefs);
}

class _MyAppState extends State<MyApp> {
   // final FlutterSecureStorage storage;

  // Store SharedPreferences
  final SharedPreferences prefs;

  _MyAppState({required this.prefs});
  
  @override
  void initState() {
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
         theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PassengerLoginPage());
  }
}
