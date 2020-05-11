import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:mime/mime.dart';

const tpl =
    "import 'dart:ui';\nimport 'package:eva_color/evacolor.dart';\n\n\n//@auto generate do not edit\nclass EvaColors {";

void main(List<String> args) {
  String src;
  String dist;

  ArgParser parser = new ArgParser();
  parser.addOption('input', abbr: 'i', defaultsTo: './eva_theme.json',
      callback: (value) {
    return src = value;
  }, help: "Specify the json directory.");
  parser.addOption('output', abbr: 'o', defaultsTo: 'lib/eva_color.dart',
      callback: (value) {
    return dist = value;
  }, help: "Specify the output directory.");
  parser.addFlag('help', abbr: 'h', help: 'Usage help', negatable: false);
  final arg = parser.parse(args);

  if (arg['help']) {
    stdout.writeln('Eva Design Color Converter');
    stdout.writeln(parser.usage);
    exit(0);
  }

  File inputFile = new File(src);
  Directory srcPath = new Directory(src);
  Directory distPath = new Directory(dist);
  String outputPath;
  String inputPath;

  //validate input path is absolute or not
  if (srcPath.isAbsolute) {
    inputPath = inputFile.uri.toString().replaceAll('//', '/');
    inputPath = inputPath.replaceFirst('file:/', '');
    inputFile = new File(inputPath);
  } else {
    inputPath = src;
  }
  //validate output path is absolute or not
  if (distPath.isAbsolute) {
    outputPath = distPath.uri.toString().replaceAll('//', '/');
    outputPath = outputPath.substring(0, outputPath.length - 1);
    outputPath = outputPath.replaceFirst('file:', '');
  } else {
    outputPath = dist;
  }
//validate input file exist
  if (inputFile.existsSync()) {
    // validate output path is valid.
    if (isOutputPathValid(outputPath)) {
      // validate file input is json
      if (isFileJson(inputPath)) {
        // validate output file is dart
        if (isFileDart(outputPath)) {
          //generate file
          if (isGenerateFile(inputFile, outputPath)) {
            print('successfully generate file');
          } else {
            print('generate file failed');
          }
        } else {
          print('output file type must be dart!');
        }
      } else {
        print('input file type must be json!');
      }
    }
  } else {
    print('File is not exist!');
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

// write color value for generate file format
void writeColorToBuffer(StringBuffer sinkColor, StringBuffer color500,
    String numberColor, String hexColor) {
  sinkColor
      .write(numberColor + ' :  Color(' + hexColorWithOpacity(hexColor) + '),');
  sinkColor.write('\n      ');
  if (numberColor == '500') {
    color500.write(hexColorWithOpacity(hexColor));
  }
}

// write transparent color value for generate file format
void writeTransparentColorToBuffer(StringBuffer sinkColor,
    StringBuffer color500, String numberColor, List<String> rgbaVal) {
  sinkColor.write(numberColor +
      ' :  Color(' +
      convertRgbaToHex(int.parse(rgbaVal[0]), int.parse(rgbaVal[1]),
          int.parse(rgbaVal[2]), double.parse(rgbaVal[3])) +
      '),');
  sinkColor.write('\n      ');
  if (numberColor == '500') {
    color500.write(convertRgbaToHex(
        int.parse(rgbaVal[0]),
        int.parse(rgbaVal[1]),
        int.parse(rgbaVal[2]),
        double.parse(rgbaVal[3])));
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

bool isGenerateFile(File file, String outputPath) {
  File files = file;
  String output = outputPath;
  Map<String, dynamic> map;
  try {
    map = json.decode(files.readAsStringSync());
  } catch (error) {
    print('invalid format json!');
    return false;
  }

  /// initialization of variable StringBuffer for write files
  StringBuffer sinkColorPrimary = new StringBuffer();
  StringBuffer sinkColorSuccess = new StringBuffer();
  StringBuffer sinkColorInfo = new StringBuffer();
  StringBuffer sinkColorWarning = new StringBuffer();
  StringBuffer sinkColorDanger = new StringBuffer();
  StringBuffer sinkColorPrimaryTransparent = new StringBuffer();
  StringBuffer sinkColorSuccessTransparent = new StringBuffer();
  StringBuffer sinkColorInfoTransparent = new StringBuffer();
  StringBuffer sinkColorWarningTransparent = new StringBuffer();
  StringBuffer sinkColorDangerTransparent = new StringBuffer();
  StringBuffer colorPrimary = new StringBuffer();
  StringBuffer colorSuccess = new StringBuffer();
  StringBuffer colorInfo = new StringBuffer();
  StringBuffer colorWarning = new StringBuffer();
  StringBuffer colorDanger = new StringBuffer();
  StringBuffer colorPrimaryTransparent = new StringBuffer();
  StringBuffer colorSuccessTransparent = new StringBuffer();
  StringBuffer colorInfoTransparent = new StringBuffer();
  StringBuffer colorWarningTransparent = new StringBuffer();
  StringBuffer colorDangerTransparent = new StringBuffer();

  map.forEach((key, val) {
    List<String> indexColor = key.split("-");
    if (indexColor.length == 3) {
      //generate for non transparent color
      switch (indexColor[1]) {
        case 'primary':
          {
            writeColorToBuffer(
                sinkColorPrimary, colorPrimary, indexColor[2], val);
          }
          break;

        case 'success':
          {
            writeColorToBuffer(
                sinkColorSuccess, colorSuccess, indexColor[2], val);
          }
          break;

        case 'info':
          {
            writeColorToBuffer(sinkColorInfo, colorInfo, indexColor[2], val);
          }
          break;
        case 'warning':
          {
            writeColorToBuffer(
                sinkColorWarning, colorWarning, indexColor[2], val);
          }
          break;

        case 'danger':
          {
            writeColorToBuffer(
                sinkColorDanger, colorDanger, indexColor[2], val);
          }

          break;
      }
    } else {
      //generate for transparent color
      String rgba = val.substring(6, val.length - 1);
      List<String> rgbaVal = rgba.split(",");

      switch (indexColor[1]) {
        case 'primary':
          {
            writeTransparentColorToBuffer(sinkColorPrimaryTransparent,
                colorPrimaryTransparent, indexColor[3], rgbaVal);
          }
          break;

        case 'success':
          {
            writeTransparentColorToBuffer(sinkColorSuccessTransparent,
                colorSuccessTransparent, indexColor[3], rgbaVal);
          }
          break;

        case 'info':
          {
            writeTransparentColorToBuffer(sinkColorInfoTransparent,
                colorInfoTransparent, indexColor[3], rgbaVal);
          }
          break;
        case 'warning':
          {
            writeTransparentColorToBuffer(sinkColorWarningTransparent,
                colorWarningTransparent, indexColor[3], rgbaVal);
          }
          break;

        case 'danger':
          {
            writeTransparentColorToBuffer(sinkColorDangerTransparent,
                colorDangerTransparent, indexColor[3], rgbaVal);
          }
          break;
      }
    }
  });

  String dist = format(
      tpl,
      sinkColorPrimary,
      sinkColorSuccess,
      sinkColorInfo,
      sinkColorWarning,
      sinkColorDanger,
      sinkColorPrimaryTransparent,
      sinkColorSuccessTransparent,
      sinkColorInfoTransparent,
      sinkColorWarningTransparent,
      sinkColorDangerTransparent,
      colorPrimary,
      colorSuccess,
      colorInfo,
      colorWarning,
      colorDanger,
      colorPrimaryTransparent,
      colorSuccessTransparent,
      colorInfoTransparent,
      colorWarningTransparent,
      colorDangerTransparent);

  ///generate file
  new File(output)
    ..createSync(recursive: true)
    ..writeAsStringSync(dist);
  return true;
}

///make format text for write to file
String format(
  String fmt,
  StringBuffer primary,
  StringBuffer success,
  StringBuffer info,
  StringBuffer warning,
  StringBuffer danger,
  StringBuffer primaryTransparent,
  StringBuffer successTransparent,
  StringBuffer infoTransparent,
  StringBuffer warningTransparent,
  StringBuffer dangerTransparent,
  StringBuffer primaryColor,
  StringBuffer successColor,
  StringBuffer infoColor,
  StringBuffer warningColor,
  StringBuffer dangerColor,
  StringBuffer primaryTransparentColor,
  StringBuffer successTransparentColor,
  StringBuffer infoTransparentColor,
  StringBuffer warningTransparentColor,
  StringBuffer dangerTransparentColor,
) {
  return fmt +
      '\n   static const EvaColor primary = EvaColor(' +
      primaryColor.toString() +
      ', {\n      ' +
      primary.toString() +
      '\n   });\n   static const EvaColor success = EvaColor(' +
      successColor.toString() +
      ', {\n      ' +
      success.toString() +
      '\n   });\n   static const EvaColor info = EvaColor(' +
      infoColor.toString() +
      ', {\n      ' +
      info.toString() +
      '\n   });\n   static const EvaColor warning = EvaColor(' +
      warningColor.toString() +
      ', {\n      ' +
      warning.toString() +
      '\n   });\n   static const EvaColor danger = EvaColor(' +
      dangerColor.toString() +
      ', {\n      ' +
      danger.toString() +
      '\n   });\n   static const EvaColor primaryTransparent = EvaColor(' +
      primaryTransparentColor.toString() +
      ', {\n      ' +
      primaryTransparent.toString() +
      '\n   });\n   static const EvaColor successTransparent = EvaColor(' +
      successTransparentColor.toString() +
      ', {\n      ' +
      successTransparent.toString() +
      '\n   });\n   static const EvaColor infoTransparent = EvaColor(' +
      infoTransparentColor.toString() +
      ', {\n      ' +
      infoTransparent.toString() +
      '\n   });\n   static const EvaColor warningTransparent = EvaColor(' +
      warningTransparentColor.toString() +
      ', {\n      ' +
      warningTransparent.toString() +
      '\n   });\n   static const EvaColor dangerTransparent = EvaColor(' +
      dangerTransparentColor.toString() +
      ', {\n      ' +
      dangerTransparent.toString() +
      '\n   });\n}';
}

///convert hex color with opacity
String hexColorWithOpacity(String color) {
  return color.replaceFirst("#", "0xFF");
}

///convert RGBA color to hex with opacity
int hexOfRGBA(int r, int g, int b, double opacity) {
  r = (r < 0) ? -r : r;
  g = (g < 0) ? -g : g;
  b = (b < 0) ? -b : b;
  opacity = (opacity < 0) ? -opacity : opacity;
  opacity = (opacity > 1) ? 255 : opacity * 255;
  r = (r > 255) ? 255 : r;
  g = (g > 255) ? 255 : g;
  b = (b > 255) ? 255 : b;
  int a = opacity.toInt();
  return int.parse(
      '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}');
}

String convertRgbaToHex(int r, int g, int b, double a) {
  int hexLong = hexOfRGBA(r, g, b, a);
  String hex = "0x${hexLong.toRadixString(16)}";
  return hex;
}
