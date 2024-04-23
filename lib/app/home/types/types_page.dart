import 'package:flutter/material.dart';
import 'package:patrimony/app/home/types/types_store.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/base/app_state.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';

import '../../../uikit/components/listview/custom_list_view.dart';

class TypesPage extends StatefulWidget {
  const TypesPage({super.key, required this.companyEntity});

  final CompanyEntity companyEntity;

  @override
  AppState<TypesPage, TypesStore> createState() => _TypesPageState();
}

class _TypesPageState extends AppState<TypesPage, TypesStore> {

  @override
  void initState() {
    super.initState();
    store.getPage(widget.companyEntity.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDynamicAppBar(
        title: widget.companyEntity.name ?? "",
        items: [
          MenuItem("Histórico", () => store.goToHistory(widget.companyEntity))
        ]
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => store.getPage(widget.companyEntity.id ?? ""),
          child: AppScopedBuilder(
            store: store,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 32.0),
                  child: CustomListView(
                      itemCount: store.value.types.length,
                      title: 'Categorias',
                      icon: Icons.category,
                      onAdd: () => store.createCategory(widget.companyEntity.id ?? ""),
                      child: (index) => CustomListItem(
                        title: store.value.types[index].name ?? "",
                        onTap: () => store.goToItems(
                            widget.companyEntity,
                            store.value.types[index]),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomListView(
                      itemCount: store.value.users.length,
                      title: 'Usuários',
                      icon: Icons.supervised_user_circle,
                      child: (index) => CustomListItem(
                        title: store.value.users[index].name ?? "",
                        subtitle: store.value.users[index].email ?? "",
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
