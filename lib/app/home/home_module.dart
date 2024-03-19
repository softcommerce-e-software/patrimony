import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/app_module.dart';
import 'package:patrimony/app/bottom_view/bottom_view_module.dart';
import 'package:patrimony/app/history/history_page.dart';
import 'package:patrimony/app/history/history_store.dart';
import 'package:patrimony/app/home/add_item/add_item_page.dart';
import 'package:patrimony/app/home/add_item/add_item_store.dart';
import 'package:patrimony/app/home/home_page.dart';
import 'package:patrimony/app/home/home_store.dart';
import 'package:patrimony/app/home/item/item_page.dart';
import 'package:patrimony/app/home/items/items_page.dart';
import 'package:patrimony/app/home/items/items_store.dart';
import 'package:patrimony/app/home/types/types_page.dart';
import 'package:patrimony/app/home/types/types_store.dart';
import 'package:patrimony/domain/company/get_companies_usecase.dart';
import 'package:patrimony/domain/company/get_conservation_states_usecase.dart';
import 'package:patrimony/domain/company/get_history_usecase.dart';
import 'package:patrimony/domain/company/get_itens_usecase.dart';
import 'package:patrimony/domain/company/get_types_usecase.dart';
import 'package:patrimony/domain/company/get_users_usecase.dart';
import 'package:patrimony/domain/company/post_category_usecase.dart';
import 'package:patrimony/domain/company/post_item_usecase.dart';
import 'package:patrimony/domain/company/search_item_usecase.dart';

import 'item/item_store.dart';

class HomeModule extends Module {

  @override
  void binds(Injector i) {
    i.add(PostItemUseCase.new);
    i.add(GetConservationStatesUseCase.new);
    i.add(GetCompaniesUseCase.new);
    i.add(GetTypesUseCase.new);
    i.add(SearchItemUseCase.new);
    i.add(GetUsersUseCase.new);
    i.add(GetItemsUseCase.new);
    i.add(PostCategoryUseCase.new);
    i.add(HomeStore.new);
    i.add(TypesStore.new);
    i.add(ItemsStore.new);
    i.add(ItemStore.new);
    i.add(AddItemStoreStore.new);

    i.add(GetHistoryUseCase.new);
    i.add(HistoryStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const HomePage(),
      children: [
        ChildRoute('/categories', child: (_) => TypesPage(companyEntity: r.args.data),),
        ChildRoute('/items', child: (_) => ItemsPage(
            companyEntity: r.args.data['company'],
            categoryEntity: r.args.data['category']
        ),),
        ChildRoute('/item', child: (_) => ItemPage(entity: r.args.data),),
        ChildRoute('/add_item', child: (_) => AddItemPage(
            companyId: r.args.data['companyId'],
            categoryId: r.args.data['categoryId']
        ),),
        ChildRoute('/history', child: (_) => HistoryPage(companyId: r.args.data),),
      ]
    );
  }

  @override
  List<Module> imports = [AppModule(), BottomViewModule()];
}