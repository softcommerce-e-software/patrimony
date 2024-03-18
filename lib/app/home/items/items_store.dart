import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/get_itens_usecase.dart';
import 'package:patrimony/domain/utils/app_state.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemsStore extends AppState<List<ItemEntity>> {
  final GetItemsUseCase _useCase;

  ItemsStore(this._useCase) : super([]);

  Future<void> getItems(String companyId, String categoryId) async {
    executeEither(DartzEitherAdapter.adapter(
        _useCase.call(companyId, categoryId)));
  }

  void goToItem(ItemEntity entity) {
    Modular.to
        .pushNamed('/bottom_view/home/item', arguments: entity, forRoot: true);
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
      getItems(companyId, categoryId);
    }
  }
}
