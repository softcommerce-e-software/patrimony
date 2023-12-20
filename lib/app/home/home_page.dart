import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/home/home_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/screens/list/simple_list_screen.dart';

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
      appBar: AppBar(
        title: const Text('Início'),
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
      child: RefreshIndicator(
        onRefresh: () => _store.getCompanies(),
        child: AppScopedBuilder<HomeStore, Failure, List<CompanyEntity>>(
          store: _store,
          onState: (_, result) {
            return SimpleListScreen(
              onTap: (index) => _store.goToCompany(_store.state[index]),
              onTapOptions:(index) => _store.goToOptions(_store.state[index]),
              labels: _store.state.map((e) => e.name ?? '').toList(),
              icon: 'assets/icon/ic_church.webp',
            );
          },
          onError: (_, e) => const Center(
            child: Text('Ocorreu um erro, tente novamente mais tarde'),
          ),
        ),
      ),
    );
  }
}
