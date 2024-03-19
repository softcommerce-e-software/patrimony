import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_message_field.dart';
import 'package:patrimony/uikit/mockup/icons_list.dart';

void showCustomModal(String title, Function(String) callback) {
  Asuka.showDialog(builder: (context) =>
      CustomModalForm(title: title, callback: callback)
  );
}

class CustomModalForm extends StatefulWidget {
  final void Function(String) callback;
  final String title;

  const CustomModalForm({
    super.key, required this.callback, required this.title
  });

  @override
  State<CustomModalForm> createState() => _CustomModalFormState();
}

class _CustomModalFormState extends State<CustomModalForm> {
  final IconData _icon = IconsList.flutterIcons[0];
  final TextEditingController _controller = TextEditingController();

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
            widget.callback.call(_controller.text);
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
