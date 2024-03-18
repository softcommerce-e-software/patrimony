import 'package:dartz/dartz.dart';
import 'package:patrimony/data/user/user_datasource.dart';
import 'package:patrimony/domain/user/user_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

const userAdminBox = 'userAdminBox';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, bool>> login(String provider) async {
    try {
      return Right(await _dataSource.login(provider));
    } catch (_) {
      return Left(LoginError());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      return Right(await _dataSource.logout());
    } catch (_) {
      return Left(StandardError());
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedUser() async {
    try {
      return Right(await _dataSource.isLoggedUser());
    } catch (_) {
      return Left(InvalidUser());
    }
  }
}
