import 'package:dartz/dartz.dart';
import 'package:patrimony/domain/company/company_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/history_entity.dart';

mixin _UseCase {
  Future<Either<Failure, List<HistoryEntity>>> call();
}

class GetHistoryUseCase implements _UseCase {
  final CompanyRepository _repository;

  GetHistoryUseCase(this._repository);

  @override
  Future<Either<Failure, List<HistoryEntity>>> call() async {
    return await _repository.getHistory();
  }
}