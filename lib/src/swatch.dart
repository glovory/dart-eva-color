import 'package:flutter/painting.dart';

/// Color swatch for non transparent color
///
/// Has 9 shades, with shade 500 as the primary color
class EvaColor extends ColorSwatch<int> {
  const EvaColor(int primary, Map<int, Color> swatch) : super(primary, swatch);

  Color? get shade100 => this[100];

  Color? get shade200 => this[200];

  Color? get shade300 => this[300];

  Color? get shade400 => this[400];

  Color? get shade500 => this[500];

  Color? get shade600 => this[600];

  Color? get shade700 => this[700];

  Color? get shade800 => this[800];

  Color? get shade900 => this[900];
}

/// Color swatch for non transparent color
///
/// Only has 6 shades, with 5th shades as the primary color.
class EvaTransparentColor extends ColorSwatch<int> {
  const EvaTransparentColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  Color? get shade100 => this[100];

  Color? get shade200 => this[200];

  Color? get shade300 => this[300];

  Color? get shade400 => this[400];

  Color? get shade500 => this[500];

  Color? get shade600 => this[600];
}

class EvaBasicColor extends ColorSwatch<int> {
  const EvaBasicColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  Color? get shade100 => this[100];

  Color? get shade200 => this[200];

  Color? get shade300 => this[300];

  Color? get shade400 => this[400];

  Color? get shade500 => this[500];

  Color? get shade600 => this[600];

  Color? get shade700 => this[700];

  Color? get shade800 => this[800];

  Color? get shade900 => this[900];

  Color? get shade1000 => this[1000];

  Color? get shade1100 => this[1100];
}
