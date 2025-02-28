emailValidate(String val) {
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(val)) {
    return "it's not email";
  }
  return null;
}
