import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:eva_color/utils.dart';

const tpl =
    "import 'dart:ui';\nimport 'package:eva_color/eva_color.dart';\n\n\n//@auto generate do not edit\nclass EvaColors {";
String src;
String dest;

void generateFileFromArguments(List<String> arguments) {
  ArgParser parser = ArgParser();

  parser.addOption('input', abbr: 'i', defaultsTo: './eva_theme.json',
      callback: (value) {
    return src = value;
  }, help: "Specify the json directory.");
  parser.addOption('output', abbr: 'o', defaultsTo: 'lib/eva_colors.dart',
      callback: (value) {
    return dest = value;
  }, help: "Specify the output directory.");
  parser.addFlag('help', abbr: 'h', help: 'Usage help', negatable: false);
  final arg = parser.parse(arguments);

  if (arg['help']) {
    stdout.writeln('Eva Design Color Converter');
    stdout.writeln(parser.usage);
    exit(0);
  }
  generateDartFileFromJson(src, dest);
}

void generateDartFileFromJson(String inputPath, String outputPath) {
  File inputFile = File(inputPath);
  Directory destPath = Directory(outputPath);

  if (destPath.isAbsolute) {
    outputPath = destPath.uri.toString().replaceAll('//', '/');
    outputPath = outputPath.substring(0, outputPath.length - 1);
    outputPath = outputPath.replaceFirst('file:', '');
  }

  // validate input file exist
  if (!inputFile.existsSync()) {
    print('File is not exist!');
    exit(1);
  }
  // validate output path valid
  if (!isOutputPathValid(outputPath)) {
    print('Invalid output path');
    exit(1);
  }
  // validate file input is JSON
  if (!isFileJson(inputPath)) {
    print('Input file type must be json!');
    exit(1);
  }
  // validate file output is Dart
  if (!isFileDart(outputPath)) {
    print('Output file type must be dart!');
    exit(1);
  }
  // do generate file and validate success or not
  if (!isGenerateFile(inputFile, outputPath)) {
    print('Generate file failed');
    exit(1);
  }

  print('Successfully generate file');
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
      hexOfRGBA(int.parse(rgbaVal[0]), int.parse(rgbaVal[1]),
          int.parse(rgbaVal[2]), double.parse(rgbaVal[3])) +
      '),');
  sinkColor.write('\n      ');
  if (numberColor == '500') {
    color500.write(hexOfRGBA(
        int.parse(rgbaVal[0]),
        int.parse(rgbaVal[1]),
        int.parse(rgbaVal[2]),
        double.parse(rgbaVal[3])));
  }
}

bool isGenerateFile(File file, String outputPath) {
  Map<String, dynamic> map;
  try {
    map = json.decode(file.readAsStringSync());
  } catch (error) {
    print('Invalid json format!');
    return false;
  }

  /// initialization of variable StringBuffer for write files
  StringBuffer sinkColorPrimary =  StringBuffer();
  StringBuffer sinkColorSuccess =  StringBuffer();
  StringBuffer sinkColorInfo =  StringBuffer();
  StringBuffer sinkColorWarning =  StringBuffer();
  StringBuffer sinkColorDanger =  StringBuffer();
  StringBuffer sinkColorPrimaryTransparent =  StringBuffer();
  StringBuffer sinkColorSuccessTransparent =  StringBuffer();
  StringBuffer sinkColorInfoTransparent =  StringBuffer();
  StringBuffer sinkColorWarningTransparent =  StringBuffer();
  StringBuffer sinkColorDangerTransparent =  StringBuffer();
  StringBuffer colorPrimary =  StringBuffer();
  StringBuffer colorSuccess =  StringBuffer();
  StringBuffer colorInfo =  StringBuffer();
  StringBuffer colorWarning =  StringBuffer();
  StringBuffer colorDanger =  StringBuffer();
  StringBuffer colorPrimaryTransparent =  StringBuffer();
  StringBuffer colorSuccessTransparent =  StringBuffer();
  StringBuffer colorInfoTransparent =  StringBuffer();
  StringBuffer colorWarningTransparent =  StringBuffer();
  StringBuffer colorDangerTransparent =  StringBuffer();

  map.forEach((key, val) {
    List<String> indexColor = key.split("-");
    if (indexColor.length == 3) {
      //generate for non transparent color
      switch (indexColor[1]) {
        case 'primary':
          writeColorToBuffer(
              sinkColorPrimary, colorPrimary, indexColor[2], val);
          break;

        case 'success':
          writeColorToBuffer(
              sinkColorSuccess, colorSuccess, indexColor[2], val);
          break;

        case 'info':
          writeColorToBuffer(sinkColorInfo, colorInfo, indexColor[2], val);
          break;
        case 'warning':
          writeColorToBuffer(
              sinkColorWarning, colorWarning, indexColor[2], val);
          break;

        case 'danger':
          writeColorToBuffer(sinkColorDanger, colorDanger, indexColor[2], val);
          break;
      }
    } else {
      //generate for transparent color
      String rgba = val.substring(5, val.length - 1);
      List<String> rgbaVal = rgba.split(",");

      switch (indexColor[1]) {
        case 'primary':
          writeTransparentColorToBuffer(sinkColorPrimaryTransparent,
              colorPrimaryTransparent, indexColor[3], rgbaVal);
          break;

        case 'success':
          writeTransparentColorToBuffer(sinkColorSuccessTransparent,
              colorSuccessTransparent, indexColor[3], rgbaVal);
          break;

        case 'info':
          writeTransparentColorToBuffer(sinkColorInfoTransparent,
              colorInfoTransparent, indexColor[3], rgbaVal);
          break;
        case 'warning':
          writeTransparentColorToBuffer(sinkColorWarningTransparent,
              colorWarningTransparent, indexColor[3], rgbaVal);
          break;

        case 'danger':
          writeTransparentColorToBuffer(sinkColorDangerTransparent,
              colorDangerTransparent, indexColor[3], rgbaVal);
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
  new File(outputPath)
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
