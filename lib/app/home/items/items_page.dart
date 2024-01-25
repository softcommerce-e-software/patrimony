import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:patrimony/app/home/items/items_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/screens/list/simple_list_screen.dart';
import 'package:patrimony/uikit/ui_ext.dart';

class ItemsPage extends StatefulWidget {
  final CompanyEntity entity;
  const ItemsPage({super.key, required this.entity});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final ItemsStore _store = Modular.get();

  @override
  void initState() {
    super.initState();
    _store.setCompany(widget.entity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itens'),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.heightPercent,
            width: 100.widthPercent,
            child: _scan(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 2.heightPercent,
              horizontal: 3.widthPercent
            ),
            child: Text(
              'Lista:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.widthPercent),
              child: AppScopedBuilder<ItemsStore, Failure, List<ItemEntity>>(
                store: _store,
                onState: (_, result) {
                  return SimpleListScreen(
                    onTap: (index) => _store.goToItem(_store.state[index]),
                    onTapOptions: null,
                    labels: _store.state.map((e) => e.code ?? '').toList(),
                    icon: 'assets/icon/ic_items.webp',
                  );
                },
                onError: (_, e) => const Center(
                  child: Text('Ocorreu um erro, tente novamente mais tarde'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scan() {
    return MobileScanner(
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          var value = barcode.rawValue;
          if(value?.trim() != '' ) {
            _store.searchItem(value!);
          }
        }
      },
      errorBuilder: (context, exception, widget) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.widthPercent),
            child: Text(
              'Ocorreu um erro ao tentar acessar a câmera.\nPor favor, ative a câmera nas configurações do aplicativo.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

}
