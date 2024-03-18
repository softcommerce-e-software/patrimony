import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/home/add_item/add_item_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/attachment/attachment_grid.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_message_field.dart';

class AddItemPage extends StatefulWidget {
  final String companyId;
  final String categoryId;
  const AddItemPage({super.key, required this.companyId, required this.categoryId});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final AddItemStoreStore _store = Modular.get();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  final List<File> _attachments = [];
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
      decimalDigits: 2,
      locale: 'pt_BR',
      symbol: 'R\$'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomDynamicAppBar(
        title: "Adicionar Item",
        hasMenu: false
      ),
      body: SafeArea(
        child: AppScopedBuilder<AddItemStoreStore, Failure, bool>(
          store: _store,
          onState: (_, result) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                          children: [
                            CustomMessageField(
                              controller: _barcodeController,
                              labelText: 'Código de barras',
                              textInputType: TextInputType.number,
                              hintText: '0001',
                              onChanged: (value) => setState(() {}),
                              padding: const EdgeInsets.only(bottom: 16.0),

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
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 16.0),
                            //   child: CustomDropDown(
                            //     value: _state,
                            //     labelText: 'Estado atual',
                            //     hintText: 'Na propriedade',
                            //     items: ['Na propriedade', 'Fora da propriedade'],
                            //     onSelected: (String? value) => {
                            //       _state = value
                            //     },
                            //   ),
                            // ),
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
                          onPressed: () => _store.addItem(
                              widget.companyId,
                              widget.categoryId,
                              _barcodeController.text,
                              _formatter.getUnformattedValue().toDouble(),
                              _observationsController.text,
                              _attachments
                          ),
                          isDisable: _barcodeController.text.isEmpty
                              || _valueController.text.isEmpty
                      ),
                    )
                  ],
                );
              }
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
