import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.node,
    required this.controller,
    required this.lableText,
    required this.inputType,
    this.callback,
    this.onTap,
    this.readOnly = false,
    this.isObscure = false,
    this.icon,
    this.onSuffixIconClicked,
  });

  final FocusNode node;
  final TextEditingController controller;
  final String lableText;
  final Function? callback;
  final Function? onTap;
  final TextInputType inputType;
  final bool readOnly;
  final bool isObscure;
  final IconData? icon;
  final VoidCallback? onSuffixIconClicked;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: node,
      controller: controller,
      validator: (value) => callback?.call(value),
      onTap: () => onTap?.call(),
      readOnly: readOnly,
      keyboardType: inputType,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: lableText,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: () => onSuffixIconClicked?.call(),
        ),
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
