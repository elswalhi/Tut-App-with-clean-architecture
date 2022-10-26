
import 'package:advanced_flutter/presention/Resourses/ValuesManger.dart';
import 'package:advanced_flutter/presention/Resourses/colors.dart';
import 'package:advanced_flutter/presention/Resourses/fontManger.dart';
import 'package:advanced_flutter/presention/Resourses/style_manger.dart';
import 'package:flutter/material.dart';

ThemeData AppTheme(){
  return ThemeData(
    // main color
    primaryColor: ColorManger.primary,
    primaryColorLight:ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1,
    splashColor: ColorManger.lightPrimary,

    // card view theme

    cardTheme: CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.grey,
      elevation: AppSize.s4,
  ),

    //appbar theme

    appBarTheme:  AppBarTheme(
      centerTitle: true,
      color: ColorManger.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManger.lightPrimary,
      titleTextStyle: RegularStyle(color:ColorManger.white ,fontsize: Fontsize.s16),
    ),

    // button theme

    buttonTheme:  ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManger.grey1,
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.lightPrimary,
    ),
    // elevated
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: RegularStyle(color: ColorManger.white,fontsize: Fontsize.s17,),
        primary: ColorManger.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      )
    ),
    //text theme
    textTheme: TextTheme(
      headlineLarge: SemiBoldStyle(color: ColorManger.darkGrey,fontsize: Fontsize.s16),
      titleLarge:MediumStyle(color: ColorManger.lightGrey,fontsize: Fontsize.s14) ,
      titleMedium:MediumStyle(color: ColorManger.primary,fontsize: Fontsize.s16) ,
      titleSmall:RegularStyle(color: ColorManger.white,fontsize: Fontsize.s16) ,
      labelSmall:BoldStyle(color: ColorManger.primary,fontsize: Fontsize.s12) ,
      headlineMedium:RegularStyle(color: ColorManger.darkGrey,fontsize:Fontsize.s14),
      bodyLarge: RegularStyle(color: ColorManger.grey1),
      labelMedium:BoldStyle(color: ColorManger.grey2,fontsize: Fontsize.s12) ,

      bodySmall: RegularStyle(color: ColorManger.grey),
      displayLarge: SemiBoldStyle(color: ColorManger.darkGrey,fontsize: Fontsize.s16),
    ),
    //input decoration theme
    inputDecorationTheme:  InputDecorationTheme(
      //padding
      contentPadding:  const EdgeInsetsDirectional.all(AppPadding.p8),
      //hint style
      hintStyle: RegularStyle(color: ColorManger.grey,fontsize: Fontsize.s14),
      //label style
      labelStyle: MediumStyle(color: ColorManger.grey,fontsize: Fontsize.s14),
      errorStyle: RegularStyle(color: ColorManger.error),
      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.grey,
          width: AppSize.sBorder,
        ),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSize.sBorder,
        ),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      //error border
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManger.error,
            width: AppSize.sBorder,
          ),
          borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      // focus error
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManger.primary,
            width: AppSize.sBorder,
          ),
          borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
    ),
  );
}