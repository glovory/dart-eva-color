# EVA COLOR

Simple Eva Design System color class for Flutter, with dart generator
from eva theme json file.

> Eva Design is a trademark of Akveo LLC

## INSTALLATION

1. Just include it into your `pubspec.yaml` dependencies:

`//TODO Publish in pub.dev and add the package name here`

2. Run command to update the dependencies:

```bash
   $ flutter pub get
```

## FEATURES

1. This package provide 2 color class for Eva Design standard output:
   ```
   EvaColor -> used for the basic color with 9 shades
   EvaTransparentColor -> used for transparent color with 6 shades
   ```
   These classes are compatible with `dart:ui` and can be used in any
   color definition in the Flutter style / UI.
2. To easily generate color, there is a command to generate dart file
   for your project, using the json file exported from the [Eva Color
   Site](https://colors.eva.design/). The generated dart file will
   import and use `EvaColor` class and `EvaTransparentColor` class from
   this package.

## USAGE

1. Prepare the file `custom-theme.json` exported from the site. The
   default location is in your root Flutter project.
2. Run `flutter pub run eva_color:generate` in command line.
3. Default output file will be in placed in `lib/eva_color.dart`. See
   options below for customization.

## OPTIONS

```
-i or --input : Define input file, anywhere using relative or absolute path. Default to ${PROJECT_DIR}/custom-theme.json
-o or --output : Define output file, anywhere using relative or absolute path. Default to ${PROJECT_DIR}/lib/eva_colors.dart
-c or --class : Define class name for the generated color scheme. Default to EvaColors
```

## EXAMPLE

Below is how you use the color in your project.

1. Suppose the output file is in your `/lib/eva_colors.dart`.
2. Import your generated file to your page.
   ```dart
   import 'eva_colors.dart'; // or use absolute import
   ```
3. Use Eva Color Scheme with `EvaColors.primary` or with specific shade
   such as `EvaColors.primary.shade100`
   ```dart
   Widget container = Container(
     color: EvaColors.primary,
   );
   ```
