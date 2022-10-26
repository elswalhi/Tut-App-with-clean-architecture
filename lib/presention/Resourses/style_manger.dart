import 'package:advanced_flutter/presention/Resourses/fontManger.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontsize , FontWeight fontWeight , Color color){
  return TextStyle(
    fontSize: fontsize,
    fontFamily: FontConstant.fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}
// regular
TextStyle RegularStyle({
  double fontsize=Fontsize.s12  , required Color color ,
}){
  return _getTextStyle(fontsize, FontWeightManger.regular, color);
}// medium
TextStyle MediumStyle({
  double fontsize=Fontsize.s12  , required Color color ,
}){
  return _getTextStyle(fontsize, FontWeightManger.medium, color);
}
// light
TextStyle LightStyle({
  double fontsize=Fontsize.s12  , required Color color ,
}){
  return _getTextStyle(fontsize, FontWeightManger.light, color);
}// bold
TextStyle BoldStyle({
  double fontsize=Fontsize.s12  , required Color color ,
}){
  return _getTextStyle(fontsize, FontWeightManger.bold, color);
}
// semibold
TextStyle SemiBoldStyle({
  double fontsize=Fontsize.s12  , required Color color ,
}){
  return _getTextStyle(fontsize, FontWeightManger.semiBold, color);
}