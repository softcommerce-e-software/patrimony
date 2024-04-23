import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/user_entity.dart';

abstract class CompanyDataSource {
  Future<List<CompanyEntity>> getCompanies();
  Future<List<HistoryEntity>> getHistory(String companyId, int page);
  Future<List<CommonValueEntity>> getConservationStates();
  Future<List<CommonValueEntity>> getTypes(String id);
  Future<List<UserEntity>> getUsers(String id);
  Future<bool> postCategory(String companyId, String name);
  Future<bool> updateCategory(String id, String name);
}