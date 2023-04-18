import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';

class SerManosSizedBox extends SizedBox {
  const SerManosSizedBox.height({super.key, required double height})
      : super(height: height);

  const SerManosSizedBox.width({super.key, required double width})
      : super(width: width);

  const SerManosSizedBox.xxs({super.key}) : super(height: SerManosSpacing.spaceXXS);

  const SerManosSizedBox.xs({super.key}) : super(height: SerManosSpacing.spaceXS);

  const SerManosSizedBox.sm({super.key}) : super(height: SerManosSpacing.spaceSM);

  const SerManosSizedBox.sl({super.key}) : super(height: SerManosSpacing.spaceSL);

  const SerManosSizedBox.md({super.key}) : super(height: SerManosSpacing.spaceMD);

  const SerManosSizedBox.lg({super.key}) : super(height: SerManosSpacing.spaceLG);

  const SerManosSizedBox.xl({super.key}) : super(height: SerManosSpacing.spaceXL);

  const SerManosSizedBox.xxl({super.key}) : super(height: SerManosSpacing.spaceXXL);
}