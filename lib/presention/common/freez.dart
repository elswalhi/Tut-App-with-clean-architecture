// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freez.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String userName,
      String countryMobileCode,
      String mobile,
      String email,
      String password,
      String profilePicture) = _RegisterObject;
}
