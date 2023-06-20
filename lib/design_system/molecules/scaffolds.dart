import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';

class SerManosDefaultScaffold extends StatelessWidget {
  final Widget body;
  final bool applyPadding;
  final bool whiteStatusBar;

  const SerManosDefaultScaffold({
    super.key,
    required this.body,
    this.applyPadding = true,
    this.whiteStatusBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: whiteStatusBar
            ? SystemUiOverlayStyle.dark
                .copyWith(statusBarColor: SerManosColors.neutral0)
            : SystemUiOverlayStyle.light.copyWith(
                statusBarColor: SerManosColors.neutral100,
              ),
        shadowColor: null,
        elevation: 0,
        backgroundColor: whiteStatusBar
            ? SerManosColors.neutral0
            : SerManosColors.neutral100,
      ),
      backgroundColor: SerManosColors.neutral0,
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

class SerManosLightBlueScaffold extends StatelessWidget {
  final Widget body;
  final Color backgroundColor;
  final PreferredSize? bottom;

  const SerManosLightBlueScaffold({
    super.key,
    required this.body,
    this.backgroundColor = SerManosColors.neutral0,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: SerManosColors.secondary90,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: SerManosColors.secondary90,
        ),
        shadowColor: null,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 147,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SerManosImages.appBar,
              ),
            ),
            const Spacer()
          ],
        ),
        bottom: bottom,
      ),
      body: body,
    );
  }
}
