// ignore_for_file: constant_identifier_names

import 'package:advanced_flutter/App/constance.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/data/Network/dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
const String APPLICATION_JSON="application/json";
const String CONTENT_TYPE="content-type";
const String ACCEPT="accept";
const String AUTHORIZATION="authorization";
const String DEFAULT_LANGUAGE="language";
class DioFactory{
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async{
    Dio dio= Dio();
    String language = await _appPreferences.getAppLanguage();
    Map<String,String> headers={
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION:Constance.token,
      DEFAULT_LANGUAGE:language //todo get lang from app pref
    };
    dio.options= BaseOptions(
      baseUrl: Constance.baseUrl,
      headers: headers,
      receiveTimeout: Constance.apiTimeout,
      sendTimeout: Constance.apiTimeout,
    );
    if(!kReleaseMode){ // its debug mode so print logs
      dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}