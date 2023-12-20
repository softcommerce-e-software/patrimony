import 'package:patrimony/domain/company/get_history_usecase.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';
import 'package:patrimony/entity/history_entity.dart';

import '../../domain/utils/app_state.dart';

class HistoryStore extends AppState<List<HistoryEntity>> {
  final GetHistoryUseCase _useCase;
  HistoryStore(this._useCase) : super([]);

  @override
  void initStore() {
    super.initStore();
    executeEither(DartzEitherAdapter.adapter(_useCase.call()));
  }
}