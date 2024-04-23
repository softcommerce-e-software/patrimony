import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:patrimony/domain/company/get_types_usecase.dart';
import 'package:patrimony/domain/company/get_users_usecase.dart';
import 'package:patrimony/domain/company/post_category_usecase.dart';
import 'package:patrimony/domain/utils/app_store_state.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/user_entity.dart';
import 'package:patrimony/uikit/components/base/app_store.dart';
import 'package:patrimony/uikit/components/modal/custom_modal_form.dart';

class TypesStore extends AppStore<TypesPageEntity> {
  final GetTypesUseCase _getTypesUseCase;
  final GetUsersUseCase _getUsersUseCase;
  final PostCategoryUseCase _postCategoryUseCase;

  TypesStore(
      this._getTypesUseCase, this._getUsersUseCase, this._postCategoryUseCase
  ) : super(TypesPageEntity());

  String id = '';

  Future<void> getPage(String id) async {
    this.id = id;
    await _getTypes(id);
    _getUsers(id);
  }

  Future<void> _getTypes(String id) async {
    setLoading(true);

    var response = await _getTypesUseCase.call(id);
    response.fold(
        (l) => AsukaSnackbar.alert(l.message ?? '').show(),
        (r) => value..types = r
    );

    setLoading(false);
  }

  Future<void> _getUsers(String id) async {
    setLoading(true);

    var response = await _getUsersUseCase.call(id);
    response.fold(
            (l) => AsukaSnackbar.alert(l.message ?? '').show(),
            (r) => value..users = r
    );

    setLoading(false);
  }

  void goToOptions(CommonValueEntity entity) {}

  void goToHistory(CompanyEntity companyEntity) {
    Modular.to.pushNamed(
        '/bottom_view/home/history',
        arguments: companyEntity.id,
        forRoot: true
    );
  }

  void goToItems(CompanyEntity companyEntity, CommonValueEntity commonValueEntity) async {
    var response = await Modular.to.pushNamed(
        '/bottom_view/home/items',
        arguments: {
          'company': companyEntity,
          'category': commonValueEntity
        },
        forRoot: true
    );
    if (response == true) {
      _getTypes(id);
    }
  }

  void createCategory(String companyId) {
    showCustomModal(title: 'Nome da categoria', callback: (result) async {
      setLoading(true);

      var response = await _postCategoryUseCase.call(companyId, result);
      response.fold(
              (l) => AsukaSnackbar.alert(l.message ?? '').show(),
              (r) => _getTypes(companyId)
      );
    });
  }

  void addUser(String companyId) {
    showCustomModal(title: 'Nome da categoria', callback: (result) async {
      setLoading(true);

      var response = await _postCategoryUseCase.call(companyId, result);
      response.fold(
              (l) => AsukaSnackbar.alert(l.message ?? '').show(),
              (r) => _getTypes(companyId)
      );
    });
  }

}

class TypesPageEntity {
  List<CommonValueEntity> types = [];
  List<UserEntity> users = [];
}