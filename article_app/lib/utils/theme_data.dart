import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeDetails{
  static final Color primaryColor = Color(0xFF4C2447);
  static final Color blueColor = Color(0xFF3C7DfB);
  static final Color yellowColor = Color(0xFFFC8108);
  static final Color sYellowColor = Color(0xFFCE924A);
  static final Color accentColor = Color(0xFFeef2fd);
  static final Color secondaryColor = Color(0xFF612C5A);
  static final Color lightOrangeColor = Color(0xFFff9d00);
  static final Color lightBadgeColor = Color(0xFFe2e9ff);
  static final Color primaryBadgeColor = Color(0xFFf9d9c9);

  static final ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: primaryColor,
    accentColor: accentColor,
    backgroundColor: Color(0xFFFFFFFF),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
  );

  static final BorderRadius borderRadius = BorderRadius.circular(20.0);
  static final double radius = 60.0;
  static final double length = double.infinity;

}