import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/app_module.dart';
import 'package:patrimony/app/login/login_page.dart';
import 'package:patrimony/app/login/login_store.dart';
import 'package:patrimony/domain/user/login_usecase.dart';

class LoginModule extends Module {

  @override
  void binds(Injector i) {
    i.add(LoginStore.new);
    i.add(LoginUseCase.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const LoginPage());
  }

  @override
  List<Module> imports = [AppModule()];
}