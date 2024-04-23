import 'package:dartz/dartz.dart';
import 'package:patrimony/data/company/company_datasource.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/user_entity.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDataSource _dataSource;

  CompanyRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
    try {
      var response = await _dataSource.getCompanies();
      return Right(response);
    } catch (e) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommonValueEntity>>>
      getConservationStates() async {
    try {
      var response = await _dataSource.getConservationStates();
      return Right(response);
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<HistoryEntity>>> getHistory(String companyId, int page) async {
    try {
      return Right(await _dataSource.getHistory(companyId, page));
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommonValueEntity>>> getTypes(String id) async {
    try {
      var response = await _dataSource.getTypes(id);
      return Right(response);
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers(String id) async {
    try {
      var response = await _dataSource.getUsers(id);
      return Right(response);
    } catch (_) {
      return Left(RemoteFailure());
    }
  }


  @override
  Future<Either<Failure, bool>> postCategory(String companyId, String name) async {
    try {
      return Right(await _dataSource.postCategory(companyId, name));
    } catch (_) {
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateCategory(String id, String name) async {
    try {
      return Right(await _dataSource.updateCategory(id, name));
    } catch (_) {
      return Left(RemoteFailure());
    }
  }
}
