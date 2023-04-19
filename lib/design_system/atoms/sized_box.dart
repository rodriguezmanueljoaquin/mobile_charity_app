import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';

class SerManosSizedBox extends SizedBox {
  const SerManosSizedBox.height({super.key, required double height})
      : super(height: height);

  const SerManosSizedBox.width({super.key, required double width})
      : super(width: width);

  const SerManosSizedBox.xxs({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceXXS : null,
          width: useWidth ? SerManosSpacing.spaceXXS : null,
        );

  const SerManosSizedBox.xs({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceXS : null,
          width: useWidth ? SerManosSpacing.spaceXS : null,
        );

  const SerManosSizedBox.sm({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceSM : null,
          width: useWidth ? SerManosSpacing.spaceSM : null,
        );

  const SerManosSizedBox.sl({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceSL : null,
          width: useWidth ? SerManosSpacing.spaceSL : null,
        );

  const SerManosSizedBox.md({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceMD : null,
          width: useWidth ? SerManosSpacing.spaceMD : null,
        );

  const SerManosSizedBox.lg({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceLG : null,
          width: useWidth ? SerManosSpacing.spaceLG : null,
        );

  const SerManosSizedBox.xl({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceXL : null,
          width: useWidth ? SerManosSpacing.spaceXL : null,
        );

  const SerManosSizedBox.xxl({
    super.key,
    bool useHeight = true,
    bool useWidth = false,
  }) : super(
          height: useHeight ? SerManosSpacing.spaceXXL : null,
          width: useWidth ? SerManosSpacing.spaceXXL : null,
        );
}
