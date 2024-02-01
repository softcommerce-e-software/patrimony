import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_icon_input.dart';
import 'package:patrimony/uikit/components/form/custom_icon_select.dart';
import 'package:patrimony/uikit/components/inputs/custom_text_field.dart';
import 'package:patrimony/uikit/mockup/icons_list.dart';

class CustomModalForm extends StatefulWidget {
  final void Function(String, IconData) callback;

  const CustomModalForm({super.key, required this.callback});

  @override
  State<CustomModalForm> createState() => _CustomModalFormState();
}

class _CustomModalFormState extends State<CustomModalForm> {
  IconData _icon = IconsList.flutterIcons[0];

  final _defaultBorder = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: _defaultBorder,
      child: Flexible(
        fit: FlexFit.tight,
        child: Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: _defaultBorder,
          ),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: CustomTextField(
                        labelText: 'Nome da propriedade',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomIconInput(
                        labelText: 'Icone',
                        icon: _icon,
                        onTap: () async {
                          var response = await showDialog(
                            context: context,
                            builder: (context) {
                              return const Dialog(
                                child: CustomIconSelect(),
                              );
                            },
                          );

                          if (response != null) {
                            setState(() {
                              _icon = response;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        context: context,
                        background: Theme.of(context).colorScheme.error,
                        buttonText: 'Cancelar',
                        textColor: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomButton(
                        context: context,
                        background: Theme.of(context).primaryColor,
                        buttonText: 'Confirmar',
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          widget.callback.call('sad', _icon);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
