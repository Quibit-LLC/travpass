import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({super.key});

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  // TextEditingController? routeNameController;
  // TextEditingController? fareAmountController;

  late var mapString = {
    "conductorID": "JHGSJG",
    "amount": 0,
    "routeName": "",
  };

  late String data = jsonEncode(mapString);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/newTrip.png")),
                ),
              ),
            ),
            Center(
              child: QrImageView(
                data: data,
                backgroundColor: Colors.white,
                size: 300.0,
                version: QrVersions.auto,
              ),
            ),
            Center(
              child: SizedBox(
                width: 400,
                height: 50,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Enter ',
                        style: TextStyle(
                          color: Color(0xFF1D3A6F),
                          fontSize: 32,
                          fontFamily: 'Righteous',
                          fontWeight: FontWeight.w400,
                          height: 0.04,
                        ),
                      ),
                      TextSpan(
                        text: 'New',
                        style: TextStyle(
                          color: Color(0xFFFF9F00),
                          fontSize: 32,
                          fontFamily: 'Righteous',
                          fontWeight: FontWeight.w400,
                          height: 0.04,
                        ),
                      ),
                      TextSpan(
                        text: ' Trip Details',
                        style: TextStyle(
                          color: Color(0xFF1D3A6F),
                          fontSize: 32,
                          fontFamily: 'Righteous',
                          fontWeight: FontWeight.w400,
                          height: 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  mapString["routeName"] = value;
                  String data = jsonEncode(mapString);
                });
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Route Name',
              ),
              style: TextStyle(
                color: Color(0xFFFF9F00),
                fontSize: 20,
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  mapString["amount"] = value;
                  String data = jsonEncode(mapString);
                  print(data);
                });
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Fare Amount',
              ),
              style: TextStyle(
                color: Color(0xFFFF9F00),
                fontSize: 20,
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
