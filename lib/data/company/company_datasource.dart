import 'dart:io';

import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/entity/user_entity.dart';

abstract class CompanyDataSource {
  Future<List<CompanyEntity>> getCompanies();
  Future<List<HistoryEntity>> getHistory();
  Future<List<CommonValueEntity>> getConservationStates();
  Future<List<ItemEntity>> getItems(String companyId, String categoryId);
  Future<List<CommonValueEntity>> getTypes(String id);
  Future<List<UserEntity>> getUsers(String id);
  Future<ItemEntity> searchItem(String code, String companyId);
  Future<bool> postItem(
      String companyId,
      String categoryId,
      String barcode,
      double value,
      String observations,
      List<File> attachments
  );
}