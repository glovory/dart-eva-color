[![version](https://img.shields.io/badge/version-1.0.1-blue)](https://pub.dev/packages/eva_color)
[![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://opensource.org/licenses/BSD-2-Clause)

# EVA COLOR

Simple [Eva Design System](https://eva.design) color class for Flutter,
with dart generator from eva theme json file.

> Eva Design is a trademark of Akveo LLC

## INSTALLATION

1. Just include it into your `pubspec.yaml` dependencies:
   ```
   eva_color: ^1.0.1
   ```
2. Run command to update the dependencies:
   ```bash
   $ flutter pub get
   ```

## FEATURES

1. __Color Swatches__. This package provide 2 color class for Eva Design
   standard output:
   ```
   EvaColor -> used for the basic color with 9 shades
   EvaTransparentColor -> used for transparent color with 6 shades
   ```
   These classes are compatible with `dart:ui` and can be used in any
   color definition in the Flutter style / UI.
2. __Generator__. To easily generate color, there is a command to
   generate dart file for your project, using the json file exported
   from the [Eva Color Site](https://colors.eva.design/). The generated
   dart file will import and use `EvaColor` class and
   `EvaTransparentColor` class from this package.

## DART COLOR SCHEME GENERATOR

1. Prepare the file `custom-theme.json` exported from the site. The
   default location is in your root Flutter project.
2. Run `flutter pub run eva_color:generate` in command line.
3. Default output file will be in placed in `lib/eva_color.dart`. See
   options below for customization.
4. Example command
   ```
   flutter pub run eva_color:generate -i assets/my-app-color.json -o lib/config/color.dart -c AppColor`.
   ```

### GENERATOR OPTIONS (CLI ARGUMENTS)

```
-i or --input : Define input file, anywhere using relative or absolute path. Default to ${PROJECT_DIR}/custom-theme.json
-o or --output : Define output file, anywhere using relative or absolute path. Default to ${PROJECT_DIR}/lib/eva_colors.dart
-c or --class : Define class name for the generated color scheme. Default to EvaColors
```

## USAGE

Below is how you use the color in your project.

1. Suppose the output file is in your `/lib/eva_colors.dart` and the
   class is default to `EvaColors`.
2. Sample output.
   ```
   import 'dart:ui';

   import 'package:eva_color/eva_color.dart';
    
   // @autogenerate DO NOT EDIT!!!
   class EvaColors {
     static const EvaColor primary = EvaColor(0xFF3366FF, {
       100: Color(0xFFD6E4FF),
       200: Color(0xFFADC8FF),
       300: Color(0xFF84A9FF),
       400: Color(0xFF6690FF),
       500: Color(0xFF3366FF),
       600: Color(0xFF254EDB),
       700: Color(0xFF1939B7),
       800: Color(0xFF102693),
       900: Color(0xFF091A7A),
     });
    
     static const EvaTransparentColor primaryTransparent =
         EvaTransparentColor(0x663366FF, {
       100: Color(0x143366FF),
       200: Color(0x283366FF),
       300: Color(0x3D3366FF),
       400: Color(0x513366FF),
       500: Color(0x663366FF),
       600: Color(0x7A3366FF),
     });
    
     // other colors below
   }
   ```
3. Import your generated file to your desired page.
   ```dart
   import 'eva_colors.dart'; // or use absolute import
   ```
4. Use Eva Color Scheme by its name `EvaColors.primary` for primary
   shade, or lighter/darker shade such as `EvaColors.primary.shade100`.
   ```dart
   Widget container = Container(
     color: EvaColors.primary,
   );
   ```

## TIPS
### Basic Color
By default, basic color is not provided by generated json from colors.eva.design. flutter_eva_color already generated the basic color using default value from eva design. if you want to custom the value just add below code with your desired value into generated json from colors.eva.design and you must provide every basic value on code below, or it will failed to generate the class 
```
  "color-basic-100": "#FFFFFF",
  "color-basic-200": "#F7F9FC",
  "color-basic-300": "#EDF1F7",
  "color-basic-400": "#E4E9F2",
  "color-basic-500": "#C5CEE0",
  "color-basic-600": "#8F9BB3",
  "color-basic-700": "#2E3A59",
  "color-basic-800": "#222B45",
  "color-basic-900": "#192038",
  "color-basic-1000": "#151A30",
  "color-basic-1100": "#101426",
  "color-basic-light-transparent-100": "rgba(142, 155, 179, 0.08)",
  "color-basic-light-transparent-200": "rgba(142, 155, 179, 0.16)",
  "color-basic-light-transparent-300": "rgba(142, 155, 179, 0.24)",
  "color-basic-light-transparent-400": "rgba(142, 155, 179, 0.32)",
  "color-basic-light-transparent-500": "rgba(142, 155, 179, 0.4)",
  "color-basic-light-transparent-600": "rgba(142, 155, 179, 0.48)",
  "color-basic-dark-transparent-100": "rgba(255, 255, 225, 0.08)",
  "color-basic-dark-transparent-200": "rgba(255, 255, 255, 0.16)",
  "color-basic-dark-transparent-300": "rgba(255, 255, 255, 0.24)",
  "color-basic-dark-transparent-400": "rgba(255, 255, 255, 0.32)",
  "color-basic-dark-transparent-500": "rgba(255, 255, 255, 0.4)",
  "color-basic-dark-transparent-600": "rgba(255, 255, 255, 0.48)",
```
### Color Shades
If you want to add more Eva Color shades, just add it in the
`custom-theme.json` provided by the exported file. For example, adding
accent colors with shades:

```
"color-accent-100": "#D6E4FF",
"color-accent-200": "#ADC8FF",
"color-accent-300": "#84A9FF",
"color-accent-400": "#6690FF",
"color-accent-500": "#3366FF",
"color-accent-600": "#254EDB",
"color-accent-700": "#1939B7",
"color-accent-800": "#102693",
"color-accent-900": "#091A7A",
```
