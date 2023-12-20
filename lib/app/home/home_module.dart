import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/app_module.dart';
import 'package:patrimony/app/bottom_view/bottom_view_module.dart';
import 'package:patrimony/app/home/home_page.dart';
import 'package:patrimony/app/home/home_store.dart';
import 'package:patrimony/app/home/item/item_page.dart';
import 'package:patrimony/app/home/items/items_page.dart';
import 'package:patrimony/app/home/items/items_store.dart';
import 'package:patrimony/app/home/types/types_page.dart';
import 'package:patrimony/app/home/types/types_store.dart';
import 'package:patrimony/domain/company/get_companies_usecase.dart';
import 'package:patrimony/domain/company/get_conservation_states_usecase.dart';
import 'package:patrimony/domain/company/get_types_usecase.dart';
import 'package:patrimony/domain/company/search_item_usecase.dart';
import 'package:patrimony/domain/user/get_user_is_admin_usecase.dart';

import 'item/item_store.dart';

class HomeModule extends Module {

  @override
  void binds(Injector i) {
    i.add(GetConservationStatesUseCase.new);
    i.add(GetCompaniesUseCase.new);
    i.add(GetTypesUseCase.new);
    i.add(SearchItemUseCase.new);
    i.add(GetUserIsAdminUseCase.new);
    i.add(HomeStore.new);
    i.add(TypesStore.new);
    i.add(ItemsStore.new);
    i.add(ItemStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const HomePage(),
      children: [
        ChildRoute('/types', child: (_) => const TypesPage(),),
        ChildRoute('/items', child: (_) => ItemsPage(entity: r.args.data),),
        ChildRoute('/item', child: (_) => ItemPage(entity: r.args.data),),
      ]
    );
  }

  @override
  List<Module> imports = [AppModule(), BottomViewModule()];
}