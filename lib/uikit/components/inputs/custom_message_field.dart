import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomMessageField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final EdgeInsets? padding;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

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
    this.minLines,
    this.labelText,
    this.validator,
    this.padding, this.maxLines, this.onChanged, this.enabled = true,
  });

  @override
  State<CustomMessageField> createState() => _CustomMessageFieldState();
}

class _CustomMessageFieldState extends State<CustomMessageField> {
  final _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
  );

  String? _helperText;

  @override
  void initState() {
    super.initState();
    _helperText = widget.helperText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Text(
                widget.labelText!,
                style: Theme.of(context).textTheme.bodyLarge?.apply(
                      color: Theme.of(context).primaryColorDark,
                    ),
              )
            : const SizedBox(),
        Padding(
          padding: widget.padding ?? const EdgeInsets.all(0),
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
              widget.onChanged?.call(value);
            },
            enabled: widget.enabled,
            validator: widget.validator,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            inputFormatters: widget.inputFormatter,
            style: const TextStyle(height: 1.0),
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColorLight,
              filled: true,
              helperText: _helperText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
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
        ),
      ],
    );
  }
}
