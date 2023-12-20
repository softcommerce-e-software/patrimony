import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/user/user_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _IsLogged {
  Future<Either<Failure, bool>> call();
}

class IsLoggedUseCase implements _IsLogged {
  final UserRepository _repository;

  IsLoggedUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await _repository.isLoggedUser();
  }
}