import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/get_companies_usecase.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';
import 'package:patrimony/entity/company_entity.dart';

import '../../domain/utils/app_state.dart';

class HomeStore extends AppState<List<CompanyEntity>> {
  final GetCompaniesUseCase _useCase;
  HomeStore(this._useCase) : super([]);

  @override
  void initStore() async {
    super.initStore();
    getCompanies();
  }

  Future<void> getCompanies() async {
    executeEither(DartzEitherAdapter.adapter(_useCase.call()));
  }

  void goToOptions(CompanyEntity company) {}

  void goToCategories(CompanyEntity company) {
    Modular.to.pushNamed(
        '/bottom_view/home/categories',
        arguments: company,
        forRoot: true
    );
  }
}