import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_message_field.dart';
import 'package:patrimony/uikit/mockup/icons_list.dart';

void showCustomModal({
  required String title, required Function(String) callback, String? label
}) {
  Asuka.showDialog(builder: (context) =>
      CustomModalForm(title: title, callback: callback, label: label ?? '',)
  );
}

class CustomModalForm extends StatefulWidget {
  final void Function(String) callback;
  final String title;
  final String label;

  const CustomModalForm({
    super.key, required this.callback, required this.title,
    required this.label
  });

  @override
  State<CustomModalForm> createState() => _CustomModalFormState();
}

class _CustomModalFormState extends State<CustomModalForm> {
  final IconData _icon = IconsList.flutterIcons[0];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.label;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomMessageField(
            controller: _controller,
            labelText: widget.title,
            onChanged: (value) {setState(() {});},
            maxLines: 1,
          ),
        ],
      ),
      actionsOverflowButtonSpacing: 8,
      actions: [
        CustomButton(
          context: context,
          background: Theme.of(context).primaryColor,
          buttonText: 'Confirmar',
          isDisable: _controller.text.isEmpty,
          textColor: Theme.of(context).primaryColorLight,
          onPressed: () {
            widget.callback.call(_controller.text.trim());
            Navigator.pop(context);
          },
        ),
        CustomButton(
          context: context,
          background: Theme.of(context).colorScheme.error,
          buttonText: 'Cancelar',
          textColor: Theme.of(context).primaryColorLight,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
