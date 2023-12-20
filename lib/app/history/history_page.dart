import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/history/history_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryStore _store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScopedBuilder<HistoryStore, Failure, List<HistoryEntity>>(
        store: _store,
        onState: (_, result) {
          return ListView.builder(
            itemCount: _store.state.length,
            itemBuilder: (context, index) {
              return Text(_store.state[index].description ?? 'deu problema');
            }
          );
        },
        onError: (_, e) => Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
