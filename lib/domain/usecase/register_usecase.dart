import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:advanced_flutter/data/Repository/repositry.dart';
import 'package:advanced_flutter/data/requests/requests.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.Register(RegisterRequest(
        input.email,
        input.password,
        input.userName,
        input.countryMobileCode,
        input.mobile,
        input.profilePicture));
  }
 }

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobile;
  String email;
  String password;
  String profilePicture;
  RegisterUseCaseInput(this.email, this.password, this.userName,
      this.countryMobileCode, this.mobile, this.profilePicture);
}
