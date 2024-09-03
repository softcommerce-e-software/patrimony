import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:patrimony/app/home/add_item/add_item_store.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/attachment/attachment_grid.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/base/app_state.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_dropdown.dart';
import 'package:patrimony/uikit/components/inputs/custom_message_field.dart';

class AddItemPage extends StatefulWidget {
  final String companyId;
  final String categoryId;
  const AddItemPage({super.key, required this.companyId, required this.categoryId});

  @override
  AppState<AddItemPage, AddItemStoreStore> createState() => _AddItemPageState();
}

class _AddItemPageState extends AppState<AddItemPage, AddItemStoreStore> {
  String _imagePath = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final List<File> _attachments = [];
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
      decimalDigits: 2,
      locale: 'pt_BR',
      symbol: 'R\$'
  );

  @override
  void initState() {
    _statusController.text = workingStatusList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomDynamicAppBar(
        title: "Adicionar Item",
        items: [],
      ),
      body: SafeArea(
        child: _screen()
      ),
    );
  }

  Widget _screen() {
    return AppScopedBuilder(
      store: store,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: ListView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Foto'),
                      Container(
                        height: 100,
                        width: 100,
                        child: _imagePath.isEmpty ? const Icon(Icons.photo)
                            : Image.file(File(_imagePath)),
                      ),
                      FilledButton(
                          onPressed: () async {
                            var image = await addAttachment();
                            if (image != null) {
                              setState(() {
                                _imagePath = image.path;
                              });
                            }
                          },
                          child: Text("Galeria")
                      ),
                      FilledButton(
                          onPressed: () async {
                            var photo = await store.goToCamera();
                            setState(() {
                              _imagePath = photo;
                            });
                          },
                          child: Text("Câmera")
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  CustomMessageField(
                    controller: _nameController,
                    labelText: 'Nome',
                    hintText: 'Nome do item',
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  CustomMessageField(
                    controller: _barcodeController,
                    labelText: 'Código de barras',
                    textInputType: TextInputType.number,
                    enabled: true,
                    padding: const EdgeInsets.only(bottom: 16.0),
                    icon: Icons.camera_alt,
                    iconPress: () async {
                      var barcode = await store.goToBarcode();
                      setState(() {
                        _barcodeController.text = barcode;
                      });
                    },
                  ),
                  CustomMessageField(
                    controller: _valueController,
                    labelText: 'Valor',
                    textInputType: TextInputType.number,
                    onChanged: (value) => setState(() {}),
                    inputFormatter: [_formatter,],
                    hintText: 'R\$ 12,00',
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomDropDown(
                      value: _statusController.text,
                      labelText: 'Estado de funcionamento',
                      enabled: true,
                      hintText: workingStatusList[0],
                      items: workingStatusList,
                      onSelected: (String? value) =>
                      {
                        _statusController.text = value ?? ""
                      },
                    ),
                  ),
                  CustomMessageField(
                    controller: _observationsController,
                    labelText: 'Observações',
                    onChanged: (value) => setState(() {}),
                    hintText: 'Ex: O produto está com mal contato no fio',
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: AttachmentGrid(
                      items: _attachments
                          .map((e) =>  AttachmentEntity("", e.path)).toList(),
                      onDelete: (item) => {},
                      onAdd: () async {
                        var image = await addAttachment();
                        if (image != null) {
                          _attachments.add(image);
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0
            ),
            child: CustomButton(
                context: context,
                background: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColorLight,
                buttonText: 'Salvar',
                onPressed: () => store.addItem(
                    widget.companyId,
                    widget.categoryId,
                    _nameController.text,
                    _barcodeController.text,
                    _formatter.getUnformattedValue().toDouble(),
                    _observationsController.text,
                    _attachments,
                    _imagePath,
                    _statusController.text,
                ),
                isDisable: _nameController.text.isEmpty
                    || _valueController.text.isEmpty
            ),
          )
        ],
      ),
    );
  }
}
