import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';

abstract class CompanyDataSource {
  Future<List<CompanyEntity>> getCompanies();
  Future<List<HistoryEntity>> getHistory();
  Future<List<CommonValueEntity>> getConservationStates();
  Future<List<ItemEntity>> getItems(String id);
  Future<List<CommonValueEntity>> getTypes();
  Future<ItemEntity?> searchItem(String code, String companyId);
}