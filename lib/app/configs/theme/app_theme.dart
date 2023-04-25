import 'package:flutter/material.dart';

const List<Color> _colorList = [
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.lime,
  Colors.indigo,
  Colors.amber,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];

class AppTheme {
  /// [selectedColor] must be greater then 0 and less or equal to [_colorList.length - 1]
  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < _colorList.length,
            'Selected color must be less or equal to ${_colorList.length - 1}');
  final int selectedColor;

  /// [getTheme] returns the theme data based on the selected color
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _colorList[selectedColor],
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      );
}
