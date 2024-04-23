import 'package:flutter/material.dart';
import 'package:patrimony/app/home/home_store.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/base/app_state.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';
import 'package:patrimony/uikit/components/listview/custom_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  AppState<HomePage, HomeStore> createState() => _HomePageState();
}

class _HomePageState extends AppState<HomePage, HomeStore> {
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
          onRefresh: () => store.getCompanies(),
          child: AppScopedBuilder(
            store: store,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 32.0
              ),
              child: CustomListView(
                  itemCount: store.value.length,
                  title: 'Minhas propriedades',
                  icon: Icons.account_balance_sharp,
                  child: (index) => CustomListItem(
                    title: store.value[index].name ?? "",
                    onTap: () => store.goToCategories(store.value[index]),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
