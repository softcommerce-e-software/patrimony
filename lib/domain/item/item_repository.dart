import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<ItemEntity>>> getItems(String companyId, String categoryId, int page);
  Future<Either<Failure, ItemEntity>> searchItem(String code, String companyId);
  Future<Either<Failure, bool>> postItem(
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
  Future<Either<Failure, bool>> deleteItem(String id);
  Future<Either<Failure, bool>> updateItem(
      String itemId,
      String name,
      String barcode,
      double value,
      String observations,
      String status,
      String workingStatus
  );
  Future<Either<Failure, String>> addAttachment(
      String companyId,
      String categoryId,
      String itemId,
      File photo
  );
  Future<Either<Failure, String>> addPhoto(
      String companyId,
      String categoryId,
      String itemId,
      File photo
  );
  Future<Either<Failure, bool>> deleteAttachment(
      String id,
      String url
  );
  Future<Either<Failure, bool>> deletePhoto(
      String id,
      String url
  );
}