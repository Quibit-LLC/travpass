import 'package:flutter/material.dart';

class ConductorDashboard extends StatefulWidget {
  const ConductorDashboard({super.key});

  @override
  State<ConductorDashboard> createState() => _ConductorDashboardState();
}

class _ConductorDashboardState extends State<ConductorDashboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> data = [
      'JUJA - NAIROBI',
      'MOMBASA - NAIROBI',
      'KISUMU - NAIROBI'
    ];

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
                      text: 'Steve',
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
                'Ksh.2640',
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
                    child: ListView.builder(
                      itemCount: data.length, // The number of items in the list
                      itemBuilder: (context, index) {
                        // The function that returns the widget for each item
                        return ListTile(
                          title: Text(
                            data[index],
                            style: TextStyle(
                              color: Color(0xFF0B2031),
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                          subtitle: Text(
                            ' 12:22 PM',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                          trailing: Text(
                            ' +2100',
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
