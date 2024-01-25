import 'package:patrimony/domain/utils/app_state.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemStore extends AppState<ItemEntity> {
  ItemStore() : super(ItemEntity());

  Future<void> getItem(ItemEntity entity) async {
    setLoading(true);
    setLoading(false);
    update(entity, force: true);
  }

  Future<void> refresh() async {
    getItem(state);
  }
}
