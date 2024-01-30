import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  final List<String> itens;
  final String label;
  final String hintText;
  String? value;

  CustomDropDown({
    super.key,
    required this.value,
    required this.label,
    required this.hintText,
    required this.itens,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
  );

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      menuStyle: MenuStyle(
        surfaceTintColor: MaterialStatePropertyAll(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      initialSelection: widget.itens.first,
      onSelected: (String? value) {
        setState(() {
          widget.value = value!;
        });
      },
      dropdownMenuEntries:
          widget.itens.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
          style: ButtonStyle(
            textStyle:
                MaterialStatePropertyAll(Theme.of(context).textTheme.bodyLarge),
          ),
        );
      }).toList(),
      expandedInsets: const EdgeInsets.all(1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).primaryColorLight,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: Theme.of(context).textTheme.bodyLarge?.apply(
              color: Theme.of(context).primaryColorDark,
            ),
        hintStyle: Theme.of(context).textTheme.bodyLarge?.apply(
              color: Theme.of(context).disabledColor.withOpacity(0.4),
            ),
        enabledBorder: _defaultBorder.copyWith(
          borderSide: BorderSide(
            color: Theme.of(context).disabledColor.withOpacity(0.4),
          ),
        ),
        border: _defaultBorder,
        errorBorder: _defaultBorder,
        focusedErrorBorder: _defaultBorder,
        disabledBorder: _defaultBorder,
      ),
      label: Text(widget.label),
      hintText: widget.hintText,
    );
  }
}
