import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:advanced_flutter/data/Repository/repositry.dart';
import 'package:advanced_flutter/data/requests/requests.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
   return await _repository.Login(LoginRequest(input.email, input.password));
  }
}
class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}