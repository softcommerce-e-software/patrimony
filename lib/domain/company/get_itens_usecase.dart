import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';

mixin _UseCase {
  Future<Either<Failure, List<ItemEntity>>> call(String companyId, String categoryId);
}

class GetItemsUseCase implements _UseCase {
  final CompanyRepository _repository;

  GetItemsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ItemEntity>>> call(String companyId, String categoryId) async {
    return await _repository.getItems(companyId, categoryId);
  }
}