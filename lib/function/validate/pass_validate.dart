String? passValidate(String? val, int min, int max,
    {bool isRePass = false, String pass = ''}) {
  if (val == null || val.isEmpty) {
    return "Password cannot be empty";
  }
  if (val.length < min) {
    return "Password must be at least $min characters long";
  }
  if (val.length > max) {
    return "Password cannot exceed $max characters";
  }
  if (!RegExp(r'[A-Z]').hasMatch(val)) {
    return "Password must contain at least one uppercase letter";
  }
  if (!RegExp(r'[a-z]').hasMatch(val)) {
    return "Password must contain at least one lowercase letter";
  }
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(val)) {
    return "Password must contain at least one special character";
  }
  if (!RegExp(r'[0-9]').hasMatch(val)) {
    return "Password must contain at least one digit";
  }
  if (isRePass && val != pass) {
    return "Passwords do not match";
  }
  return null;
}
