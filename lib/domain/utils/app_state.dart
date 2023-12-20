import 'package:flutter_triple/flutter_triple.dart';
import 'package:patrimony/domain/utils/errors.dart';

abstract class AppState<State> extends Store<State> {
  AppState(State initialState) : super(initialState);

  Future<void> executeEither(
      Future<EitherAdapter<Failure, State>> func) async {
    setLoading(true);
    var response = await func;
    response.fold(
            (error) {
          setError(error, force: true);
          setLoading(false, force: true);
        },
            (value) {
          update(value, force: true);
          setLoading(false, force: true);
        }
    );
  }

  Future<void> executeEitherList<NewState>(
      Future<EitherAdapter<Failure, NewState?>> func) async {
    setLoading(true);
    var response = await func;
    response.fold(
            (error) {
          setError(error, force: true);
          setLoading(false, force: true);
        },
            (value) {
              if(value != null) {
                (state as List<NewState?>).add(value);
              }
          // update(value, force: true);
          setLoading(false, force: true);
        }
    );
  }
}