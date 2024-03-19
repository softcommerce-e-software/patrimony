import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/history/history_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';

class HistoryPage extends StatefulWidget {
  final String companyId;
  const HistoryPage({super.key, required this.companyId});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryStore _store = Modular.get();

  @override
  void initState() {
    super.initState();
    _store.getHistory(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScopedBuilder<HistoryStore, Failure, List<HistoryEntity>>(
        store: _store,
        onState: (_, result) {
          return ListView.separated(
            itemCount: _store.state.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CustomListItem(
                title: _store.state[index].title ?? "",
                subtitle: _store.state[index].email ?? "",
              );
          });
        },
        onError: (_, e) => Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
