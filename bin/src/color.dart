import 'package:meta/meta.dart';

import 'util.dart';

enum ColorType {
  basic,
  standard,
  transparent,
}

class ColorSwatchProperty {
  ColorProperty primary;
  List<ColorProperty> swatches;

  ColorSwatchProperty({
    this.primary,
    this.swatches,
  });
}

class ColorProperty {
  final ColorType type;
  final String name;
  final String index;
  final String hex;

  ColorProperty({
    @required this.type,
    @required this.name,
    @required this.index,
    @required this.hex,
  });

  factory ColorProperty.fromLine(String key, String value) {
    List<String> keys = key.split('-');

    // remove first
    keys.removeAt(0);

    // get index
    String index = keys.removeLast();

    // get type
    ColorType type = ColorType.standard;

    // if the keys contain basic keyword, use color type basic
    if (keys.contains('basic')) {
      type = ColorType.basic;
    }
    // if it has transparent, we will use only transparent, either it has
    // basic keyword or not
    if (keys.contains('transparent')) {
      type = ColorType.transparent;
    }

    // Camelize name
    String name = '';
    for (int i = 0; i < keys.length; i++) {
      if (i > 0) {
        // capitalize second words or later
        name += keys[i][0].toUpperCase() + keys[i].substring(1);
      } else {
        name += keys[i];
      }
    }

    // get hex
    String hex;
    if (type == ColorType.standard || type == ColorType.basic) {
      hex = hexToIntHex(value);
    } else {
      final List<String> rgba =
          value.replaceFirst('rgba(', '').replaceFirst(')', '').split(',');

      hex = rgbaToIntHex(
        int.tryParse(rgba[0].trim()),
        int.tryParse(rgba[1].trim()),
        int.tryParse(rgba[2].trim()),
        double.tryParse(rgba[3].trim()),
      );
    }

    return ColorProperty(
      index: index,
      name: name,
      type: type,
      hex: hex,
    );
  }
}
