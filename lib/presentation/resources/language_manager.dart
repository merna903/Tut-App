import 'package:flutter/material.dart';

enum LanguageType {
  english,
  arabic
}
const String assetPathLocalization = "assets/translations";
const Locale arabicLocal = Locale("ar","SA");
const Locale englishLocal = Locale("en","US");

extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this)
    {
      case LanguageType.english:
        return "en";
      case LanguageType.arabic:
        return "ar";
    }
  }
}