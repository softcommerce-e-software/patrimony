import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:patrimony/app/home/item/item_store.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:patrimony/uikit/components/attachment/attachment_grid.dart';
import 'package:patrimony/uikit/components/base/app_state.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_dropdown.dart';
import 'package:patrimony/uikit/components/inputs/custom_message_field.dart';

class ItemPage extends StatefulWidget {
  final ItemEntity entity;

  const ItemPage({super.key, required this.entity});

  @override
  AppState<ItemPage, ItemStore> createState() => _ItemPageState();
}

class _ItemPageState extends AppState<ItemPage, ItemStore> {
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _workingStatusController = TextEditingController();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
      decimalDigits: 2,
      locale: 'pt_BR',
      symbol: 'R\$'
  );

  bool _showUpdateButton = false;

  @override
  void initState() {
    super.initState();
    store.value = widget.entity;
    _nameController.text = widget.entity.name ?? "";
    _barcodeController.text = widget.entity.code ?? "";
    _valueController.text = widget.entity.value?.toString() ?? "";
    _observationsController.text = widget.entity.code ?? "";
    _statusController.text = widget.entity.status ?? "";
    _workingStatusController.text = widget.entity.workingStatus;

    _nameController.addListener(() {
      _showButton();
    });
    _barcodeController.addListener(() {
      _showButton();
    });
    _valueController.addListener(() {
      _showButton();
    });
    _observationsController.addListener(() {
      _showButton();
    });
    _statusController.addListener(() {
      _showButton();
    });
  }

  bool _isUpdate() {
    return _nameController.text != store.value.name
        || _barcodeController.text != store.value.code
        || _formatter.getUnformattedValue().toDouble() != store.value.value
        || _observationsController.text != store.value.observations
        || _statusController.text != store.value.status;
  }

  void _showButton() {
    setState(() {
      _showUpdateButton = _isUpdate()
          && _nameController.text.isNotEmpty
          && _valueController.text.isNotEmpty
          && _statusController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDynamicAppBar(
        title: store.value.name ?? "",
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Foto'),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: store.value.image?.isNotEmpty == true
                            ? Image.network(
                              store.value.image ?? '',
                              height: 200,
                            ) : const Icon(Icons.photo),
                      ),
                      FilledButton(
                          onPressed: () async {
                            var image = await addAttachment();
                            if (image != null) {
                              await store.addPhoto(image);
                              setState(() {});
                            }
                          },
                          child: Text("Galeria")
                      ),
                      FilledButton(
                          onPressed: () async {
                            await store.goToCamera();
                            setState(() {});
                          },
                          child: Text("Câmera")
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  CustomMessageField(
                    controller: _nameController,
                    labelText: 'Nome',
                    hintText: '',
                    enabled: true,
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  CustomMessageField(
                    controller: _barcodeController,
                    labelText: 'Código de barras',
                    textInputType: TextInputType.number,
                    hintText: '',
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
                    enabled: true,
                    textInputType: TextInputType.number,
                    onChanged: (value) => setState(() {}),
                    inputFormatter: [_formatter,],
                    hintText: '',
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomDropDown(
                      value: _statusController.text,
                      labelText: 'Estado atual',
                      enabled: true,
                      hintText: 'Na propriedade',
                      items: ['Na propriedade', 'Fora da propriedade', 'No Encontro com Deus'],
                      onSelected: (String? value) =>
                      {
                        _statusController.text = value ?? ""
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomDropDown(
                      value: _workingStatusController.text,
                      labelText: 'Estado de funcionamento',
                      enabled: true,
                      hintText: workingStatusList[0],
                      items: workingStatusList,
                      onSelected: (String? value) =>
                      {
                        _workingStatusController.text = value ?? ""
                      },
                    ),
                  ),
                  CustomMessageField(
                    controller: _observationsController,
                    labelText: 'Observações',
                    hintText: '',
                    enabled: true,
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: AttachmentGrid(
                      items: store.value.attachments?.map((e) =>
                          AttachmentEntity("", e)).toList() ?? [],
                      onDelete: (item) async {
                        await store.deleteAttachment(item.url);
                        setState(() {});
                      },
                      onAdd: () async {
                        var image = await addAttachment();
                        if (image != null) {
                          await store.addAttachment(image);
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ]
            ),
          ),
          Column(
            children: [
              Visibility(
                visible: _showUpdateButton,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 8.0
                  ),
                  child: CustomButton(
                      context: context,
                      background: Theme
                          .of(context)
                          .colorScheme
                          .surface,
                      textColor: Theme
                          .of(context)
                          .primaryColorLight,
                      buttonText: 'Atualizar',
                      onPressed: () async {
                        await store.updateItem(
                          _nameController.text,
                          _barcodeController.text,
                          _formatter.getUnformattedValue().toDouble(),
                          _observationsController.text,
                          _statusController.text,
                          _workingStatusController.text
                        );
                        _showButton();
                      },
                      isDisable: false
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: CustomButton(
                    context: context,
                    background: Theme
                        .of(context)
                        .colorScheme
                        .error,
                    textColor: Theme
                        .of(context)
                        .primaryColorLight,
                    buttonText: 'Deletar',
                    onPressed: () => store.delete(widget.entity.id),
                    isDisable: false
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
