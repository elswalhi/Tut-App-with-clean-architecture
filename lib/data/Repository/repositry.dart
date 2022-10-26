// ignore_for_file: non_constant_identifier_names

import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:advanced_flutter/data/requests/requests.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:dartz/dartz.dart';
abstract class Repository{
  Future<Either<Failure,Authentication>> Login(LoginRequest loginRequest);
  Future<Either<Failure,Authentication>> Register(RegisterRequest registerRequest);
  Future<Either<Failure,HomeObject>> getHomeData();
  Future<Either<Failure,StoreDetails>> getStoreDetails();
}