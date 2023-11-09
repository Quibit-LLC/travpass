import 'package:flutter/material.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 430,
      height: 932,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFF0B2031)),
      child: Stack(
        children: [
          Positioned(
            left: 87,
            top: 270,
            child: Container(
              width: 255,
              height: 255,
              decoration: ShapeDecoration(
                image: DecorationImage(
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
            top: 591,
            child: SizedBox(
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
            top: 653,
            child: SizedBox(
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
            left: 54,
            top: 715,
            child: Container(
              width: 300,
              height: 81,
              decoration: ShapeDecoration(
                color: Color(0xFFFF9F00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            left: 124,
            top: 737,
            child: SizedBox(
              width: 240,
              height: 40,
              child: Text(
                'EXPLORE MENU',
                // textAlign: TextAlign.center,
                semanticsLabel: "EXPLORE MENU",
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
        ],
      ),
    ));
  }
}
