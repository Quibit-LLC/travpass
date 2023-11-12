import 'package:flutter/material.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF0B2031),
      body: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0B2031)),
        child: Stack(
          children: [
            Positioned(
              left: -381,
              top: -575,
              child: Container(
                width: 1080,
                height: 1920,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 231,
              child: Container(
                width: 381.79,
                height: 411.09,
                child: Stack(
                  children: [
                    Positioned(
                      left: 63,
                      top: 75,
                      child: Container(
                        width: 247,
                        height: 273,
                        decoration: BoxDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 97,
              top: 102,
              child: Text(
                'Scanning QR Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 86,
              top: 413,
              child: Container(
                width: 265,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF2AD23A),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 140,
                top: 510,
                child: Container(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 34,
                        top: 30,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/flash.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                left: 50,
                top: height - 200,
                right: 50,
                child: Container(
                  width: 284,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: Color(0xFF34DD59),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )),
            Positioned(
              left: 80,
              top: height - 190,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/Vector.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Scan QR Code',
                    style: TextStyle(
                      color: Color(0xFFFDF7F7),
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                left: 0,
                top: 833,
                child: Container(
                  width: 425,
                  height: 114,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 425,
                          height: 114,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: Colors.white
                                    .withOpacity(0.10196078568696976),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 25,
                                offset: Offset(0, 15),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 282.20,
                        top: 33.37,
                        child: Container(
                          width: 31.73,
                          height: 27.80,
                          decoration: BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 353.60,
                        top: 36.15,
                        child: Container(
                          width: 31.73,
                          height: 22.24,
                          decoration: BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 175.67,
                        top: 15.76,
                        child: Container(
                          width: 74.80,
                          height: 61.17,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 23.80,
                                top: 21.32,
                                child: Container(
                                  width: 26.07,
                                  height: 20.39,
                                  decoration: BoxDecoration(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40.05,
                        top: 40.67,
                        child: Container(
                          width: 32.50,
                          height: 18.53,
                          decoration: BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 117.24,
                        top: 33.53,
                        child: Container(
                          width: 33.89,
                          height: 24.31,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 27.08,
                                top: 0,
                                child: Container(
                                  width: 6.81,
                                  height: 4.87,
                                  decoration: ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(
                                        width: 1.50,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
