import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/item/item_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call(
      String itemId,
      String name,
      String barcode,
      double value,
      String observations,
      String status,
      String workingStatus
  );
}

class UpdateItemUseCase implements _UseCase {
  final ItemRepository _repository;

  UpdateItemUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      String itemId,
      String name,
      String barcode,
      double value,
      String observations,
      String status,
      String workingStatus
  ) async {
    return await _repository.updateItem(
        itemId, name, barcode, value, observations, status, workingStatus
    );
}
}