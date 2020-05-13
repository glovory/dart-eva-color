import 'color.dart';

///convert RGBA color to hex with opacity
String rgbaToIntHex(int r, int g, int b, double opacity) {
  // validate zero
  r = (r < 0) ? -r : r;
  g = (g < 0) ? -g : g;
  b = (b < 0) ? -b : b;
  // validate opacity
  opacity = (opacity < 0) ? -opacity : opacity;
  opacity = (opacity > 1) ? 255 : opacity * 255;
  // validate more than 255
  r = (r > 255) ? 255 : r;
  g = (g > 255) ? 255 : g;
  b = (b > 255) ? 255 : b;
  // change opacity to integer
  int a = opacity.toInt();
  // return string representation
  return '0x' +
      '${a.toRadixString(16)}'.toUpperCase() +
      '${r.toRadixString(16)}'.toUpperCase() +
      '${g.toRadixString(16)}'.toUpperCase() +
      '${b.toRadixString(16)}'.toUpperCase();
}

String hexToIntHex(String color) {
  return color.replaceFirst('#', '0xFF');
}

List<ColorSwatchProperty> parseJsonTheme(Map<String, dynamic> jsonMap) {
  // store results by categorize it using map to easily find it
  Map<String, ColorSwatchProperty> results = Map<String, ColorSwatchProperty>();

  // loop each line of json
  jsonMap.forEach((key, value) {
    ColorProperty parsed = ColorProperty.fromLine(key, value);

    if (!results.containsKey(parsed.name)) {
      results[parsed.name] = ColorSwatchProperty(
        swatches: List<ColorProperty>(),
      );
    }

    // add the parsed to swatches
    results[parsed.name].swatches.add(parsed);
    // if index is 500, add it as primary
    if (parsed.index == '500') {
      results[parsed.name].primary = parsed;
    }
  });

  return results.values.toList();
}
