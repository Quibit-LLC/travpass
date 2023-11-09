import 'package:flutter/material.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 463,
        height: 932,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xFF0B2031),
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage(
              "images/check.png",
            ),
          ),
        ),
        child: Container(
          width: 600,
          height: 600,
          child: Container(
            width: 400,
            height: 75,
            child: Column(
              children: [
                Container(
                  width: 330,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFF9F00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  width: 109,
                  height: 43,
                  child: Text(
                    'EXPLORE MENU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
