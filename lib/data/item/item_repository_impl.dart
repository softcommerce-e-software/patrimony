import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:patrimony/data/item/item_datasource.dart';
import 'package:patrimony/domain/item/item_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource _dataSource;

  ItemRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ItemEntity>>> getItems(String companyId, String categoryId, int page) async {
    try {
      return Right(await _dataSource.getItems(companyId, categoryId, page));
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, ItemEntity>> searchItem(
      String code, String companyId) async {
    try {
      return Right(await _dataSource.searchItem(code, companyId));
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postItem(
      String companyId,
      String categoryId,
      String name,
      String barcode,
      double value,
      String observations,
      List<File> attachments,
      String imagePath
  ) async {
    try {
      return Right(
          await _dataSource.postItem(
            companyId, categoryId, name, barcode, value, observations,
            attachments, imagePath
          )
      );
    } catch (_) {
    return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteItem(String id) async {
    try {
      return Right(await _dataSource.deleteItem(id));
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateItem(
      String itemId,
      String name,
      String barcode,
      double value,
      String observations,
      String status,
  ) async {
    try {
      return Right(
          await _dataSource.updateItem(
              itemId, name, barcode, value, observations, status
          )
      );
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addAttachment(String companyId, String categoryId, String itemId, File photo) async {
    try {
      return Right(
          await _dataSource.addAttachment(
              companyId, categoryId, itemId, photo
      )
    );
    } catch (_) {
    return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addPhoto(String companyId, String categoryId, String itemId, File photo) async {
    try {
      return Right(
          await _dataSource.addPhoto(
              companyId, categoryId, itemId, photo
      )
    );
    } catch (_) {
    return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAttachment(String id, String url) async {
    try {
      return Right(await _dataSource.deleteAttachment(id, url));
    } catch (_) {
    return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deletePhoto(String id, String url) async {
    try {
      return Right(await _dataSource.deletePhoto(id, url));
    } catch (_) {
    return Left(RemoteFailure());
    }
  }
}
