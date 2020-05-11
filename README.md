#EVA COLOR
Eva Design Color Converter.
Generate dart file automatically from JSON file containing the eva theme color.

##INSTALLATION
1. Import it into your pubspec dependencies:

```yaml
dependencies:
  eva_color:
      git:
        url: https://github.com/glovory/dart-eva-color.git
```
2. You can install packages from the command line:

```bash
   $ flutter pub get
```
## USAGE
1. Put file "eva_theme.json" that contains eva design color themes in the root of your project.
2. Run `flutter pub run eva_color:generate_color`.
3. By default file that have been successfully created will be placed in `lib/eva_color.dart`.

### EXAMPLE
1. Import your generate file to your page.
```dart
import './eva_color.dart';
```
2. Use Eva Color Scheme with `EvaColors.primary` or with number shade like `EvaColors.primary.shade100`
```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New APPS',style: TextStyle(color: EvaColors.primary)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello World',style: TextStyle(color: EvaColors.primary.shade100),
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

```
###  Command arguments Color Converter

The default JSON input file directory is ` ./eva_theme.json`,
you can custom input file directory by `-i` argument, for example:

```shell
flutter pub run eva_color:generate_color -i json_files
or
flutter pub run eva_color:generate_color --input json_files
```

You can also custom the output directory by `-o` argument:

```shell
flutter pub run eva_color:generate_color -o dart_file
or
flutter pub run eva_color:generate_color --output dart_file
```
or custom both of them

```shell
flutter pub run eva_color:generate_color -i json_files -o dart_file
or
flutter pub run eva_color:generate_color --input json_files --output dart_file
```
