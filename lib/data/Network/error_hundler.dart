// ignore_for_file: constant_identifier_names


import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource{
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  INTERNET_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  NOT_FOUND,
  DEFALUT


}
class ErrorHandler implements Exception{
     late Failure failure;

  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      _handlerError(error);
      failure=_handlerError(error);
    }
    else{
      failure = DataSource.DEFALUT.getFailure();
    }
  }
}
Failure _handlerError(DioError error){
  switch(error.type){

    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();

    case DioErrorType.response:
      if(error.response!=null && error.response?.statusCode!=null && error.response?.statusMessage!=null){
        return Failure(error.response!.statusMessage!, error.response!.statusCode!);
      }
      else{
        return DataSource.DEFALUT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();

    case DioErrorType.other:
      return DataSource.DEFALUT.getFailure();

  }
  }
  extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this){
      case DataSource.SUCCESS:
        return Failure(ResponseMessage.SUCCESS, ResponseCode.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseMessage.NO_CONTENT, ResponseCode.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseMessage.BAD_REQUEST, ResponseCode.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseMessage.FORBIDDEN, ResponseCode.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseMessage.UNAUTHORISED, ResponseCode.UNAUTHORISED);
      case DataSource.INTERNET_SERVER_ERROR:
        return Failure(ResponseMessage.INTERNET_SERVER_ERROR, ResponseCode.INTERNET_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseMessage.CONNECT_TIMEOUT, ResponseCode.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseMessage.CANCEL, ResponseCode.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(ResponseMessage.RECEIVE_TIMEOUT, ResponseCode.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseMessage.SEND_TIMEOUT, ResponseCode.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseMessage.CACHE_ERROR, ResponseCode.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseMessage.NO_INTERNET_CONNECTION, ResponseCode.NO_INTERNET_CONNECTION);
        case DataSource.NOT_FOUND:
        return Failure(ResponseMessage.NOT_FOUND, ResponseCode.NOT_FOUND);
      case DataSource.DEFALUT:
        return Failure(ResponseMessage.DEFALUT, ResponseCode.DEFAULT);
    }
  }
  }
class ResponseCode{
  static const int SUCCESS=200;//SUCCESS
  static const int NO_CONTENT=201;//SUCCESS WITHOUT DATA
  static const int BAD_REQUEST=400;//FAILURE API REJECTED
  static const int FORBIDDEN=403; //FAILURE API REJECTED
  static const int UNAUTHORISED=401; // USER IS NOT AUTHORISED
  static const int INTERNET_SERVER_ERROR =500; // CRASH IN SERVER
  static const int NOT_FOUND =404; // CRASH IN SERVER

  // LOCAL
  static const int SEND_TIMEOUT=-4; //
  static const int CONNECT_TIMEOUT=-1;
  static const int CANCEL=-2;
  static const int RECEIVE_TIMEOUT=-3;
  static const int CACHE_ERROR=-5;
  static const int NO_INTERNET_CONNECTION=-6;
  static const int DEFAULT=-7;
}
class ResponseMessage{
  static const String SUCCESS="Success";//SUCCESS
  static const String NO_CONTENT="N0 content";//SUCCESS WITHOUT DATA
  static const String BAD_REQUEST="bad request try again later";//FAILURE API REJECTED
  static const String FORBIDDEN="forbidden request try again later"; //FAILURE API REJECTED
  static const String UNAUTHORISED="user is unauthorised try again later"; // USER IS NOT AUTHORISED
  static const String INTERNET_SERVER_ERROR ="some thing went wrong try again later"; // CRASH IN SERVER
  // LOCAL
  static const String SEND_TIMEOUT="time out try again later"; //
  static const String NOT_FOUND="Page not found"; //
  static const String CONNECT_TIMEOUT="time out error try again later";
  static const String CANCEL="request was canceled try again later";
  static const String RECEIVE_TIMEOUT="time out try again later";
  static const String CACHE_ERROR="cache error try again later";
  static const String NO_INTERNET_CONNECTION="please check your internet connection";
  static const String DEFALUT="some thing went wrong try again later";
}
class ApiInternalStatues{
  static const int SUCCESS=0;
  static const int FAILURE=1;
}