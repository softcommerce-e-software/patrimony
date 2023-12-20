import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/search_item_usecase.dart';
import 'package:patrimony/domain/utils/app_state.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemsStore extends AppState<List<ItemEntity>> {
  final SearchItemUseCase _useCase;

  ItemsStore(this._useCase) : super([]);

  CompanyEntity _companyEntity = CompanyEntity();

  void setCompany(CompanyEntity entity) {
    _companyEntity = entity;
  }

  Future<void> searchItem(String patrimony) async {
    if (!state.any((element) => element.code == patrimony) && !isLoading) {
      executeEitherList(DartzEitherAdapter.adapter(
          _useCase.call(patrimony, _companyEntity.id!)));
    }
  }

  void goToItem(ItemEntity entity) {
    Modular.to
        .pushNamed('/bottom_view/home/item', arguments: entity, forRoot: true);
  }
}
