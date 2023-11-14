import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travpass/data/transaction_data.dart';
import 'package:travpass/nav_pages/chart.dart';
import 'package:travpass/nav_pages/conductor_dashboard.dart';
import 'package:travpass/nav_pages/generate_qr.dart';
// import 'package:travpass/nav_pages/generate_qr.dart';
// import 'package:travpass/nav_pages/conductor_dashboard.dart';
// import 'package:travpass/nav_pages/passenger_dashboard.dart';
// import 'package:travpass/nav_pages/scan_qr.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const ConductorDashboard(),
    ChangeNotifierProvider(
        create: (context) => TransactionData(),
        builder: (context, child) => const StatisticsPage()),
    const GenerateQRPage(),
    // const BarItemPage(),
    // const SearchPage(),
    // const MyPage(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B2031),
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF0B2031),
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Color(0xFFFF9F00),
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 15,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "Bar", icon: Icon(Icons.bar_chart_sharp)),
            BottomNavigationBarItem(
                label: "Scan",
                icon: ImageIcon(
                  AssetImage("images/qr.png"),
                  size: 36,
                )),
            BottomNavigationBarItem(
                label: "Search",
                icon: ImageIcon(AssetImage("images/contacts.png"))),
            BottomNavigationBarItem(
                label: "My Profile", icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
