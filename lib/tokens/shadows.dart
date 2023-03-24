
import 'package:flutter/material.dart';

class SerManosShadows {
  SerManosShadows._();

  static List<BoxShadow> shadow1 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.3), 
      offset: const Offset(0, 1),
      blurRadius: 2,
    )
  ];

  static List<BoxShadow> shadow2 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(0, 2),
      blurRadius: 6,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.3), 
      offset: const Offset(0, 1),
      blurRadius: 2,
    )
  ];

  static List<BoxShadow> shadow3 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(0, 8),
      blurRadius: 12,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.3), 
      offset: const Offset(0, 4),
      blurRadius: 4,
    )
  ];
}
