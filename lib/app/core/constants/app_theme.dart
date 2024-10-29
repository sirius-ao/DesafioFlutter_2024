import 'package:flutter/material.dart';
import 'package:project_management_app/app/core/constants/app_colors.dart';

class AppTheme{
  AppTheme._();
  static _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 2
    ),
    borderRadius: BorderRadius.circular(10)
  );
  //dark theme config
  static final darkTheme = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(
       primary: AppColor.primaryColor, 
       onPrimary: AppColor.blackColor,
       onSurface:AppColor.whiteColor,
    ),
    dialogBackgroundColor: AppColor.cardDarkColor.withOpacity(0.99),
    primaryColor: AppColor.darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkBackgroundColor,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColor.darkBackgroundColor
    ),
    cardTheme: CardTheme(
      color: AppColor.cardDarkColor,
      shadowColor: AppColor.borderOpacityColor
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: AppColor.cardDarkColor,
      clipBehavior: Clip.hardEdge,
      collapsedIconColor: AppColor.primaryColor,
      iconColor: AppColor.primaryColor
    ),
    scaffoldBackgroundColor: AppColor.secondaryBlackColor,
    inputDecorationTheme: InputDecorationTheme(
      border: _border(AppColor.borderColor),
      errorBorder: _border(AppColor.errorColor),
      focusedBorder: _border(AppColor.primaryColor),
      focusedErrorBorder: _border(AppColor.errorColor),
    )
  );

  //ligth theme config
  static final lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light(
       primary: AppColor.primaryColor, 
       onPrimary: AppColor.whiteColor,
       onSurface:AppColor.blackColor,
    ),
    dialogBackgroundColor:AppColor.whiteColor.withOpacity(0.99),
    
    primaryColor: AppColor.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.whiteColor,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColor.whiteColor
    ),
    cardTheme: const CardTheme(
      color: AppColor.whiteColor,
      shadowColor: AppColor.borderColor
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: AppColor.lightBackgroundColor,
      collapsedIconColor: AppColor.primaryColor,
      iconColor: AppColor.primaryColor
    ),
    scaffoldBackgroundColor: AppColor.lightBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      border: _border(AppColor.borderColor),
      errorBorder: _border(AppColor.errorColor),
      focusedBorder: _border(AppColor.primaryColor),
      focusedErrorBorder: _border(AppColor.errorColor),
    ),
  );
}