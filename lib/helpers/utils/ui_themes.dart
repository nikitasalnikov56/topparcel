import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class UIThemes {
  final Brightness brightness;

  UIThemes({this.brightness = Brightness.light});

  // Основная тема приложения (светлая)
  static ThemeData lightTheme() => ThemeData(
        brightness: Brightness.light,
        fontFamily: "SF Pro Display",
        scaffoldBackgroundColor: ModeColors.backgroundPrimary,
        dividerColor: ModeColors.white,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark),
          centerTitle: true,
          backgroundColor: ModeColors.backgroundPrimary,
          elevation: 0,
          shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
        ),
        colorScheme: const ColorScheme.light(
          primary: ModeColors.backgroundPrimary,
          onSecondary: Colors.white,
        ),
        textTheme: const TextTheme(),
      );

  Color get black => ModeColors.black;
  Color get black2 => ModeColors.black2;
  Color get darkGrey => ModeColors.darkGrey;
  Color get grey => ModeColors.grey;
  Color get extraLightGrey => ModeColors.extraLightGrey;
  Color get lightGrey => ModeColors.lightGrey;
  Color get white => ModeColors.white;
  Color get green => ModeColors.green;
  Color get errorColor => ModeColors.errorColor;
  Color get primaryColor => ModeColors.primaryColor;
  Color get orangeColor => ModeColors.orange;
  Color get disableButtonColor => ModeColors.disableButtonColor;
  Color get backgroundPrimary => ModeColors.backgroundPrimary;
  Color get acceptedStatus => ModeColors.green;
  Color get collectedStatus => ModeColors.purple;
  Color get hubSortingStatus => ModeColors.lightBlue;
  Color get pendingStatus => ModeColors.orange;
  Color get transitStatus => ModeColors.lightPurple;
  Color get exportedStatus => ModeColors.yellow;
  Color get deliveredStatus => ModeColors.darkPurple;
  Color get readyStatus => ModeColors.lightGreen;
  Color get draftStatus => ModeColors.pink;
  Color get cancelledStatus => ModeColors.errorColor;
  Color get printerStatus => ModeColors.extraDarkPurple;
  Color get lastUpdateStatus => ModeColors.grey;

  TextStyle get header32Bold => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get header24Bold => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get header20Bold => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get header16Bold => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: black,
      );
  TextStyle get header14Bold => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get header12Bold => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get header14Semibold => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get text20Regular => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get text20Semibold => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get text16Medium => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      );
  TextStyle get text14Medium => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: black,
      );
  TextStyle get text18Medium => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: black,
      );
  TextStyle get text16Regular => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: black,
      );
  TextStyle get text14Regular => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get text12Semibold => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get text12Regular => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: black,
      );
  TextStyle get text10Regular => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: black,
      );
}
