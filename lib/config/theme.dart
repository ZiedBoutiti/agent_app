

import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
    primaryColor: secondColor,

    scaffoldBackgroundColor: secondColor,
    appBarTheme:  AppBarTheme(
        backgroundColor: secondColor,
        centerTitle: true,
        titleTextStyle: sAppBarTitle
    )
);