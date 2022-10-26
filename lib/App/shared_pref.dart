
// ignore_for_file: constant_identifier_names

import 'package:advanced_flutter/presention/Resourses/language_manger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANGUAGE = "PREFS_KEY_LANGUAGE";
const String PREFS_KEY_ON_BOARDING = "PREFS_KEY_ON_BOARDING";
const String PREFS_KEY_LOGIN = "PREFS_KEY_LOGIN";

class AppPreferences{
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
   Future<String> getAppLanguage() async{
  String? language= _sharedPreferences.getString(PREFS_KEY_LANGUAGE);
    if(language !=null && language.isNotEmpty){
      return language;
    }
    else{
      return LanguageType.ENGLISH.getValue();
    }
   }
   Future<void> changeAppLanguage()async{
     String currentLanguage = await getAppLanguage();
     if (currentLanguage==LanguageType.ARABIC.getValue()){
      // set english
       _sharedPreferences.setString(PREFS_KEY_LANGUAGE, LanguageType.ENGLISH.getValue());
     }else{
       // set arabic
       _sharedPreferences.setString(PREFS_KEY_LANGUAGE, LanguageType.ARABIC.getValue());

     }
   }
   Future<Locale> getLocale()async{
     String currentLanguage = await getAppLanguage();
     if (currentLanguage==LanguageType.ARABIC.getValue()){
       return ARABIC_LOCALE;
      // set english
     }else{
       // set arabic
       return ENGLISH_LOCALE;
     }
   }


   // ON_BOARDING
  Future<void> setOnBoardingScreenViewed() async{
     _sharedPreferences.setBool(PREFS_KEY_ON_BOARDING, true);
  }
  Future<bool> isOnBoardingScreenViewed() async {
     return _sharedPreferences.getBool(PREFS_KEY_ON_BOARDING) ?? false ;
  }
  Future<void> setLoginScreenViewed() async{
     _sharedPreferences.setBool(PREFS_KEY_LOGIN, true);
  }
  Future<bool> isLoginScreenViewed() async {
     return _sharedPreferences.getBool(PREFS_KEY_LOGIN) ?? false ;
  }
  
  Future<void> logOut() async{
     _sharedPreferences.remove(PREFS_KEY_LOGIN);
}
}