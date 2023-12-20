import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/home/types/types_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/screens/list/simple_list_screen.dart';

class TypesPage extends StatefulWidget {
  const TypesPage({super.key});

  @override
  State<TypesPage> createState() => _TypesPageState();
}

class _TypesPageState extends State<TypesPage> {
  final TypesStore _store = Modular.get();

  @override
  void initState() {
    super.initState();
    _store.getTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos'),
      ),
      body: _screen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _screen() {
    return SafeArea(
      child: AppScopedBuilder<TypesStore, Failure, List<CommonValueEntity>>(
        store: _store,
        onState: (_, result) {
          return SimpleListScreen(
            onTap: (index) => _store.goToItem(_store.state[index]),
            onTapOptions:(index) => _store.goToOptions(_store.state[index]),
            labels: _store.state.map((e) => e.value ?? '').toList(),
            icon: 'assets/icon/ic_menu.webp',
          );
        },
        onError: (_, e) => const Center(
          child: Text('Ocorreu um erro, tente novamente mais tarde'),
        ),
      ),
    );
  }
}
