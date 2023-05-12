import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SerManosScaffold(
      body: Center(
        child: Text('404 - Página no encontrada'),
      ),
    );
  }
}
