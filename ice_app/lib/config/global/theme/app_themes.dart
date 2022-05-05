// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AppTheme {
  IceLight,
  IceDark,
}

final appThemeData = {
  AppTheme.IceLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal[300],
  ),
  AppTheme.IceDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal[300],
  ),
};