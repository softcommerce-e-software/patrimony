import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';

import 'item_repository.dart';

mixin _UseCase {
  Future<Either<Failure, ItemEntity?>> call(String code, String companyId);
}

class SearchItemUseCase implements _UseCase {
  final ItemRepository _repository;

  SearchItemUseCase(this._repository);

  @override
  Future<Either<Failure, ItemEntity?>> call(String code, String companyId) async {
    return await _repository.searchItem(code, companyId);
  }
}