import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';

class SerManosScaffold extends StatelessWidget {
  final Widget body;
  final bool applyPadding;

  const SerManosScaffold({
    super.key,
    required this.body,
    this.applyPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: SerManosColors.secondary90,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: applyPadding ? SerManosSpacing.spaceSL : 0),
          child: body,
        ),
      ),
    );
  }
}
