import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/app_module.dart';
import 'package:patrimony/app/bottom_view/bottom_view_page.dart';
import 'package:patrimony/app/history/history_module.dart';
import 'package:patrimony/app/home/home_module.dart';
import 'package:patrimony/data/company/company_datasource.dart';
import 'package:patrimony/data/company/company_repository_impl.dart';
import 'package:patrimony/data_remote/company/company_datasource_impl.dart';
import 'package:patrimony/domain/company/company_repository.dart';

class BottomViewModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const BottomViewPage(),
      guards: [AuthGuard()],
      children: [
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/history', module: HistoryModule()),
      ],
      transition: TransitionType.fadeIn,
    );
  }

  @override
  List<Module> imports = [AppModule()];

  @override
  void exportedBinds(Injector i) {
    i.addInstance(FirebaseStorage.instance);
    i.addInstance(FirebaseFunctions.instance);
    i.addLazySingleton<CompanyRepository>(CompanyRepositoryImpl.new);
    i.addLazySingleton<CompanyDataSource>(CompanyDataSourceImpl.new);
  }
}