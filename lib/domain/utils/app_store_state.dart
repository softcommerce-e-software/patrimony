import 'package:flutter_triple/flutter_triple.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/uikit/components/base/app_store.dart';

abstract class AppStoreState<State> extends AppStore<State> {
  AppStoreState(super.initialState);

  Future<void> executeEither(
      Future<EitherAdapter<Failure, State>> func) async {
    setLoading(true);
    var response = await func;
    response.fold(
            (error) {
          setError(true);
          setLoading(false);
        },
            (value) {
          this.value = value;
          setLoading(false);
        }
    );
  }

  Future<void> executeEitherList<NewState>(
      Future<EitherAdapter<Failure, NewState?>> func) async {
    setLoading(true);
    var response = await func;
    response.fold(
            (error) {
              setError(true);
              setLoading(false);
        },
            (value) {
              if(value != null) {
                (this.value as List<NewState?>).add(value);
              }
              setLoading(false);
        }
    );
  }
}