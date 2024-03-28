import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call(String id);
}

class DeleteItemUseCase implements _UseCase {
  final CompanyRepository _repository;

  DeleteItemUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(String id) async {
    return await _repository.deleteItem(id);
  }
}