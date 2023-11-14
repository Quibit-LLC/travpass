import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travpass/nav_pages/generated_qr.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({super.key});

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  late var mapString = {
    "conductorID": "JHGSJG",
    "amount": 0,
    "routeName": "",
  };

  String data = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/newTrip.png")),
                ),
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
                  data = jsonEncode(mapString);
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
                  data = jsonEncode(mapString);
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
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => GeneratedQRPage(
                            data: data,
                          )))),
              child: Container(
                width: 327,
                height: 56,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Color(0xFF1D3A6F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Generate QR Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0.09,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
