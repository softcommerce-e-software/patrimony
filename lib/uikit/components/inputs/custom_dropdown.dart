import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String labelText;
  final String hintText;
  final bool enabled;
  final Function(String? value) onSelected;

  const CustomDropDown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items, required this.onSelected, this.value,
    this.enabled = true,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).primaryColorDark,
              ),
        ),
        DropdownMenu<String>(
          menuStyle: MenuStyle(
            surfaceTintColor: MaterialStatePropertyAll(
              Theme.of(context).scaffoldBackgroundColor,
            ),
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          enabled: widget.enabled,
          initialSelection: widget.value,
          onSelected: (String? value) => widget.onSelected(value),
          dropdownMenuEntries:
              widget.items.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  Theme.of(context).textTheme.bodyLarge,
                ),
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
          hintText: widget.hintText,
        ),
      ],
    );
  }
}
