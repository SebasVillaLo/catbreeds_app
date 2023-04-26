import 'package:flutter/material.dart';

import '../../configs/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  final appTheme = AppTheme();

  ThemeData get theme => appTheme.getTheme();
  Brightness get brightness => appTheme.brightness;

  void toggleTheme() {
    appTheme.brightness == Brightness.light
        ? appTheme.setBrightness(Brightness.dark)
        : appTheme.setBrightness(Brightness.light);
    notifyListeners();
  }

  void setThemeColor(int index) {
    appTheme.setSelectedColor(index);
    notifyListeners();
  }
}
