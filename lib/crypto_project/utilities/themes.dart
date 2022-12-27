import 'package:clean_arch_udemy/clean_project/presentation/resourses/text_style.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getApplicationThemes() {
  return ThemeData(
      primaryColor: AppColor.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: AppConstants.elevation,
        backgroundColor: AppColor.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor.white,
            statusBarIconBrightness: Brightness.dark),
        titleTextStyle: textStyle1(FontSize.s15, AppColor.black,
            FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        fixedSize: const Size(AppConstants.width, AppConstants.height),
        textStyle: textStyle1(FontSize.s14, AppColor.primaryBackground,
            FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        backgroundColor: AppColor.blue,
      )),
      textTheme: TextTheme(
        titleLarge: textStyle1(FontSize.s22, AppColor.black,
            FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
        titleMedium: textStyle1(FontSize.s14, AppColor.black,
            FontWeightConstants.semiBold, FontFamilyConstants.montserrat),
        titleSmall: textStyle1(FontSize.s15, AppColor.black,
            FontWeightConstants.medium, FontFamilyConstants.montserrat),
      ),

      // we can also put inputDecorationTheme for textFromField
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderSize),
            borderSide: const BorderSide(
                color: Colors.black, width: AppConstants.borderWidth)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderSize),
            borderSide: const BorderSide(
                width: AppConstants.borderWidth, color: Colors.black)),
      ));
}

// Button Theme
//Text Theme
