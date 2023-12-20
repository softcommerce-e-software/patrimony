import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/company_entity.dart';

mixin _UseCase {
  Future<Either<Failure, List<CompanyEntity>>> call();
}

class GetCompaniesUseCase implements _UseCase {
  final CompanyRepository _repository;

  GetCompaniesUseCase(this._repository);

  @override
  Future<Either<Failure, List<CompanyEntity>>> call() async {
    return await _repository.getCompanies();
  }
}