import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/home/types/types_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';
import 'package:patrimony/uikit/components/modal/custom_modal_form.dart';

import '../../../uikit/components/listview/custom_list_view.dart';

class TypesPage extends StatefulWidget {
  const TypesPage({super.key, required this.companyEntity});

  final CompanyEntity companyEntity;

  @override
  State<TypesPage> createState() => _TypesPageState();
}

class _TypesPageState extends State<TypesPage> {
  final TypesStore _store = Modular.get();

  @override
  void initState() {
    super.initState();
    _store.getPage(widget.companyEntity.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDynamicAppBar(
        title: widget.companyEntity.name ?? "",
        items: [
          // MenuItem("Histórico", () => _store.goToHistory(widget.companyEntity))
        ]
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _store.getPage(widget.companyEntity.id ?? ""),
          child: AppScopedBuilder<TypesStore, Failure, TypesPageEntity>(
            store: _store,
            onState: (_, result) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 32.0),
                    child: CustomListView(
                        itemCount: _store.state.types.length,
                        title: 'Categorias',
                        icon: Icons.category,
                        onAdd: () => _store.createCategory(widget.companyEntity.id ?? ""),
                        child: (index) => CustomListItem(
                              title: _store.state.types[index].name ?? "",
                              onTap: () => _store.goToItems(
                                  widget.companyEntity,
                                  _store.state.types[index]),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomListView(
                        itemCount: _store.state.users.length,
                        title: 'Usuários',
                        icon: Icons.supervised_user_circle,
                        child: (index) => CustomListItem(
                              title: _store.state.users[index].name ?? "",
                              subtitle: _store.state.users[index].email ?? "",
                            )),
                  ),
                ],
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
