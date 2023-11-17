const String kEmailNullError = "Please enter your email address.";
const String kPhoneNullError = "Please enter your phone number.";
const String kNameNullError = "Please enter your user name.";
const String kInvalidEmailError = "Please enter a valid email address.";
const String kInvalidPhoneError = "Please enter a valid Kenyan phone number.";
const String kShortPasswordError =
    "Password should be at least 8 characters long.";
const String kShortSaccoError =
    "SACCO ID should be at least 8 characters long.";
const String kPasswordNullError = "Please enter your password.";
const String kPasswordConfirmError = "Passwords do not match";
const String kFullNameNullError = "Please enter your full name.";
const String kSaccoNullError = "Please enter the SACCO ID provided.";

//input validations
//final variables can only be assigned once.
final emailValidatorRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final phoneNumberValidatorRegExp =
    RegExp(r'^\+?254([17]\d{8}|[4]\d{7})$|^0([17]\d{8}|[4]\d{7})$');
