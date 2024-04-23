import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/item/item_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call(
      String id,
      String url,
  );
}

class DeletePhotoItemUseCase implements _UseCase {
  final ItemRepository _repository;

  DeletePhotoItemUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      String id,
      String url,
  ) async {
    return await _repository.deletePhoto(id, url);
  }
}