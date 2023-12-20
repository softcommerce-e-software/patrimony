import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/user/user_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _Login {
  Future<Either<Failure, bool>> call(String provider);
}

class LoginUseCase implements _Login {
  final UserRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(String? provider) async {
    if (provider?.isEmpty ?? true) {
      return Left(StandardError());
    }
    return await _repository.login(provider!);
  }
}