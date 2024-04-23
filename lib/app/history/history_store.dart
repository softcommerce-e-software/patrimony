import 'package:patrimony/domain/company/get_history_usecase.dart';
import 'package:patrimony/entity/history_entity.dart';

import '../../domain/utils/app_store_state.dart';

class HistoryStore extends AppStoreState<List<HistoryEntity>> {
  final GetHistoryUseCase _useCase;
  HistoryStore(this._useCase) : super([]);

  var page = 1;
  var stop = false;

  void getHistory(String companyId) async {
    if (!isLoading && !stop) {

      setLoading(true);
      var response = await _useCase.call(companyId, page);
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
  }
}