import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:patrimony/app/home/items/items_store.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/base/app_state.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';
import 'package:patrimony/uikit/components/listview/custom_list_view.dart';
import 'package:patrimony/uikit/ui_ext.dart';


class ItemsPage extends StatefulWidget {
  final CompanyEntity companyEntity;
  final CommonValueEntity categoryEntity;
  const ItemsPage({super.key, required this.companyEntity, required this.categoryEntity});

  @override
  AppState<ItemsPage, ItemsStore> createState() => _ItemsPageState();
}

class _ItemsPageState extends AppState<ItemsPage, ItemsStore> {
  Future<void> _getItems(bool isReset) async {
    await store.getItems(widget.companyEntity.id ?? "", widget.categoryEntity.id ?? "", isReset);
  }

  @override
  void initState() {
    super.initState();
    _getItems(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDynamicAppBar(
        title: widget.categoryEntity.name ?? "",
          items: [
            MenuItem("Editar Categoria", () => store.editCategory(widget.categoryEntity)),
            MenuItem("Relatório", () => store.goToReport(widget.companyEntity, widget.categoryEntity))
          ]
      ),
      body: SafeArea(
        child: _screen(),
      ),
    );
  }

  Widget _screen() {
    return AppScopedBuilder(
      store: store,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 32.0
        ),
        child: CustomListView(
            onFinalScroll: () => _getItems(false),
            itemCount: store.value.length,
            title: 'Itens',
            icon: Icons.format_list_bulleted,
            onAdd: () => store.goToAddItem(
                widget.companyEntity.id!,
                widget.categoryEntity.id!
            ),
            child: (index) => CustomListItem(
              imageUrl: store.value[index].image,
              title: '${store.value[index].name}'
                  '${store.value[index].code?.isNotEmpty == true
                  ? ' - ${store.value[index].code}' : ''}',
              subtitle: store.value[index].status ?? "",
              description: store.value[index].workingStatus,
              onTap: () => store.goToItem(store.value[index]),
            )
        ),
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
            // store.searchItem(value!);
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
