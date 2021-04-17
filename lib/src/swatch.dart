import 'package:flutter/painting.dart';

/// Color swatch for non transparent color
///
/// Has 9 shades, with shade 500 as the primary color
class EvaColor extends ColorSwatch<int> {
  /// Basic constructor of main color
  const EvaColor(int primary, Map<int, Color> swatch) : super(primary, swatch);

  /// Get shade 100
  Color? get shade100 => this[100];

  /// Get shade 200
  Color? get shade200 => this[200];

  /// Get shade 300
  Color? get shade300 => this[300];

  /// Get shade 400
  Color? get shade400 => this[400];

  /// Get shade 500
  Color? get shade500 => this[500];

  /// Get shade 600
  Color? get shade600 => this[600];

  /// Get shade 700
  Color? get shade700 => this[700];

  /// Get shade 800
  Color? get shade800 => this[800];

  /// Get shade 900
  Color? get shade900 => this[900];
}

/// Color swatch for non transparent color
///
/// Only has 6 shades, with 5th shades as the primary color.
class EvaTransparentColor extends ColorSwatch<int> {
  /// Basic constructor of transparent color
  const EvaTransparentColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  /// Get shade 100
  Color? get shade100 => this[100];

  /// Get shade 200
  Color? get shade200 => this[200];

  /// Get shade 300
  Color? get shade300 => this[300];

  /// Get shade 400
  Color? get shade400 => this[400];

  /// Get shade 500
  Color? get shade500 => this[500];

  /// Get shade 600
  Color? get shade600 => this[600];
}

/// Color swatch for basic color (black)
///
/// Has 11 shades, based on Eva Color
class EvaBasicColor extends ColorSwatch<int> {
  /// Basic color constructor
  const EvaBasicColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  /// Get shade 100
  Color? get shade100 => this[100];

  /// Get shade 200
  Color? get shade200 => this[200];

  /// Get shade 300
  Color? get shade300 => this[300];

  /// Get shade 400
  Color? get shade400 => this[400];

  /// Get shade 500
  Color? get shade500 => this[500];

  /// Get shade 600
  Color? get shade600 => this[600];

  /// Get shade 700
  Color? get shade700 => this[700];

  /// Get shade 800
  Color? get shade800 => this[800];

  /// Get shade 900
  Color? get shade900 => this[900];

  /// Get shade 1000
  Color? get shade1000 => this[1000];

  /// Get shade 1100
  Color? get shade1100 => this[1100];
}
