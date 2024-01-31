import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';
import 'package:patrimony/uikit/components/inputs/custom_icon_input.dart';
import 'package:patrimony/uikit/components/inputs/custom_icon_select.dart';
import 'package:patrimony/uikit/components/inputs/custom_text_field.dart';

class CustomModalForm extends StatefulWidget {
  const CustomModalForm({super.key});

  @override
  State<CustomModalForm> createState() => _CustomModalFormState();
}

class _CustomModalFormState extends State<CustomModalForm> {
  final _defaultBorder = BorderRadius.circular(8);

  bool iconOptions = false;

  @override
  Widget build(BuildContext context) {
    return iconOptions == false
        ? Material(
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
                            flex: 6,
                            child: CustomTextField(
                              labelText: 'Nome da propriedade',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomIconInput(
                              onTap: () {
                                setState(() {
                                  iconOptions = true;
                                });
                              },
                              labelText: 'Icone',
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
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : CustomIconSelect(
            closePressed: () {
              setState(() {
                iconOptions = false;
              });
            },
          );
  }
}
