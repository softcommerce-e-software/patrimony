import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomMessageField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final EdgeInsets? padding;
  final FormFieldValidator<String>? validator;

  const CustomMessageField({
    super.key,
    this.controller,
    this.textInputAction,
    this.textCapitalization,
    this.textInputType,
    this.inputFormatter,
    this.maxLength,
    this.helperText,
    this.hintText,
    this.labelText,
    this.validator,
    this.padding,
  });

  @override
  State<CustomMessageField> createState() => _CustomMessageFieldState();
}

class _CustomMessageFieldState extends State<CustomMessageField> {
  final _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
  );

  final _padding = const EdgeInsets.only(bottom: 16.0);

  String? _helperText;

  @override
  void initState() {
    super.initState();
    _helperText = widget.helperText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? _padding,
      child: TextFormField(
        onChanged: (String value) {
          if (value.length == 1) {
            setState(() {
              _helperText = null;
            });
          } else if (value.isEmpty) {
            setState(() {
              _helperText = widget.helperText;
            });
          }
        },
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        inputFormatters: widget.inputFormatter,
        style: const TextStyle(height: 1.0),
        maxLines: 4,
        decoration: InputDecoration(
          fillColor: Theme.of(context).primaryColorLight,
          filled: true,
          helperText: _helperText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText?.toUpperCase(),
          labelStyle: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).primaryColorDark,
              ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).disabledColor,
              ),
          focusedBorder: _defaultBorder.copyWith(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
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
      ),
    );
  }
}
