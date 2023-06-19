import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';

class SerManosRefreshIndicator extends RefreshIndicator {
  const SerManosRefreshIndicator({
    Key? key,
    required Widget child,
    required RefreshCallback onRefresh,
    ScrollNotificationPredicate? notificationPredicate,
  }) : super(
          key: key,
          child: child,
          onRefresh: onRefresh,
          color: SerManosColors.secondary200,
          strokeWidth: 3,
        );
}

class SerManosProgressIndicator extends CircularProgressIndicator {
  const SerManosProgressIndicator({
    Key? key,
  }) : super(
          key: key,
          color: SerManosColors.secondary100,
          strokeWidth: 3,
        );
}
