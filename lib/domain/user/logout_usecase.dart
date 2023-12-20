import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/user/user_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _Logout {
  Future<Either<Failure, bool>> call();
}

class LogoutUseCase implements _Logout {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await _repository.logout();
  }
}