import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../bin/src/color.dart';
import '../bin/src/formatter.dart';
import '../bin/src/option.dart';
import '../bin/src/util.dart';
import '../bin/src/validator.dart';

void main() {
  test('Argument parser', () {
    List<String> inputArgs = ['-i', 'assets/custom-theme.json'];
    List<String> outputArgs = ['-o', 'lib/config/style.dart'];
    List<String> classNameArgs = ['-c', 'MyColors'];

    GeneratorOption result;

    result = GeneratorOption.parseArgs(inputArgs);
    expect(result.input, inputArgs[1]);
    expect(result.output, GeneratorOption.defaultOutput);
    expect(result.className, GeneratorOption.defaultClassName);

    result = GeneratorOption.parseArgs(outputArgs);
    expect(result.input, GeneratorOption.defaultInput);
    expect(result.output, outputArgs[1]);
    expect(result.className, GeneratorOption.defaultClassName);

    result = GeneratorOption.parseArgs(classNameArgs);
    expect(result.input, GeneratorOption.defaultInput);
    expect(result.output, GeneratorOption.defaultOutput);
    expect(result.className, classNameArgs[1]);

    result = GeneratorOption.parseArgs(
      List()..addAll(inputArgs)..addAll(outputArgs)..addAll(classNameArgs),
    );
    expect(result.input, inputArgs[1]);
    expect(result.output, outputArgs[1]);
    expect(result.className, classNameArgs[1]);
  });

  test('Validator input not exists', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme-not-exists.json',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), GeneratorValidator.inputNotExists);
  });

  test('Validator input not json', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme.js',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), GeneratorValidator.inputNotJson);
  });

  test('Validator input not valid json', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme-not-valid.json',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), GeneratorValidator.inputNotValidJson);
  });

  test('Validator input valid', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme.json',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), null);
  });

  test('Validator output not dart', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-o',
      'test/input_output/eva_color.bin',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateOutputFile(), GeneratorValidator.outputNotDart);
  });

  test('Color property standard', () {
    ColorProperty primary100 =
        ColorProperty.fromLine('color-primary-100', '#D6E4FF');

    expect(primary100.type, ColorType.standard);
    expect(primary100.name, 'primary');
    expect(primary100.index, '100');
    expect(primary100.hex, '0xFFD6E4FF');
  });

  test('Color property transparent', () {
    ColorProperty transparent200 = ColorProperty.fromLine(
        'color-success-transparent-200', 'rgba(62, 196, 62, 0.08)');
    expect(transparent200.type, ColorType.transparent);
    expect(transparent200.name, 'successTransparent');
    expect(transparent200.index, '200');
    expect(transparent200.hex, '0x143EC43E');
  });

  test('Validate basic color with incomplete basic color json', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme-incomplete-basic.json',
      '-o',
      'test/input_output/eva_colors.dart',
      '-c',
      'MyColors',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );

    expect(validator.validateInputFile(), null);
    expect(validator.validateOutputFile(), null);
    expect(
      validator
          .validateBasicColor(Directory.current.path + "/bin/style/basic.json"),
      GeneratorValidator.basicColorNotValid,
    );
  });

  test('Validate json with no basic color (using default)', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme-no-basic.json',
      '-o',
      'test/input_output/eva_colors.dart',
      '-c',
      'MyColors',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );

    expect(validator.validateInputFile(), null);
    expect(validator.validateOutputFile(), null);
    expect(
        validator.validateBasicColor(
            Directory.current.path + "/bin/style/basic.json"),
        null);
  });

  test('Full generate with basic color defined', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme.json',
      '-o',
      'test/input_output/eva_colors.dart',
      '-c',
      'MyColors',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), null);
    expect(validator.validateOutputFile(), null);
    expect(validator.validateBasicColor(Directory.current.path), null);

    List<ColorSwatchProperty> swatches = parseJsonTheme(validator.result);
    expect(swatches.length, 13);

    // format now
    GeneratorFormatter formatter = GeneratorFormatter();
    final String output = formatter.formatClass(
      generatorOption.className,
      formatter.formatBody(swatches),
    );

    writeReplaceFile(validator.output, output);
  });

  test('Full generate with no basic color defined', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/input_output/custom-theme-no-basic.json',
      '-o',
      'test/input_output/eva_colors.dart',
      '-c',
      'MyColors',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), null);
    expect(validator.validateOutputFile(), null);
    expect(
        validator.validateBasicColor(
            Directory.current.path + "/bin/style/basic.json"),
        null);

    List<ColorSwatchProperty> swatches = parseJsonTheme(validator.result);
    expect(swatches.length, 13);

    // format now
    GeneratorFormatter formatter = GeneratorFormatter();
    final String output = formatter.formatClass(
      generatorOption.className,
      formatter.formatBody(swatches),
    );

    writeReplaceFile(validator.output, output);
  });
}
