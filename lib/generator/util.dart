import 'package:args/args.dart';

import 'option.dart';

GeneratorOption parseArgs(List<String> args) {
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
