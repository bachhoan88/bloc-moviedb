import 'package:flutter/material.dart';
import 'package:flutter_bloc_base/src/ui/theme/colors.dart';

final ThemeData defaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: backgroundColor,
  fontFamily: 'Muli',
  appBarTheme: AppBarTheme(
    color: backgroundColor,
    iconTheme: IconThemeData(color: accentLightColor),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: accentLightColor,
    disabledColor: primaryColorDark,
  ),
);
