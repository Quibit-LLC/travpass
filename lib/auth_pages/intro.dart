import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

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
                left: width / 2 + 20,
                top: height - 400,
                child: Container(
                  width: 180,
                  height: 173,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/conductor.jpg"),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 210,
                top: height - 400,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(1.59),
                  child: Container(
                    width: 177.03,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 13,
                top: height - 400,
                child: Container(
                  width: 192,
                  height: 175,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 2,
                        child: Container(
                          width: 180,
                          height: 173,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 11,
                        top: 0,
                        child: Container(
                          width: 165,
                          height: 175,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/passengers.png"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: height - 150,
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
                            color: Color(0xFFFF9F00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        top: 30,
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 51,
                top: 80,
                child: SizedBox(
                  width: 376,
                  height: 170,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Welcome to\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontFamily: 'Montserrat Alternates',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                          ),
                        ),
                        TextSpan(
                          text: '\n\n\n\n\n\n\n\n\n\n\nTrav',
                          style: TextStyle(
                            color: Color(0xFFFF9F00),
                            fontSize: 36,
                            fontFamily: 'Montserrat Alternates',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                          ),
                        ),
                        TextSpan(
                          text: 'Pass.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontFamily: 'Montserrat Alternates',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width / 2 - 200,
                top: 256,
                child: SizedBox(
                  width: 406,
                  height: 170,
                  child: Text(
                    'Are you a passenger \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n or an MTA official?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: 'Montserrat Alternates',
                      fontWeight: FontWeight.w400,
                      height: 0.04,
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
