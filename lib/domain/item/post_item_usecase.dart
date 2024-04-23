import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/utils/errors.dart';

import 'item_repository.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call(
      String companyId,
      String categoryId,
      String name,
      String barcode,
      double value,
      String observations,
      List<File> attachments,
      String imagePath,
      String workingStatus
  );
}

class PostItemUseCase implements _UseCase {
  final ItemRepository _repository;

  PostItemUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      String companyId,
      String categoryId,
      String name,
      String barcode,
      double value,
      String observations,
      List<File> attachments,
      String imagePath,
      String workingStatus
  ) async {
    return await _repository.postItem(
        companyId, categoryId, name, barcode, value, observations,
        attachments, imagePath, workingStatus
    );
}
}