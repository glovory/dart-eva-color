import 'dart:io';
import 'package:mime/mime.dart';

///validate output directory is under lib
bool isOutputPathValid(String path) {
  Directory dir = new Directory(path);
  String outputPath = dir.uri.toString();
  //convert path
  outputPath = outputPath.replaceFirst('file:///', '');
  outputPath = outputPath.substring(0, outputPath.length - 1);
  try {
    List<String> splitPath = outputPath.split('/');
    if ((splitPath[0] == 'lib') && !splitPath.contains('../')) {
      return isPermissionAccess(outputPath);
    } else {
      print(
          'Output directory is not valid. Output directory must be under ./lib');
      return false;
    }
  } catch (error) {
    print(
        'Output directory is not valid. Output directory must be under ./lib');
    return false;
  }
}


///validate input is json file
bool isFileJson(String path) {
  String mimeStr = lookupMimeType(path);
  List<String> fileType = mimeStr.split('/');
  if (fileType.last == 'json') {
    return true;
  } else {
    return false;
  }
}


///validate file output permission access
bool isPermissionAccess(String path) {
  File outputFile = new File(path);
  // check file exists or not
  if (!outputFile.existsSync()) {
    return true;
  }
  //if exist continue to validate
  else {
    if (outputFile.statSync().mode.toRadixString(8) == '100666' ||
        outputFile.statSync().mode.toRadixString(8) == '100660' ||
        outputFile.statSync().mode.toRadixString(8) == '100600') {
      return true;
    } else {
      print('You have no permission in file output');
      return false;
    }
  }
}


///validate output is dart file
bool isFileDart(String path) {
  List<String> fileType = path.split('.');
  if (fileType.last == 'dart') {
    return true;
  } else {
    return false;
  }
}


///convert hex color with opacity
String hexColorWithOpacity(String color) {
  return color.replaceFirst("#", "0xFF");
}

///convert RGBA color to hex with opacity
String hexOfRGBA(int r, int g, int b, double opacity) {
  r = (r < 0) ? -r : r;
  g = (g < 0) ? -g : g;
  b = (b < 0) ? -b : b;
  opacity = (opacity < 0) ? -opacity : opacity;
  opacity = (opacity > 1) ? 255 : opacity * 255;
  r = (r > 255) ? 255 : r;
  g = (g > 255) ? 255 : g;
  b = (b > 255) ? 255 : b;
  int a = opacity.toInt();
  return '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}';
}
