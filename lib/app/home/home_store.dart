import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/get_companies_usecase.dart';
import 'package:patrimony/domain/company/get_conservation_states_usecase.dart';
import 'package:patrimony/domain/company/get_types_usecase.dart';
import 'package:patrimony/domain/user/get_user_is_admin_usecase.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';
import 'package:patrimony/entity/company_entity.dart';
import '../../domain/utils/app_state.dart';

class HomeStore extends AppState<List<CompanyEntity>> {
  final GetCompaniesUseCase _useCase;
  final GetTypesUseCase _getTypesUseCase;
  final GetConservationStatesUseCase _getConservationStatesUseCase;
  final GetUserIsAdminUseCase _getUserIsAdminUseCase;
  HomeStore(this._useCase, this._getTypesUseCase, this._getConservationStatesUseCase, this._getUserIsAdminUseCase) : super([]);

  @override
  void initStore() async {
    super.initStore();
    await _init();
    getCompanies();
  }

  Future<void> _init() async {
    setLoading(true);
    var response = await _getUserIsAdminUseCase.call();
    response.fold((l) => null, (r) {
      if (r) {
        _getTypesUseCase.call();
        _getConservationStatesUseCase.call();
      }
    });
  }

  Future<void> getCompanies() async {
    executeEither(DartzEitherAdapter.adapter(_useCase.call()));
  }

  void goToOptions(CompanyEntity company) {}

  void goToCompany(CompanyEntity company) {
    Modular.to.pushNamed('/bottom_view/home/items', arguments: company, forRoot: true);
  }
}