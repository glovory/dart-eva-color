import 'package:args/args.dart';
import 'package:meta/meta.dart';

class GeneratorOption {
  static const String defaultInput = 'custom-theme.json';
  static const String defaultOutput = 'lib/eva_colors.dart';
  static const String defaultClassName = 'EvaColors';

  final String input;
  final String output;
  final String className;

  GeneratorOption({
    @required this.input,
    @required this.output,
    @required this.className,
  })  : assert(input != null),
        assert(output != null),
        assert(className != null);

  /// Parse the generator from list of args
  factory GeneratorOption.parseArgs(List<String> args) {
    ArgParser parser = ArgParser();

    parser.addOption(
      'input',
      abbr: 'i',
      defaultsTo: GeneratorOption.defaultInput,
      callback: (value) {
        print('Input file is ' + value);
      },
      help: "Specify the json input file path.",
    );

    parser.addOption(
      'output',
      abbr: 'o',
      defaultsTo: GeneratorOption.defaultOutput,
      callback: (value) {
        print('Output file is ' + value);
      },
      help: "Specify the dart output file path.",
    );

    parser.addOption(
      'class',
      abbr: 'c',
      defaultsTo: GeneratorOption.defaultClassName,
      callback: (value) {
        print('Class name is ' + value);
      },
      help: "Specify the dart generated class name.",
    );

//  parser.addFlag('help', abbr: 'h', help: 'Usage help', negatable: false);

    ArgResults parsedArgs = parser.parse(args);

//  if (parsedArgs['help']) {
//    stdout.writeln('Eva Design Color Converter');
//    stdout.writeln(parser.usage);
//    exit(0);
//  }

    return GeneratorOption(
      input: parsedArgs['input'],
      output: parsedArgs['output'],
      className: parsedArgs['class'],
    );
  }
}
