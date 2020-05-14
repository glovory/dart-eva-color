Example
-------

```dart
import 'package:eva_color/eva_color.dart';
import 'package:flutter/material.dart';

// output example
class EvaColors {
  static const EvaColor primary = EvaColor(0xFF3366FF, {
    100: Color(0xFFD6E4FF),
    200: Color(0xFFADC8FF),
    300: Color(0xFF84A9FF),
    400: Color(0xFF6690FF),
    500: Color(0xFF3366FF),
    600: Color(0xFF254EDB),
    700: Color(0xFF1939B7),
    800: Color(0xFF102693),
    900: Color(0xFF091A7A),
  });
}

// Usage for material design
Widget container = Container(
  color: EvaColors.primary.shade200,
);
```
