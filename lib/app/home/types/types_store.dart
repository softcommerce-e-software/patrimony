import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/get_types_usecase.dart';
import 'package:patrimony/domain/company/get_users_usecase.dart';
import 'package:patrimony/domain/utils/app_state.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/user_entity.dart';

class TypesStore extends AppState<TypesPageEntity> {
  final GetTypesUseCase _getTypesUseCase;
  final GetUsersUseCase _getUsersUseCase;
  TypesStore(this._getTypesUseCase, this._getUsersUseCase) : super(TypesPageEntity());

  Future<void> getPage(String id) async {
    await _getTypes(id);
    _getUsers(id);
  }

  Future<void> _getTypes(String id) async {
    setLoading(true);
    var response = await _getTypesUseCase.call(id);
    response.fold(
        (l) => null,
        (r) => update(state..types = r)
    );
    setLoading(false);
  }

  Future<void> _getUsers(String id) async {
    setLoading(true);
    var response = await _getUsersUseCase.call(id);
    response.fold(
            (l) => null,
            (r) => update(state..users = r)
    );
    setLoading(false);
  }

  void goToOptions(CommonValueEntity entity) {}

  void goToItems(CompanyEntity companyEntity, CommonValueEntity commonValueEntity) {
    Modular.to.pushNamed(
        '/bottom_view/home/items',
        arguments: {
          'company': companyEntity,
          'category': commonValueEntity
        },
        forRoot: true
    );
  }

}

class TypesPageEntity {
  List<CommonValueEntity> types = [];
  List<UserEntity> users = [];
}