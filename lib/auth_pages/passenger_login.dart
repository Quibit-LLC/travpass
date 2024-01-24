import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travpass/auth_pages/register_page_one.dart';
import 'package:travpass/business_logic/services/auth_service.dart';
import 'package:travpass/components/loading_button.dart';

import 'package:travpass/core/strings.dart';
import 'package:travpass/nav_pages/main_page.dart';

class PassengerLoginPage extends StatefulWidget {
  const PassengerLoginPage({super.key});

  @override
  State<PassengerLoginPage> createState() => _PassengerLoginPageState();
}

class _PassengerLoginPageState extends State<PassengerLoginPage> {
  // defining the input controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  // bool _obscureText = true;

  String? errorTextEmail;
  String? errorTextPassword;

  @override
  void initState() {
    super.initState();
    _emailController.text.toString();
    _passwordController.text.toString();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                          decoration: const BoxDecoration(color: Colors.white),
                        ),
                      ),
                      Positioned(
                        left: -56.97,
                        top: height / -5.5,
                        child: Container(
                          width: 567.62,
                          height: 479,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF0B2031),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: height * 0.12,
                child: const SizedBox(
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
                top: height * 0.42,
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color(0xFFFF9F00),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      hintStyle: const TextStyle(
                        color: Color(0xFFFF9F00),
                        fontSize: 17.0,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          errorTextEmail = kEmailNullError;
                        });
                      } else if (!emailValidatorRegExp.hasMatch(value)) {
                        setState(() {
                          errorTextEmail = kInvalidEmailError;
                        });
                      } else {
                        setState(() {
                          errorTextEmail = null;
                        });
                      }
                    },
                  ),
                ),
              ),
              if (errorTextEmail != null)
                Positioned(
                  left: 25,
                  top: height * 0.49,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextEmail!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 25,
                top: height * 0.55,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: 'Password',
                      ),
                      style: const TextStyle(
                        color: Color(0xFFFF9F00),
                        fontSize: 20,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && value.length >= 8) {
                          setState(() {
                            errorTextPassword = null;
                          });
                        } else if (value.isNotEmpty && value.length < 8) {
                          setState(() {
                            errorTextPassword = kShortPasswordError;
                          });
                        } else {
                          setState(() {
                            errorTextPassword = kPasswordNullError;
                          });
                        }
                      }),
                ),
              ),
              if (errorTextPassword != null)
                Positioned(
                  left: 25,
                  top: height * 0.62,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextPassword!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 60,
                top: height * 0.7,
                right: 50,
                child: isLoading
                    ? const LoadingButton()
                    : GestureDetector(
                        onTap: handleSignIn,
                        child: Container(
                          width: 300,
                          height: 75,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 250,
                                  height: 70,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF0B2031),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 75,
                                top: 40,
                                child: SizedBox(
                                  width: 109,
                                  height: 40,
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
              ),
              Positioned(
                left: 98,
                top: height * 0.83,
                child: const SizedBox(
                  width: 303,
                  height: 155,
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
              Positioned(
                left: 53,
                top: height * 0.85,
                child: SizedBox(
                  width: 303,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don’t have an Account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterFirstPage(
                                isConductor: false,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFFF9F00),
                            fontSize: 17,
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
            ],
          ),
        ),
      ),
    );
  }

  handleSignIn() async {
    setState(() {
      isLoading = true;
    });

    // validating user inputs credentials for login before submitting the data to the server
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      if (_emailController.text.isEmpty) {
        errorTextEmail = kEmailNullError;
      }
      if (_passwordController.text.isEmpty) {
        errorTextPassword = kPasswordNullError;
      }
      setState(() {
        isLoading = false;
      });
      return;
    } else if (!emailValidatorRegExp
            .hasMatch(_emailController.text.toString()) ||
        _passwordController.text.length < 8) {
      setState(() {
        isLoading = false;
      });
    } else {
      // valid input
      //provide type information to ensure type safety
      Map<String, dynamic> body = {
        'emailAddress': _emailController.text,
        'password': _passwordController.text,
      };

      String result = await Provider.of<AuthService>(context, listen: false)
          .loginUser(body);
      if (result == "ok") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => MainPage(
                      isConductor: false,
                    ))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red, // Set background color to red
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
      return;
    }
  }
}
