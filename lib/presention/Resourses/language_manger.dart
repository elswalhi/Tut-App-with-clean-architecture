// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';

enum LanguageType{ENGLISH,ARABIC}
const String ARABIC="ar";
const String ENGLISH="en";
const String AssetsPathLocalization="assets/translation";
const Locale ARABIC_LOCALE=Locale('ar',"SA");
const Locale ENGLISH_LOCALE=Locale('en',"US");

extension LanguageTypeExetension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
      return ARABIC;
    }
  }
}