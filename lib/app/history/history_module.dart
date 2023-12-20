import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/app_module.dart';
import 'package:patrimony/app/bottom_view/bottom_view_module.dart';
import 'package:patrimony/app/history/history_page.dart';
import 'package:patrimony/app/history/history_store.dart';
import 'package:patrimony/domain/company/get_history_usecase.dart';

class HistoryModule extends Module {

  @override
  void binds(Injector i) {
    i.add(GetHistoryUseCase.new);
    i.add(HistoryStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const HistoryPage());
  }

  @override
  List<Module> imports = [AppModule(), BottomViewModule()];
}