import 'package:flutter/material.dart';
import 'package:patrimony/app/history/history_store.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/base/app_state.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';
import 'package:patrimony/uikit/components/listview/custom_list_view.dart';

class HistoryPage extends StatefulWidget {
  final String companyId;
  const HistoryPage({super.key, required this.companyId});

  @override
  AppState<HistoryPage, HistoryStore> createState() => _HistoryPageState();
}

class _HistoryPageState extends AppState<HistoryPage, HistoryStore> {
  @override
  void initState() {
    super.initState();
    store.getHistory(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomDynamicAppBar(
        title: "Histórico",
        items: [],
      ),
      body: SafeArea(
        child: AppScopedBuilder(
          store: store,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 32.0
            ),
            child: CustomListView(
                onFinalScroll: () => store.getHistory(widget.companyId),
                itemCount: store.value.length,
                title: 'Itens',
                icon: Icons.format_list_bulleted,
                child: (index) => CustomListItem(
                  title: '${store.value[index].title}',
                  subtitle: '${store.value[index].email}',
                  onTap: () => {},
                )
            ),
          ),
        ),
      ),
    );
  }
}
