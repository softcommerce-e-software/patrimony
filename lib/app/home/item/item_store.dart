import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/delete_item_usecase.dart';
import 'package:patrimony/domain/utils/app_state.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemStore extends AppState<ItemEntity> {
  final DeleteItemUseCase _useCase;

  ItemStore(this._useCase) : super(ItemEntity());

  Future<void> getItem(ItemEntity entity) async {
    setLoading(true);
    setLoading(false);
    update(entity, force: true);
  }

  Future<void> refresh() async {
    getItem(state);
  }

  Future<void> delete(String? id) async {
    if(id != null && id.isNotEmpty) {
      setLoading(true);
      var response = await _useCase.call(id);
      response.fold(
              (l) => {},
              (r) => Modular.to.pop(r)
      );
      setLoading(false);
    }
  }
}
