import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';

import 'item_repository.dart';

mixin _UseCase {
  Future<Either<Failure, List<ItemEntity>>> call(String companyId, String categoryId, int page);
}

class GetItemsUseCase implements _UseCase {
  final ItemRepository _repository;

  GetItemsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ItemEntity>>> call(String companyId, String categoryId, int page) async {
    return await _repository.getItems(companyId, categoryId, page);
  }
}