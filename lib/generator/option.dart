import 'package:meta/meta.dart';

class Option {
  static const String defaultInput = 'custom-theme.json';
  static const String defaultOutput = 'lib/eva_colors.dart';
  static const String defaultClassName = 'EvaColors';

  final String input;
  final String output;
  final String className;

  Option({
    @required this.input,
    @required this.output,
    @required this.className,
  })  : assert(input != null),
        assert(output != null),
        assert(className != null);
}
