// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travpass/auth_pages/conductor_login.dart';
import 'package:travpass/auth_pages/passenger_login.dart';
import 'package:travpass/auth_pages/register_success.dart';
import 'package:travpass/business_logic/services/auth_service.dart';
import 'package:travpass/components/loading_button.dart';
import 'package:travpass/core/strings.dart';

class RegisterFirstPage extends StatefulWidget {
  final isConductor;
  const RegisterFirstPage({
    Key? key,
    required this.isConductor,
  }) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  // defining the input controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _saccoController = TextEditingController();

  bool isLoading = false;
  // bool isConductor = true;

  String? errorTextEmail;
  String? errorTextName;
  String? errorTextPassword;
  String? errorTextPhone;
  String? errorTextSacco;
  String? errorTextConfirmPass;

  @override
  void initState() {
    super.initState();
    _emailController.text.toString();
    _passwordController.text.toString();
    _phoneController.text.toString();
    _saccoController.text.toString();
    _nameController.text.toString();
    _passConfirmController.toString();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passConfirmController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _saccoController.dispose();
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
                        top: height / -2.9,
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
              Positioned(
                left: 180,
                top: height * 0.16,
                child: Container(
                  width: 94,
                  height: 14,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 22.12,
                          height: 14,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFF9F00),
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 35.94,
                        top: 0,
                        child: Container(
                          width: 22.12,
                          height: 14,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: height * 0.08,
                child: SizedBox(
                  width: 401,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hello!',
                          style: TextStyle(
                            color: Color(0xFFFF9F00),
                            fontSize: 36,
                            fontFamily: 'Montserrat Alternates',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' Register to get \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n started...',
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
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: height * 0.22,
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
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
                      hintText: "EMAIL",
                      hintStyle: TextStyle(
                          color: Color(0xFFFF9F00),
                          fontSize: 20.0,
                          fontFamily: 'Josefin Sans'),
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
                  top: height * 0.29,
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
                top: height * 0.33,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _nameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: 'USERNAME',
                      ),
                      style: TextStyle(
                        color: Color(0xFFFF9F00),
                        fontSize: 20,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            errorTextName = null;
                          });
                        } else {
                          setState(() {
                            errorTextName = kNameNullError;
                          });
                        }
                      }),
                ),
              ),
              if (errorTextName != null)
                Positioned(
                  left: 25,
                  top: height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextName!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 25,
                top: height * 0.435,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'PHONE NUMBER',
                    ),
                    style: TextStyle(
                      color: Color(0xFFFF9F00),
                      fontSize: 20,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          errorTextPhone = kPhoneNullError;
                        });
                      } else if (!phoneNumberValidatorRegExp.hasMatch(value)) {
                        setState(() {
                          errorTextPhone = kInvalidPhoneError;
                        });
                      } else {
                        setState(() {
                          errorTextPhone = null;
                        });
                      }
                    },
                  ),
                ),
              ),
              if (errorTextPhone != null)
                Positioned(
                  left: 25,
                  top: height * 0.51,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextPhone!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 25,
                top: height * 0.54,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: 'PASSWORD',
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
                  top: height * 0.61,
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
                left: 25,
                top: height * 0.646,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _passConfirmController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: 'CONFIRM PASSWORD',
                      ),
                      style: TextStyle(
                        color: Color(0xFFFF9F00),
                        fontSize: 20,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            value.length >= 8 &&
                            _passConfirmController.text ==
                                _passwordController.text) {
                          setState(() {
                            errorTextConfirmPass = null;
                          });
                        } else if (value.isNotEmpty && value.length < 8) {
                          setState(() {
                            errorTextConfirmPass = kShortPasswordError;
                          });
                        } else if (value.isEmpty) {
                          setState(() {
                            errorTextConfirmPass = kPasswordNullError;
                          });
                        } else {
                          setState(() {
                            errorTextConfirmPass = kPasswordConfirmError;
                          });
                        }
                      }),
                ),
              ),
              if (errorTextConfirmPass != null)
                Positioned(
                  left: 25,
                  top: height * 0.715,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextConfirmPass!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              Visibility(
                visible: widget.isConductor,
                child: Positioned(
                  left: 25,
                  top: height * 0.745,
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: _saccoController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'SACCO ID',
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
                              errorTextSacco = null;
                            });
                          } else if (value.isNotEmpty && value.length < 8) {
                            setState(() {
                              errorTextSacco = kShortSaccoError;
                            });
                          } else {
                            setState(() {
                              errorTextSacco = kSaccoNullError;
                            });
                          }
                        }),
                  ),
                ),
              ),
              if (errorTextSacco != null)
                Positioned(
                  left: 25,
                  top: height * 0.815,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextSacco!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 35,
                top: height * 0.845,
                child: isLoading
                    ? const LoadingButton()
                    : GestureDetector(
                        onTap: handleSignUp,
                        child: Container(
                          width: 330,
                          height: 75,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 330,
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
                                    'REGISTER',
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
                left: 60,
                top: height * 0.93,
                child: SizedBox(
                  width: 309,
                  height: 42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an Account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFFFF9F00),
                            fontSize: 18,
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

  handleSignUp() async {
    setState(() {
      isLoading = true;
    });

    // validating user inputs credentials for sign up before submitting the data to the server
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _passwordController.text != _passConfirmController.text) {
      if (_nameController.text.isEmpty) {
        errorTextName = kFullNameNullError;
      }
      if (_emailController.text.isEmpty) {
        errorTextEmail = kEmailNullError;
      }
      if (_passwordController.text.isEmpty) {
        errorTextPassword = kPasswordNullError;
      }
      if (_passwordController.text != _passConfirmController.text) {
        errorTextConfirmPass = kPasswordConfirmError;
      }
      if (_saccoController.text.isEmpty && widget.isConductor) {
        errorTextSacco = kSaccoNullError;
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
      if (widget.isConductor) {
        Map<String, dynamic> body = {
          'userName': _nameController.text,
          'emailAddress': _emailController.text,
          'password': _passwordController.text,
          'password_confirmation': _passConfirmController.text,
          'phoneNumber': _phoneController.text,
          'saccoID': _saccoController.text,
        };
        String result = await Provider.of<AuthService>(context, listen: false)
            .signUpUser(body);
        if (result == "ok") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => RegisterSuccess(isConductor: true,))));
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
          // print("=------------------> ${res.toString()}");
          // showSnackBar(context, result);
        }

        setState(() {
          isLoading = false;
        });
        return;
      } else {
        Map<String, dynamic> body = {
          'userName': _nameController.text,
          'emailAddress': _emailController.text,
          'password': _passwordController.text,
          'password_confirmation': _passConfirmController.text,
          'phoneNumber': _phoneController.text,
        };

        // 'device_name': _deviceName ?? 'unknown',

        String result = await Provider.of<AuthService>(context, listen: false)
            .signUpUser(body);
        if (result == "ok") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => RegisterSuccess(isConductor: false,))));
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
          // print("=------------------> ${res.toString()}");
          // showSnackBar(context, result);
        }

        setState(() {
          isLoading = false;
        });
        return;
      }
    }
  }
}
