import 'package:advanced_flutter/App/constance.dart';

extension NonNullString on String?{
  String orEmpty(){
    if(this==null){
      return Constance.empty;
    }
    else
      {
        return this!;
      }
  }
}
extension NonNullIntger on int?{
  int orZero(){
    if(this==null){
      return Constance.zero;
    }
    else
      {
        return this!;
      }
  }
}