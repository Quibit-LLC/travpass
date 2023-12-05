// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unnecessary_string_interpolations

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travpass/auth_pages/intro.dart';
import 'package:travpass/business_logic/models/user.dart';
import 'package:travpass/business_logic/services/auth_service.dart';
import 'package:travpass/components/loading_button.dart';
import 'package:travpass/core/shared_pref_helper.dart';

import 'package:flutter/material.dart';
import 'package:travpass/core/strings.dart';
import 'package:travpass/nav_pages/contacts.dart';
import 'package:travpass/nav_pages/main_page.dart';

class CurrentUser {
  String id;
  String username;
  String email;
  String phoneNumber;
  String password;
  String saccoID;

  CurrentUser({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.saccoID,
  });
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserProfileScreen();
  }
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<User?> userFuture;

  CurrentUser currentUser = CurrentUser(
    id: '',
    username: '',
    email: '',
    phoneNumber: '',
    password: '',
    saccoID: '',
  );

  _UserProfileScreenState() {
    userFuture = getUserDetails();
  }

  Future<User?> getUserDetails() async {
    return SharedPrefHelper(await SharedPreferences.getInstance())
        .getUserDetails();
  }

  void _logout() async {
    // Perform logout actions (e.g., clear authentication tokens)
    // Navigate to the login screen
    String result =
        await Provider.of<AuthService>(context, listen: false).logout();
    if (result == "ok") {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const IntroPage())));
    }
  }

  void _showDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<User?>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                User user = snapshot.data!;
                currentUser.id = '${user.id}';
                currentUser.email = '${user.emailAddress}';
                currentUser.phoneNumber = '${user.phoneNumber}';
                currentUser.username = '${user.userName}';

                return AlertDialog(
                  title: const Text('User Details'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Username: ${user.userName}'),
                      Text('Email: ${user.emailAddress}'),
                      Text('Phone Number: ${user.phoneNumber}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
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
      },
    );
  }

  void _changeDetails() {
    // Navigate to the screen for changing user details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ChangeDetailsScreen(currentUser: currentUser, id: currentUser.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: _showDetails,
              child: const Text('View Details'),
            ),
            ElevatedButton(
              onPressed: _changeDetails,
              child: const Text('Change Details'),
            ),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeDetailsScreen extends StatefulWidget {
  final CurrentUser currentUser;
  // bool isConductor = false;
  String id;
  ChangeDetailsScreen({
    Key? key,
    required this.currentUser,
    required this.id,
  }) : super(key: key);

  @override
  _ChangeDetailsScreenState createState() => _ChangeDetailsScreenState();
}

class _ChangeDetailsScreenState extends State<ChangeDetailsScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController _saccoController;

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _emailController = TextEditingController(text: widget.currentUser.email);
    _phoneNumberController =
        TextEditingController(text: widget.currentUser.phoneNumber);
    _passwordController =
        TextEditingController(text: widget.currentUser.password);
    _passwordConfirmController =
        TextEditingController(text: widget.currentUser.password);
    _saccoController = TextEditingController(text: widget.currentUser.saccoID);
  }

  bool isLoading = false;

  bool userIsConductor = false;
  String? errorTextEmail;
  String? errorTextName;
  String? errorTextPassword;
  String? errorTextPhone;
  String? errorTextSacco;
  String? errorTextConfirmPass;
  @override
  Widget build(BuildContext context) {
    // bool _isConductor = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            userIsConductor = true;
                          });
                        },
                        child: const Text("Conductor")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            userIsConductor = false;
                          });
                        },
                        child: const Text("Passenger"))
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _usernameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'USERNAME',
                    ),
                    style: const TextStyle(
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
                if (errorTextName != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextName!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                TextFormField(
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
                    hintText: "EMAIL",
                    hintStyle: const TextStyle(
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
                if (errorTextEmail != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextEmail!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: 'PHONE NUMBER',
                  ),
                  style: const TextStyle(
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
                if (errorTextPhone != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextPhone!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                TextField(
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
                if (errorTextPassword != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextPassword!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                TextField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _passwordConfirmController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'CONFIRM PASSWORD',
                    ),
                    style: const TextStyle(
                      color: Color(0xFFFF9F00),
                      fontSize: 20,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          value.length >= 8 &&
                          _passwordConfirmController.text ==
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
                if (errorTextConfirmPass != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextConfirmPass!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                Visibility(
                  visible: userIsConductor,
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
                      style: const TextStyle(
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
                if (errorTextSacco != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorTextSacco!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                isLoading
                    ? const LoadingButton()
                    : ElevatedButton(
                        onPressed: () async =>
                            _saveChanges(userIsConductor, widget.id),
                        child: const Text('Save Changes'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveChanges(bool isConductor, String id) async {
    setState(() {
      isLoading = true;
    });

    // validating user inputs credentials for sign up before submitting the data to the server
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text != _passwordConfirmController.text) {
      if (_usernameController.text.isEmpty) {
        errorTextName = kFullNameNullError;
      }
      if (_emailController.text.isEmpty) {
        errorTextEmail = kEmailNullError;
      }
      if (_passwordController.text.isEmpty) {
        errorTextPassword = kPasswordNullError;
      }
      if (_passwordController.text != _passwordConfirmController.text) {
        errorTextConfirmPass = kPasswordConfirmError;
      }
      if (_saccoController.text.isEmpty && isConductor) {
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
      if (isConductor) {
        Map<String, dynamic> body = {
          'userName': _usernameController.text,
          'emailAddress': _emailController.text,
          'password': _passwordController.text,
          'password_confirmation': _passwordConfirmController.text,
          'phoneNumber': _phoneNumberController.text,
          'saccoID': _saccoController.text,
          'conductorID': id,
        };
        String result = await Provider.of<AuthService>(context, listen: false)
            .updateUser(body);
        if (result == "ok") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor:
                  const Color(0xFF2BC112), // Set background color to red
            ),
          );
          Navigator.pop(context);
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
      } else {
        Map<String, dynamic> body = {
          'userName': _usernameController.text,
          'emailAddress': _emailController.text,
          'password': _passwordController.text,
          'password_confirmation': _passwordConfirmController.text,
          'phoneNumber': _phoneNumberController.text,
          'passengerID': id,
        };

        // 'device_name': _deviceName ?? 'unknown',

        String result = await Provider.of<AuthService>(context, listen: false)
            .updateUser(body);
        if (result == "ok") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor:
                  const Color(0xFF2BC112), // Set background color to red
            ),
          );
          setState(() {
            widget.currentUser.username = _usernameController.text;
            widget.currentUser.email = _emailController.text;
            widget.currentUser.phoneNumber = _phoneNumberController.text;
            widget.currentUser.password = _passwordController.text;
          });
          Navigator.pop(context);
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
}
