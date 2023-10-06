import 'package:flutter/material.dart';
import 'package:new_project/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "prefsKeyLang";
const String prefsKeyOnBoardingScreenView = "prefsKeyOnBoardingScreenView";
const String prefsKeyIsUserLoggedIn = "prefsKeyIsUserLoggedIn";
const String prefsKeyIsUserRegistered = "prefsKeyIsUserRegistered";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    return language != null && language.isNotEmpty
        ? language
        : LanguageType.english.getValue();
  }

  Future<Locale> getLocalLanguage() async {
    String language = await getAppLanguage();
    return language == LanguageType.english.getValue()
        ? arabicLocal
        : englishLocal;
  }

  Future<void> setAppLanguage() async {
    String language = await getAppLanguage();
    language == LanguageType.english.getValue()
        ? _sharedPreferences.setString(
            prefsKeyLang, LanguageType.arabic.getValue())
        : _sharedPreferences.setString(
            prefsKeyLang, LanguageType.english.getValue());
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnBoardingScreenView, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnBoardingScreenView) ?? false;
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> setUserRegistered() async {
    _sharedPreferences.setBool(prefsKeyIsUserRegistered, true);
  }

  Future<bool> isUserRegistered() async {
    return _sharedPreferences.getBool(prefsKeyIsUserRegistered) ?? false;
  }

  Future<void> logOut() async {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }
}
