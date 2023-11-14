const String kEmailNullError = "Please enter your email address.";
const String kInvalidEmailError = "Please enter a valid email address.";
const String kShortPasswordError = "Password should be at least 8 characters long.";
const String kPasswordNullError = "Please enter your password.";
const String kFullNameNullError = "Please enter your full name.";

//input validations
//final variables can only be assigned once.
final emailValidatorRegExp = RegExp (r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');