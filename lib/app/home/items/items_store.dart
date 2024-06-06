import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/update_category_usecase.dart';
import 'package:patrimony/domain/item/get_itens_usecase.dart';
import 'package:patrimony/domain/utils/app_store_state.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/uikit/components/modal/custom_modal_form.dart';

class ItemsStore extends AppStoreState<List<ItemEntity>> {
  final GetItemsUseCase _getItemsUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  ItemsStore(this._getItemsUseCase, this._updateCategoryUseCase) : super([]);

  var page = 1;
  var stop = false;

  Future<void> getItems(String companyId, String categoryId, bool isReset) async {
    if (isReset) {
      value = [];
      page = 1;
      stop = false;
    }
    if (!isLoading && !stop) {
      setLoading(true);
      var response = await _getItemsUseCase.call(companyId, categoryId, page);
      response.fold(
              (l) => setError(true),
              (r) {
                if (r.length < 20) {
                  stop = true;
                }
                value.addAll(r);
                page += 1;
              }
      );
      setLoading(false);
    }
    return;
  }

  void goToItem(ItemEntity entity) async {
    var response = await Modular.to
        .pushNamed('/bottom_view/home/item', arguments: entity, forRoot: true);
    if (response == true) {
      getItems(entity.companyId ?? '', entity.categoryId ?? '', true);
    }
  }

  void goToAddItem(String companyId, String categoryId) async {
    var response = await Modular.to.pushNamed(
        '/bottom_view/home/add_item',
        arguments: {
          'companyId': companyId,
          'categoryId': categoryId
        },
        forRoot: true
    );
    if (response == true) {
      getItems(companyId, categoryId, true);
    }
  }

  void editCategory(CommonValueEntity category) {
    showCustomModal(
        title: 'Nome da categoria',
        label: category.name,
        callback: (result) async {
      setLoading(true);
      var response = await _updateCategoryUseCase.call(
          category.id ?? '', result
      );
      response.fold(
              (l) => null,
              (r) => Modular.to.pop(r)
      );
      setLoading(false);
    });
  }

  void goToReport(CompanyEntity companyEntity, CommonValueEntity categoryEntity) async {
    Modular.to
        .pushNamed(
        '/bottom_view/home/items/report',
        arguments: {
          'company': companyEntity,
          'category': categoryEntity,
          'items': value
        },
        forRoot: true
    );
  }
}
