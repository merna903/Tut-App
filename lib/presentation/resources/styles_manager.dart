
import 'package:flutter/material.dart';
import 'package:new_project/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color){
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    fontWeight: fontWeight,
    color: color
  );
}

TextStyle getRegularStyle({
  double fontSize = FontSize.s14,
  FontWeight fontWeight = FontWeightManager.regular,
  required Color color })
{
  return _getTextStyle(fontSize, fontWeight, color);
}

TextStyle getMediumStyle({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.medium,
  required Color color })
{
  return _getTextStyle(fontSize, fontWeight, color);
}

TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.semiBold,
  required Color color })
{
  return _getTextStyle(fontSize, fontWeight, color);
}

TextStyle getBoldStyle({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.bold,
  required Color color })
{
  return _getTextStyle(fontSize, fontWeight, color);
}

TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.light,
  required Color color })
{
  return _getTextStyle(fontSize, fontWeight, color);
}