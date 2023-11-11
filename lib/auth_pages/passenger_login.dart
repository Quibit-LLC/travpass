import 'package:flutter/material.dart';

class PassengerLoginPage extends StatelessWidget {
  const PassengerLoginPage({super.key});

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
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: width,
                          height: height,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                      Positioned(
                        left: -56.97,
                        top: -128,
                        child: Container(
                          width: 567.62,
                          height: 479,
                          decoration: ShapeDecoration(
                            color: Color(0xFF0B2031),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 10,
                top: 120,
                child: SizedBox(
                  width: 400,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi,\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(height: 70),
                        ),
                        TextSpan(
                          text: 'Sign in to Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: height - 420,
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFFFF9F00),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Phone Number/Email",
                      hintStyle: TextStyle(
                        color: Color(0xFFFF9F00),
                        fontSize: 17.0,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: height - 320,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Password',
                    ),
                    style: TextStyle(
                      color: Color(0xFFFF9F00),
                      fontSize: 20,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 43,
                top: height - 215,
                child: Container(
                  width: 333,
                  height: 75,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 300,
                          height: 75,
                          decoration: ShapeDecoration(
                            color: Color(0xFF0B2031),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 110,
                        top: 40,
                        child: SizedBox(
                          width: 109,
                          height: 43,
                          child: Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFF9F00),
                              fontSize: 20,
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: height - 80,
                child: SizedBox(
                  width: 309,
                  height: 42,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don’t have an Account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFFF9F00),
                            fontSize: 20,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 140,
                top: height - 120,
                child: SizedBox(
                  width: 309,
                  height: 158,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFFF9F00),
                      fontSize: 17,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w500,
                      height: 0.06,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
