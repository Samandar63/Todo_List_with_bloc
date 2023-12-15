import 'package:flutter/material.dart';

enum AppTheme { lightTheme, darkTheme }

class AppThemes {
  static final appTheme = {
    AppTheme.darkTheme: ThemeData.dark(),
    AppTheme.lightTheme: ThemeData.light(),
  };
}
