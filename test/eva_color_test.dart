import 'package:eva_color/generator/color.dart';
import 'package:eva_color/generator/option.dart';
import 'package:eva_color/generator/validator.dart';
import 'package:flutter_test/flutter_test.dart';

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
      'test/custom-theme-not-exists.json',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), GeneratorValidator.inputNotExists);
  });

  test('Validator input not json', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/custom-theme.js',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), GeneratorValidator.inputNotJson);
  });

  test('Validator input not valid json', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'test/custom-theme-not-valid.json',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), GeneratorValidator.inputNotValidJson);
  });

  test('Validator input valid', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-i',
      'example/custom-theme.json',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateInputFile(), null);
  });

  test('Validator output not dart', () {
    GeneratorOption generatorOption = GeneratorOption.parseArgs([
      '-o',
      'example/eva_color.bin',
    ]);
    GeneratorValidator validator = GeneratorValidator(
      option: generatorOption,
    );
    expect(validator.validateOutputFile(), GeneratorValidator.outputNotDart);
  });

  test('Color property standard', () {
    ColorProperty primary100 =
        ColorProperty.fromKey('color-primary-100', '#D6E4FF');

    expect(primary100.type, ColorType.STANDARD);
    expect(primary100.name, 'primary');
    expect(primary100.index, '100');
    expect(primary100.hex, '0xFFD6E4FF');
  });

  test('Color property transparent', () {
    ColorProperty transparent200 = ColorProperty.fromKey(
        'color-success-transparent-200', 'rgba(62, 196, 62, 0.08)');

    expect(transparent200.type, ColorType.TRANSPARENT);
    expect(transparent200.name, 'successTransparent');
    expect(transparent200.index, '200');
    expect(transparent200.hex, '0x143EC43E');
  });
}
