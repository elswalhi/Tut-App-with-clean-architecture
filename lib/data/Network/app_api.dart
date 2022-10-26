// ignore_for_file: non_constant_identifier_names

import 'package:advanced_flutter/App/constance.dart';
import 'package:advanced_flutter/data/Response/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'app_api.g.dart';
@RestApi(baseUrl: Constance.baseUrl)

abstract class AppServiceClient{
  factory AppServiceClient(Dio dio,{String baseUrl})= _AppServiceClient;
  @POST("/customer/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      );

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      @Field("user_name") String userName,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobile,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_picture") String profilePicture,
      );

  @GET("/home")
  Future<HomeResponse> getHomeData();
  @GET("/storeDetails")
  Future<StoreDetailsResponse> getStoreDetail();
}
