import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/home/item/item_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/attachment/attachment_grid.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_dropdown.dart';
import 'package:patrimony/uikit/components/inputs/custom_message_field.dart';
import 'package:patrimony/uikit/ui_ext.dart';

class ItemPage extends StatefulWidget {
  final ItemEntity entity;

  const ItemPage({super.key, required this.entity});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ItemStore _store = Modular.get();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.entity.name ?? "";
    _barcodeController.text = widget.entity.code ?? "";
    _valueController.text = widget.entity.value?.toString() ?? "";
    _observationsController.text = widget.entity.code ?? "";
    _statusController.text = widget.entity.status ?? "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDynamicAppBar(
        title: widget.entity.code ?? "",
        items: [],
      ),
      body: _screen(),
    );
  }

  Widget _screen() {
    return SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: ListView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                children: [
                  widget.entity.image?.isNotEmpty  == true ?
                  Image.network(
                      widget.entity.image ?? '',
                    height: 200,
                  ) : const SizedBox(),
                  CustomMessageField(
                    controller: _nameController,
                    labelText: 'Nome',
                    hintText: '',
                    enabled: false,
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  CustomMessageField(
                    controller: _barcodeController,
                    labelText: 'Código de barras',
                    textInputType: TextInputType.number,
                    hintText: '',
                    enabled: false,
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  CustomMessageField(
                    controller: _valueController,
                    labelText: 'Valor',
                    enabled: false,
                    inputFormatter: [
                      CurrencyTextInputFormatter(
                          decimalDigits: 2,
                          locale: 'pt_BR',
                          symbol: 'R\$'
                      ),
                    ],
                    hintText: '',
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomDropDown(
                      value: _statusController.text,
                      labelText: 'Estado atual',
                      enabled: false,
                      hintText: 'Na propriedade',
                      items: ['Na propriedade', 'Fora da propriedade'],
                      onSelected: (String? value) => {
                        _statusController.text = value ?? ""
                      },
                    ),
                  ),
                  CustomMessageField(
                    controller: _observationsController,
                    labelText: 'Observações',
                    hintText: '',
                    enabled: false,
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: AttachmentGrid(
                      items: widget.entity.attachments?.map((e) =>  AttachmentEntity("", e)).toList() ?? [],
                      onDelete: (item) => {},
                      onAdd: () {},
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
                background: Theme.of(context).colorScheme.error,
                textColor: Theme.of(context).primaryColorLight,
                buttonText: 'Deletar',
                onPressed: () => _store.delete(widget.entity.id),
                isDisable: false
            ),
          )
        ],
      ),
    );
  }
}
