import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call(String companyId, String name,);
}

class PostCategoryUseCase implements _UseCase {
  final CompanyRepository _repository;

  PostCategoryUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(String companyId, String name,) async {
    return await _repository.postCategory(companyId, name);
}
}