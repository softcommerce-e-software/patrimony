import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:patrimony/data/company/company_datasource.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDataSource _dataSource;
  final HiveInterface _hiveInterface;

  CompanyRepositoryImpl(this._dataSource, this._hiveInterface);

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
    try {
      var response = await _dataSource.getCompanies();
      var box = _hiveInterface.box<CompanyEntity>(companyBox);
      await box.clear();
      box.addAll(response);
      return Right(response);
    } catch (e) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommonValueEntity>>> getConservationStates() async {
    try {
      var response = await _dataSource.getConservationStates();
      var box = _hiveInterface.box<CommonValueEntity>(conservationStateBox);
      await box.clear();
      box.addAll(response);
      return Right(response);
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<HistoryEntity>>> getHistory() async {
    try {
      return Right(await _dataSource.getHistory());
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getItems(String id) async {
    try {
      return Right(await _dataSource.getItems(id));
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommonValueEntity>>> getTypes() async {
    try {
      var response = await _dataSource.getTypes();
      var box = _hiveInterface.box<CommonValueEntity>(typeBox);
      await box.clear();
      box.addAll(response);
      return Right(response);
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, ItemEntity?>> searchItem(String code, String companyId) async {
    try {
      return Right(await _dataSource.searchItem(code, companyId));
    } catch (_) {
    return Left(RemoteFailure());
    }
  }
}