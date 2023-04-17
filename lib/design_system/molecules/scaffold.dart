import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';

class SerManosScaffold extends StatelessWidget {
  final Widget body;

  const SerManosScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: SerManosColors.secondary90,)
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: body,
        ),
      ),
    );
  }
}
