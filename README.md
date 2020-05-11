
### Eva Design Color Converter
1. Put file "eva_theme.json" that contains eva design color themes in the root of your project.
2. Run `flutter pub run evacolor:generate_color`.
3. By default file that have been successfully created will be placed in `lib/eva_color.dart`.
4. Import your generate file to your page.
5. Use Eva Color Scheme with `EvaColors.primary` or with number shade like `EvaColors.primary.shade100`


####  Command arguments Color Converter

The default JSON input file directory is ` ./eva_theme.json`,
you can custom input file directory by `-i` argument, for example:

```shell
flutter pub run evacolor:generate_color -i json_files
or
flutter pub run evacolor:generate_color --input json_files
```

You can also custom the output directory by `-o` argument:

```shell
flutter pub run evacolor:generate_color -o dart_file
or
flutter pub run evacolor:generate_color --output dart_file
```
or custom both of them

```shell
flutter pub run evacolor:generate_color -i json_files -o dart_file
or
flutter pub run evacolor:generate_color --input json_files --output dart_file
```
