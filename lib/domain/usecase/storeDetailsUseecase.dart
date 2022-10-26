

import 'package:advanced_flutter/data/Network/failure.dart';
import 'package:advanced_flutter/data/Repository/repositry.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
