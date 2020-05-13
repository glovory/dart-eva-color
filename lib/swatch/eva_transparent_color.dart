import 'package:flutter/painting.dart';

/// Color swatch for non transparent color
class EvaTransparentColor extends ColorSwatch<int> {
  const EvaTransparentColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  Color get shade100 => this[100];

  Color get shade200 => this[200];

  Color get shade300 => this[300];

  Color get shade400 => this[400];

  Color get shade500 => this[500];

  Color get shade600 => this[600];
}
