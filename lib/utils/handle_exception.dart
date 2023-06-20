import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/molecules/snackbar.dart';
import 'package:mobile_charity_app/models/exceptions.dart';

void handleException({
  required BuildContext context,
  required dynamic error,
  Function(String)? onFormException,
}) {
  final String message = error.toString();
  if (error is FormException) {
    onFormException?.call(message);
  } else {
    SerManosSnackBar(message).show(context);
  }
}
