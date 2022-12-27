import 'package:clean_arch_udemy/clean_project/presentation/resourses/text_style.dart';
import 'package:clean_arch_udemy/clean_project/presentation/resourses/values_style.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_font.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main Color
    primaryColor: AppColor.primary,
    disabledColor: AppColor.disabledButton,
    // card Theme
    cardTheme: const CardTheme(
        color: AppColor.disabledButton,
        elevation: AppValues.elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppValues.s16)))),
    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColor.primary,
      titleTextStyle: textStyle1(FontSize.s29, AppColor.primaryBackground,
          FontWeightConstants.ubuntuBold, FontFamilyConstants.ubuntu),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      fixedSize: const Size(AppValues.width, AppValues.height),
      textStyle: textStyle1(FontSize.s22, AppColor.primaryBackground,
          FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      backgroundColor: AppColor.primaryButton,
    )),
    textTheme: TextTheme(
      displayLarge: textStyle1(FontSize.s50, AppColor.white,
          FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
      displayMedium: textStyle1(FontSize.s30, AppColor.white,
          FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
      titleLarge: textStyle1(FontSize.s25, AppColor.white,
          FontWeightConstants.ubuntuBold, FontFamilyConstants.ubuntu),
      labelLarge: textStyle1(FontSize.s20, AppColor.black,
          FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
      // headline1: textStyle1(FontSize.s29, AppColor.black,
      //     FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
      titleMedium: textStyle1(FontSize.s29, AppColor.black,
          FontWeightConstants.medium, FontFamilyConstants.montserrat),
      titleSmall: textStyle1(FontSize.s20, AppColor.black,
          FontWeightConstants.medium, FontFamilyConstants.montserrat),
    ),

    // we can also put inputDecorationTheme for textFromField
  );
}

// Button Theme
//Text Theme
