import 'package:advanced_flutter/data/Data_source/remote.dart';
import 'package:advanced_flutter/data/Network/app_api.dart';
import 'package:advanced_flutter/data/Response/responses.dart';
import 'package:advanced_flutter/data/requests/requests.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> Login(LoginRequest loginRequest);
  Future<AuthenticationResponse> Register(RegisterRequest registerRequest);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetail();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> Login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<AuthenticationResponse> Register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobile,
        registerRequest.email,
        registerRequest.password,
        "");
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }
  @override
  Future<StoreDetailsResponse> getStoreDetail() async {
    return await _appServiceClient.getStoreDetail();
  }
}
