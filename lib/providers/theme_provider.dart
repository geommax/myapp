import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  AppColors get colors => _isDarkMode ? DarkColors() : LightColors();
}


abstract class AppColors {
  Color get appbarBackground;
  Color get ribbonbarBackground;
  Color get iconColor;
  Color get subIconColor;
  Color get tabSelected;
  Color get defaultLabelColor;
  Color get subLabelColor;
  Color get selectedLabelColor;
  Color get unselectedLabelColor;
}


class DarkColors implements AppColors {
  @override
  Color get appbarBackground => Colors.blueGrey[900]!;

  @override
  Color get ribbonbarBackground => Colors.blueGrey[800]!;

  @override
  Color get iconColor => Colors.white;

  @override
  Color get subIconColor => Colors.white54;

  @override
  Color get tabSelected => Colors.blueGrey[600]!;

  @override
  Color get defaultLabelColor => Colors.white;

  @override
  Color get subLabelColor => Colors.white70;

  @override
  Color get selectedLabelColor => Colors.black;

  @override
  Color get unselectedLabelColor => Colors.white54;

}

class LightColors implements AppColors {
  @override
  Color get appbarBackground => Colors.blueGrey[100]!;

  @override
  Color get ribbonbarBackground => Colors.blueGrey[200]!;

  @override
  Color get iconColor => Colors.black;

  @override
  Color get subIconColor => Colors.black54;

  @override
  Color get tabSelected => Colors.blueGrey[400]!;

  @override
  Color get defaultLabelColor => Colors.black;

  @override
  Color get subLabelColor => Colors.black54;

  @override
  Color get selectedLabelColor => Colors.white;

  @override
  Color get unselectedLabelColor => Colors.black54;

}

