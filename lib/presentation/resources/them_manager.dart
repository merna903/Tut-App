import 'package:flutter/material.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/font_manager.dart';
import 'package:new_project/presentation/resources/styles_manager.dart';
import 'package:new_project/presentation/resources/values_manager.dart';

ThemeData getAppThem(){
  return ThemeData(
    //main colors
    primaryColor:  ColorManger.primary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.gray1,
    splashColor: ColorManger.lightPrimary,

    cardTheme: CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.gray,
      elevation: AppSize.z4,
    ),

    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManger.primary,
      elevation: AppSize.z4,
      shadowColor: ColorManger.lightPrimary,
      titleTextStyle: getRegularStyle(
          fontSize:FontSize.s16,
          color: ColorManger.white),
    ),

    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManger.gray1,
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.lightPrimary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
            color: ColorManger.white,
            fontSize: FontSize.s17),
        backgroundColor: ColorManger.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.z12)
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManger.darkGray,
          fontSize: FontSize.s16),
      titleMedium: getMediumStyle(
        color: ColorManger.primary,
        fontSize: FontSize.s16),
      headlineMedium: getRegularStyle(
        color: ColorManger.darkGray,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(color: ColorManger.gray1),
      bodyLarge: getRegularStyle(color: ColorManger.gray),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManger.gray,fontSize: FontSize.s14),
      labelStyle: getMediumStyle(color: ColorManger.gray,fontSize: 14),
      errorStyle: getRegularStyle(color: ColorManger.error) ,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.gray,
          width: AppSize.z2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.z8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSize.z2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.z8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.error,
          width: AppSize.z2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.z8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSize.z2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.z8)),
      ),
    ),

  );
}