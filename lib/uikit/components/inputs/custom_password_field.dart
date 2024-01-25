import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final Widget? sufixIcon;
  final int? maxLength;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final EdgeInsets? padding;
  final FormFieldValidator<String>? validator;

  const CustomPasswordField({
    super.key,
    this.controller,
    this.textInputAction,
    this.textCapitalization,
    this.textInputType,
    this.sufixIcon,
    this.maxLength,
    this.helperText,
    this.hintText,
    this.labelText,
    this.validator,
    this.padding,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  final _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
  );

  final _padding = const EdgeInsets.only(bottom: 16.0);

  bool isHiden = true;
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
        obscureText: isHiden,
        style: const TextStyle(height: 1.0),
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isHiden = !isHiden;
              });
            },
            child: Icon(
              isHiden ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.02),
          filled: true,
          helperText: _helperText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText?.toUpperCase(),
          labelStyle: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).primaryColorDark,
              ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).disabledColor.withOpacity(0.4),
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
