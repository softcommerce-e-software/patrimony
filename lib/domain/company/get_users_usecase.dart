import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/user_entity.dart';

mixin _UseCase {
  Future<Either<Failure, List<UserEntity>>> call(String id);
}

class GetUsersUseCase implements _UseCase {
  final CompanyRepository _repository;

  GetUsersUseCase(this._repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(String id) async {
    return await _repository.getUsers(id);
  }
}