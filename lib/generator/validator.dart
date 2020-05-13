import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';

import 'option.dart';

class GeneratorValidator {
  static const String inputNotExists = 'Input file is not exists';
  static const String inputNotJson = 'Input file is not valid json file';
  static const String outputNotDart = 'Output file must be dart file';
  static const String outputNoPermission =
      'Please check if you have write permission to this directory';

  final GeneratorOption option;

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

    return null;
  }
}
