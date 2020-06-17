import 'color.dart';

class GeneratorFormatter {
  String _formatColor(ColorSwatchProperty color) {
    final int pageLength = 80;

    String colorClass;

    if(color.primary.type == ColorType.STANDARD){
      colorClass='EvaColor';
    }else if(color.primary.type==ColorType.BASIC){
      colorClass='EvaBasicColor';
    }else{
      colorClass='EvaTransparentColor';
    }
    String colorName = color.primary.name;

    // top of color
    String top = '  static const $colorClass $colorName =';
    String _topLong = '$colorClass(${color.primary.hex}, {';
    // if the long class name plus space is long
    if (top.length + 1 + _topLong.length >= pageLength) {
      top += '\n      ' + _topLong + '\n';
    } else {
      top += ' ' + _topLong + '\n';
    }

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

    String classTop = 'class $className {\n';
    String classBottom = '}\n';

    return importStatement + classTop + body + classBottom;
  }
}
