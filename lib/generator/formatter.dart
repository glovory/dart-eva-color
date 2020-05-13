import 'dart:io';

import 'color.dart';

class GeneratorFormatter {
  String _formatColor(ColorSwatchProperty color) {
    String colorClass = color.primary.type == ColorType.STANDARD
        ? 'EvaColor'
        : 'EvaTransparentColor';
    String colorName = color.primary.name;

    // top of color
    final String top =
        '  static const ${colorClass} ${colorName} = ${colorClass}(${color.primary.hex}, {\n';
    // bottom of color
    final String bottom = '  });\n';

    // process middle
    String middle = '';
    color.swatches.forEach((ColorProperty element) {
      middle += '    ${element.index}: Color(${element.hex}),\n';
    });

    return top + middle + bottom;
  }

  String formatBody(List<ColorSwatchProperty> swatches) {
    String body = '';

    for (int i = 0; i < swatches.length; i++) {
      body += _formatColor(swatches[i]);

      if (i < swatches.length - 1) {
        body += '\n';
      }
    }

    return body;
  }

  String formatClass(String className, String body) {
    String importStatement = "import 'dart:ui';\n\n";
    importStatement += "import 'package:eva_color/eva_color.dart';\n\n";
    importStatement += "// @autogenerate DO NOT EDIT!!!\n";

    String classTop = 'class ${className} {\n';
    String classBottom = '}\n';

    return importStatement + classTop + body + classBottom;
  }
}
