import 'package:flutter/material.dart';
// import 'package:travpass/nav_pages/conductor_dashboard.dart';
import 'package:travpass/nav_pages/passenger_dashboard.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const PassengerDashboard(),
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
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
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
          elevation: 0,
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
