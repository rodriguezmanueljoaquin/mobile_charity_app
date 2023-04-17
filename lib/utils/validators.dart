String? emailValidator(String? value) {
  if (value != null && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
    return 'No es un mail valido';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value != null && value.length < 8) {
    return 'La contraseña debe tener al menos 8 caracteres';
  }
  return null;
}
