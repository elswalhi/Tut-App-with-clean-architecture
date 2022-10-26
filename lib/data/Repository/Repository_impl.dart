import 'package:advanced_flutter/data/Data_source/local_data_source.dart';
import 'package:advanced_flutter/data/Data_source/remote.dart';
import 'package:advanced_flutter/data/Mapper/mapper.dart';
import 'package:advanced_flutter/data/Network/error_hundler.dart';
import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:advanced_flutter/data/Network/newwork_info.dart';
import 'package:advanced_flutter/data/Repository/repositry.dart';
import 'package:advanced_flutter/data/Response/responses.dart';
import 'package:advanced_flutter/data/requests/requests.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._networkInfo,this._remoteDataSource,this._localDataSource);
  @override
   // ignore: non_constant_identifier_names
   Future<Either<Failure, Authentication>> Login(LoginRequest loginRequest)async {
    if(await _networkInfo.isConnected){
      try{
        final response =await  _remoteDataSource.Login(loginRequest);
        // its connected
        if(response.status==ApiInternalStatues.SUCCESS){
          //success
          return Right(response.toDomain());
          //return data
        }
        else{
          // fail -- business error
          return Left(Failure(ResponseMessage.DEFALUT , ApiInternalStatues.FAILURE));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }
    else{
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> Register(RegisterRequest registerRequest)async {
    if(await _networkInfo.isConnected){
      try{
        final response =await  _remoteDataSource.Register(registerRequest);
        // its connected
        if(response.status==ApiInternalStatues.SUCCESS){
          //success
          return Right(response.toDomain());
          //return data
        }
        else{
          // fail -- business error
          return Left(Failure(ResponseMessage.DEFALUT , ApiInternalStatues.FAILURE));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }
    else{
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{
    try{
      final response =await  _localDataSource.getHomeData();
      return Right(response.toDomain());
} catch(cachError){
  if(await _networkInfo.isConnected){
    try{
      final response =await  _remoteDataSource.getHomeData();
      // its connected
      if(response.status==ApiInternalStatues.SUCCESS){
        //save response in cache
        _localDataSource.saveHomeToCache(response);
        //success
        return Right(response.toDomain());
        //return data
      }
      else{
        // fail -- business error
        return Left(Failure(ResponseMessage.DEFALUT , ApiInternalStatues.FAILURE));
      }
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }

  }
  else{
    return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}
  }



  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    try {
      // get data from cache

      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getStoreDetail();
          if (response.status == ApiInternalStatues.SUCCESS) {
            _localDataSource.saveStoreDetailsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(response.message ?? ResponseMessage.DEFALUT,response.status ?? ResponseCode.DEFAULT,));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}