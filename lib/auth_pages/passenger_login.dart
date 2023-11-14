import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travpass/business_logic/services/auth_service.dart';
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
  bool _obscureText = true;

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
          'email': _emailController.text,
          'password': _passwordController.text,
        };

        String result = await Provider.of<AuthService>(context, listen: false)
            .loginUser(body);
        if (result == "ok") {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => MainPage())));
          // navigateToMainActivity(context);
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
                    controller: _emailController,
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
                      hintText: "Email",
                      hintStyle: TextStyle(
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
                  top: height - 350,
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
                top: height - 320,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                      controller: _passwordController,
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
                  top: height - 245,
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
                left: 43,
                top: height - 215,
                child: isLoading
                    ? loadingButton()
                    : GestureDetector(
                        onTap: handleSignIn,
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

  Widget loadingButton() {
    return Container(
      height: 55,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: null,
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (isLoadingState) // Replace isLoadingState with your actual isLoading state variable
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            ),
            const SizedBox(width: 8),
            // Add some spacing between the loading indicator and the text
            Text(
              'Loading',
              style: TextStyle(
                color: Color(0xFFFF9F00),
                fontSize: 17,
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w500,
                height: 0.06,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
