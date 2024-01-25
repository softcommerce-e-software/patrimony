import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/bottom_view/bottom_view_module.dart';
import 'package:patrimony/app/login/login_module.dart';
import 'package:patrimony/data/user/user_datasource.dart';
import 'package:patrimony/data/user/user_repository_impl.dart';
import 'package:patrimony/data_remote/user/user_datasource_impl.dart';
import 'package:patrimony/domain/user/is_logged_usecase.dart';
import 'package:patrimony/domain/user/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void exportedBinds(Injector i) {
    i.addInstance(Supabase.instance.client);
    i.addInstance(Supabase.instance.client.auth);
    i.addInstance(FirebaseRemoteConfig.instance);
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new);
    i.addLazySingleton<UserDataSource>(UserDataSourceImpl.new);
    i.addLazySingleton(IsLoggedUseCase.new);
  }

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: LoginModule());
    r.module('/bottom_view', module: BottomViewModule(), guards: [AuthGuard()]);
  }
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    var response = await Modular.get<IsLoggedUseCase>().call();
    return response.getOrElse(() => false);
  }
}
