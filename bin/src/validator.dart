import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';

import 'option.dart';

class GeneratorValidator {
  static const String inputNotExists = 'Input file is not exists';
  static const String inputNotJson = 'Input file is not a json file';
  static const String inputNotValidJson = 'Input file is not valid json file';
  static const String outputNotDart = 'Output file must be dart file';
  static const String outputNoPermission =
      'Please check if you have write permission to this directory';
  static const String basicColorNotComplete = "Basic color not complete";

  final GeneratorOption option;

  // parsed json
  Map<String, dynamic> result;

  // prepare output
  File output;

  GeneratorValidator({
    @required this.option,
  }) : assert(option != null);

  /// Validate input file. Return null if no error.
  String validateInputFile() {
    final File file = File(option.input);

    if (!file.existsSync()) {
      return inputNotExists;
    }

    // check extension
    if (basename(file.path).split(".").last != 'json') {
      return inputNotJson;
    }

    // try parse to json
    try {
      result = json.decode(file.readAsStringSync());
    } catch (e) {
      return inputNotValidJson;
    }

    return null;
  }

  /// Validate output file. By default, the existing output will be replaced.
  String validateOutputFile() {
    final File file = File(option.output);

    // check extension
    if (basename(file.path).split(".").last != 'dart') {
      return outputNotDart;
    }

    // try to create the directory.
    final Directory dir = file.parent;
    if (!dir.existsSync()) {
      try {
        dir.createSync(recursive: true);
      } catch (e) {
        return outputNoPermission;
      }
    }

    // assign output
    output = file;

    return null;
  }

  String validateBasicColor() {
    final File file = File(option.input);

    Map<String, dynamic> jsonMap = json.decode(file.readAsStringSync());
    int basicCount = basicColorCount(jsonMap);
    if (basicCount > 0 && basicCount < 23) {
      return basicColorNotComplete;
    }
    if (basicCount == 0) {
      Map<String, dynamic> basicMap =
          json.decode(File("bin/style/basic.json").readAsStringSync());
      jsonMap.addAll(basicMap);
      result = jsonMap;
    }
    return null;
  }

  int basicColorCount(Map<String, dynamic> jsonMap) {
    String basicKey = "color-basic-";
    String basicLightTransparentKey = "color-basic-light-transparent-";
    String basicDarkTransparentKey = "color-basic-dark-transparent-";

    int basicKeyCount = 0;
    int lightKeyCount = 0;
    int darkKeyCount = 0;

    //check for basicKey
    for (int i = 100; i <= 1100; i += 100) {
      if (jsonMap.containsKey(basicKey + "$i")) {
        basicKeyCount++;
      }
    }

    //check for light and dark key
    for (int j = 100; j <= 600; j += 100) {
      if (jsonMap.containsKey(basicDarkTransparentKey + "$j")) {
        darkKeyCount++;
      }
      if (jsonMap.containsKey(basicLightTransparentKey + "$j")) {
        lightKeyCount++;
      }
    }
    return basicKeyCount + lightKeyCount + darkKeyCount;
  }
}
