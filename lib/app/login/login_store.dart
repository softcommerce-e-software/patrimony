import 'package:patrimony/data_remote/user/user_datasource_impl.dart';
import 'package:patrimony/domain/user/is_logged_usecase.dart';
import 'package:patrimony/domain/user/login_usecase.dart';
import 'package:patrimony/domain/utils/dartz_either_adapter.dart';

import '../../domain/utils/app_state.dart';

class LoginStore extends AppState<bool> {
  final LoginUseCase _loginUseCase;
  final IsLoggedUseCase _isLoggedUseCase;
  LoginStore(this._loginUseCase, this._isLoggedUseCase) : super(false);

  void login({bool isGoogle = false}) {
    executeEither(DartzEitherAdapter.adapter(
        _loginUseCase.call(isGoogle ? GOOGLE : APPLE)));
  }

  void isLogged() {
    executeEither(DartzEitherAdapter.adapter(_isLoggedUseCase.call(), showError: false));
  }
}