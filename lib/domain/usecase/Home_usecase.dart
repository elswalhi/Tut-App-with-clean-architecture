import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:advanced_flutter/data/Repository/repositry.dart';
import 'package:advanced_flutter/data/requests/requests.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{
  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
   return await _repository.getHomeData();
  }
}
