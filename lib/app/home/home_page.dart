import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/home/home_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';
import 'package:patrimony/uikit/components/listview/custom_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomDynamicAppBar(
        title: "Patrimony",
        hasBackButton: false,
        items: [],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _store.getCompanies(),
          child: AppScopedBuilder<HomeStore, Failure, List<CompanyEntity>>(
            store: _store,
            onState: (_, result) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 32.0
                ),
                child: CustomListView(
                    itemCount: _store.state.length,
                    title: 'Minhas propriedades',
                    icon: Icons.account_balance_sharp,
                    child: (index) => CustomListItem(
                      title: _store.state[index].name ?? "",
                      onTap: () => _store.goToCategories(_store.state[index]),
                    )
                ),
              );
            },
            onError: (_, e) => const Center(
              child: Text('Ocorreu um erro, tente novamente mais tarde'),
            ),
          ),
        ),
      ),
    );
  }
}
