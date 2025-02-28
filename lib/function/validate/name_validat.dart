nameValidate(String val) {
  if (val.length < 3) {
    return "Name cannot be less than 3 characters";
  } else if (val.length > 20) {
    return "Name cannot be more than 20 characters";
  }
  return null;
}
