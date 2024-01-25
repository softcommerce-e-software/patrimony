import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/home/item/item_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/ui_ext.dart';

class ItemPage extends StatefulWidget {
  final ItemEntity entity;

  const ItemPage({super.key, required this.entity});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ItemStore _store = Modular.get();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _conservationStateController =
      TextEditingController();
  final List<DropdownMenuEntry<String>> _types = <DropdownMenuEntry<String>>[];
  final List<DropdownMenuEntry<String>> _companies =
      <DropdownMenuEntry<String>>[];
  final List<DropdownMenuEntry<String>> _conservationStates =
      <DropdownMenuEntry<String>>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entity.code ?? ''),
      ),
      body: _screen(),
    );
  }

  Widget _screen() {
    return SafeArea(
      child: AppScopedBuilder<ItemStore, Failure, ItemEntity>(
        store: _store,
        onState: (_, result) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _inputText('Código de barras:', widget.entity.code ?? ''),
                _inputText('Patrimônio:', widget.entity.code ?? ''),
                _inputText('Local de registro:',
                    widget.entity.registrationLocation ?? ''),
                _dropDown('Local atual:', widget.entity.nowLocation ?? '',
                    _companyController, _companies, (String? value) {}),
                _dropDown(
                    'Estado de conservação:',
                    widget.entity.conservationState ?? '',
                    _conservationStateController,
                    _conservationStates,
                    (String? value) {}),
                _dropDown('Tipo:', widget.entity.type ?? '', _typeController,
                    _types, (String? value) {}),
                InteractiveViewer(
                  panEnabled: false,
                  minScale: 1,
                  maxScale: 3,
                  child: Image.network(
                      height: 30.heightPercent, widget.entity.invoice ?? ''),
                ),
              ],
            ),
          );
        },
        onError: (_, e) => const Center(
          child: Text('Ocorreu um erro, tente novamente mais tarde'),
        ),
      ),
    );
  }

  Widget _inputText(String label, String text) {
    return Padding(
      padding: EdgeInsets.only(
          top: 1.heightPercent, left: 3.widthPercent, right: 3.widthPercent),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        controller: TextEditingController(text: text),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.black,
            ),
        enabled: false,
      ),
    );
  }

  Widget _dropDown(
      String label,
      String initialSelection,
      TextEditingController controller,
      List<DropdownMenuEntry<String>> dropdownMenuEntries,
      Function(String?) onSelected) {
    return SizedBox(
      width: 100.widthPercent,
      child: Padding(
        padding: EdgeInsets.only(
          top: 1.heightPercent,
          left: 3.widthPercent,
          right: 3.widthPercent,
        ),
        child: Expanded(
          child: DropdownMenu<String>(
            width: 94.widthPercent,
            initialSelection: initialSelection,
            controller: controller,
            label: Text(label),
            dropdownMenuEntries: dropdownMenuEntries,
            onSelected: onSelected,
          ),
        ),
      ),
    );
  }
}
