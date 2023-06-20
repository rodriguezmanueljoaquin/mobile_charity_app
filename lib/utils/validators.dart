String? emailValidator(String? value) {
  if (value == null ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
    return 'No es un mail valido';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.length < 8) {
    return 'La contraseña debe tener al menos 8 caracteres';
  }
  return null;
}

String? dateValidator(String? value) {
  if (value == null ||
      !RegExp(r"(^0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(\d{4}$)")
          .hasMatch(value)) {
    return 'No es una fecha valida, debe ser DD/MM/YYYY';
  }
  return null;
}

String? phoneValidator(String? value) {
  if(value == null || value.isEmpty) {
    return 'Este campo es obligatorio';
  }
  if(!RegExp(r"^[\+].*").hasMatch(value)) {
    return 'Debe iniciar con +';
  }
  if (!RegExp(r"^[\+][0-9]{8,14}$").hasMatch(value)) {
    return 'Debe ser de entre 8 y 14 digitos';
  }
  return null;
}
