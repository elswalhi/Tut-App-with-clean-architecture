import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}