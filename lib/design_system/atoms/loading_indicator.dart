import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/indicators.dart';

class SerManosLoadingIndicator extends StatelessWidget {
  const SerManosLoadingIndicator({
    super.key,
    this.backgroundColor = Colors.transparent,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: backgroundColor,
        child: const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: SerManosProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
