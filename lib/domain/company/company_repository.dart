import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<CompanyEntity>>> getCompanies();
  Future<Either<Failure, List<HistoryEntity>>> getHistory();
  Future<Either<Failure, List<CommonValueEntity>>> getConservationStates();
  Future<Either<Failure, List<ItemEntity>>> getItems(String id);
  Future<Either<Failure, List<CommonValueEntity>>> getTypes();
  Future<Either<Failure, ItemEntity?>> searchItem(String code, String companyId);
}