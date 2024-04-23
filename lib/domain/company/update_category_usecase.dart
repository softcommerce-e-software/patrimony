import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call(String id, String name,);
}

class UpdateCategoryUseCase implements _UseCase {
  final CompanyRepository _repository;

  UpdateCategoryUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(String id, String name,) async {
    return await _repository.updateCategory(id, name);
  }
}