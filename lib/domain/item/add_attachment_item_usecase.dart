import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/item/item_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, String>> call(
      String companyId,
      String categoryId,
      String itemId,
      File photo,
  );
}

class AddAttachmentItemUseCase implements _UseCase {
  final ItemRepository _repository;

  AddAttachmentItemUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(
      String companyId,
      String categoryId,
      String itemId,
      File photo,
  ) async {
    return await _repository.addAttachment(
        companyId, categoryId, itemId, photo
    );
}
}