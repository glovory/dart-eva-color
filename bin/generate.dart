import 'dart:io';

import '../lib/generator/color.dart';
import '../lib/generator/formatter.dart';
import '../lib/generator/option.dart';
import '../lib/generator/util.dart';
import '../lib/generator/validator.dart';

void main(List<String> args) {
  // options
  GeneratorOption opts = GeneratorOption.parseArgs(args);

  // validate
  GeneratorValidator validator = GeneratorValidator(option: opts);

  // validate input
  String validateInput = validator.validateInputFile();
  if (validateInput != null) {
    print(validateInput);
    exit(1);
  }

  // validate output
  String validateOutput = validator.validateOutputFile();
  if (validateOutput != null) {
    print(validateOutput);
    exit(1);
  }

  // parse to list of swatches
  final List<ColorSwatchProperty> swatches = parseJsonTheme(validator.result);

  // format now
  GeneratorFormatter formatter = GeneratorFormatter();
  final String output = formatter.formatClass(
    opts.className,
    formatter.formatBody(swatches),
  );

  writeReplaceFile(validator.output, output);

  print('Generate success');
}
