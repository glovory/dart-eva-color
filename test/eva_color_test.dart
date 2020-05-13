import 'package:eva_color/generator/option.dart';
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
  });
}
