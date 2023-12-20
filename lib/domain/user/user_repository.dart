import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/utils/errors.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> login(String provider);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> isLoggedUser();
  Future<Either<Failure, bool>> isAdmin();
}