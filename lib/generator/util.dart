///convert RGBA color to hex with opacity
String rgbaToHex(int r, int g, int b, double opacity) {
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
  return '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}';
}
