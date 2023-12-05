// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travpass/auth_pages/conductor_login.dart';
import 'package:travpass/auth_pages/passenger_login.dart';

class RegisterSuccess extends StatelessWidget {
  bool isConductor = true;
  RegisterSuccess({
    Key? key,
    required this.isConductor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: -381,
              top: -575,
              child: Container(
                width: 1080,
                height: 1920,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 87,
              top: height * 0.295,
              child: Container(
                width: 255,
                height: 255,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: AssetImage("images/check.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(104),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 92,
              top: height * 0.65,
              child: const SizedBox(
                width: 304,
                height: 62,
                child: Text(
                  'Thank you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              top: height * 0.75,
              child: const SizedBox(
                width: 380,
                height: 37,
                child: Text(
                  'for registering your account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 90,
              top: height * 0.825,
              child: Container(
                width: 250,
                height: 81,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF9F00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 180,
              top: height * 0.85,
              child: SizedBox(
                width: 240,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    if (isConductor) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ConductorLoginPage())));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const PassengerLoginPage())));
                    }
                  },
                  child: const Text(
                    'LOGIN',
                    // textAlign: TextAlign.center,
                    semanticsLabel: "PROCEED TO LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
