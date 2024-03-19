import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/entity/user_entity.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<CompanyEntity>>> getCompanies();
  Future<Either<Failure, List<HistoryEntity>>> getHistory(String companyId);
  Future<Either<Failure, List<CommonValueEntity>>> getConservationStates();
  Future<Either<Failure, List<ItemEntity>>> getItems(String companyId, String categoryId);
  Future<Either<Failure, List<CommonValueEntity>>> getTypes(String id);
  Future<Either<Failure, List<UserEntity>>> getUsers(String id);
  Future<Either<Failure, ItemEntity>> searchItem(String code, String companyId);
  Future<Either<Failure, bool>> postItem(
      String companyId,
      String categoryId,
      String barcode,
      double value,
      String observations,
      List<File> attachments
  );
  Future<Either<Failure, bool>> postCategory(String companyId, String name);
}