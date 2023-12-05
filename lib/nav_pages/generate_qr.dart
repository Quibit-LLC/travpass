import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travpass/business_logic/models/user.dart';
import 'package:travpass/core/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:travpass/nav_pages/generated_qr.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({super.key});

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
   late Future<User?> userFuture;

  _GenerateQRPageState() {
    userFuture = getUserDetails();
  }

  Future<User?> getUserDetails() async {
    return SharedPrefHelper(await SharedPreferences.getInstance())
        .getUserDetails();
  }

  late var mapString = {
    "conductorID": "",
    "amount": 0,
    "routeName": "",
  };

  String data = " ";

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<User?>(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            User user = snapshot.data!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
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
                decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/newTrip.png")),
                ),
              ),
            ),
            const Center(
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
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
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
              style: const TextStyle(
                color: Color(0xFFFF9F00),
                fontSize: 20,
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  mapString["amount"] = value;
                  mapString["conductorID"] = '${user.id}';
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
              style: const TextStyle(
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
                  color: const Color(0xFF1D3A6F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
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
  } else {
            // Handle the case when user information is not available
            return const Scaffold(
              body: Center(
                child: Text('User information not available.'),
              ),
            );
          }
        } else {
          // Handle loading state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
