import 'package:patrimony/domain/company/get_types_usecase.dart';
import 'package:patrimony/domain/utils/app_state.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';
import 'package:patrimony/entity/common_value_entity.dart';

class TypesStore extends AppState<List<CommonValueEntity>> {
  final GetTypesUseCase _useCase;
  TypesStore(this._useCase) : super([]);

  Future<void> getTypes() async {
    executeEither(DartzEitherAdapter.adapter(_useCase.call()));
  }

  void goToOptions(CommonValueEntity entity) {}

  void goToItem(CommonValueEntity entity) {
    // Modular.to.pushNamed('/bottom_view/home/items', arguments: entity, forRoot: true);
  }

}