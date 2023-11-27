import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travpass/auth_pages/intro.dart';

import 'package:travpass/business_logic/services/auth_service.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("Transaction_Database");
  // Ensure Flutter Widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Flutter Secure Storage
  // final storage = FlutterSecureStorage();

  // Initialize SharedPreferences
  try {
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
  } catch (e) {
    print("Error initializing SharedPreferences: $e");
    // Handle the error appropriately, e.g., show an error message to the user
  }
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
        home: IntroPage());
  }
}
