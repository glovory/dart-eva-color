import 'dart:io';

import 'src/color.dart';
import 'src/formatter.dart';
import 'src/option.dart';
import 'src/util.dart';
import 'src/validator.dart';

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
