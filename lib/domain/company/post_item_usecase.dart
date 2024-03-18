import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

mixin _UseCase {
  Future<Either<Failure, bool>> call(
      String companyId,
      String categoryId,
      String barcode,
      double value,
      String observations,
      List<File> attachments
  );
}

class PostItemUseCase implements _UseCase {
  final CompanyRepository _repository;

  PostItemUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      String companyId,
      String categoryId,
      String barcode,
      double value,
      String observations,
      List<File> attachments
  ) async {
    return await _repository.postItem(
        companyId, categoryId, barcode, value, observations,
        attachments
    );
}
}