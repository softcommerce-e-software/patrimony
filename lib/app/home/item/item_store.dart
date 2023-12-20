import 'package:hive_flutter/hive_flutter.dart';
import 'package:patrimony/data/user/user_repository_impl.dart';
import 'package:patrimony/domain/utils/app_state.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemStore extends AppState<ItemEntity> {
  final HiveInterface _hiveInterface;

  ItemStore(this._hiveInterface) : super(ItemEntity());

  Future<void> getItem(ItemEntity entity) async {
    setLoading(true);
    setLoading(false);
    update(entity, force: true);
  }

  List<CompanyEntity> getCompanies() {
    return _hiveInterface.box<CompanyEntity>(companyBox).values.toList();
  }

  List<CommonValueEntity> getConservationStates() {
    return _hiveInterface
        .box<CommonValueEntity>(conservationStateBox)
        .values
        .toList();
  }

  List<CommonValueEntity> getTypes() {
    return _hiveInterface.box<CommonValueEntity>(typeBox).values.toList();
  }

  bool isAdmin() {
    return _hiveInterface.box<bool>(userAdminBox).values.first;
  }

  Future<void> refresh() async {
    getItem(state);
  }
}
