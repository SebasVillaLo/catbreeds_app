import 'package:flutter/material.dart';

const List<Color> colorList = [
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
  int selectedColor = 0;
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;
  int get color => selectedColor;

  void setBrightness(Brightness brightness) {
    _brightness = brightness;
  }

  void setSelectedColor(int color) {
    selectedColor = color;
  }

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorList[selectedColor],
        brightness: _brightness,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
