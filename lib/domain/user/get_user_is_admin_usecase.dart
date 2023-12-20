import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/user/user_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call();
}

class GetUserIsAdminUseCase implements _UseCase {
  final UserRepository _repository;

  GetUserIsAdminUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await _repository.isAdmin();
  }
}