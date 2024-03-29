import 'package:flutter/material.dart';

class TextFormFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final String labelText;
  final int inputSize;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  const TextFormFieldInput(
      {Key? key,
      required this.controller,
      this.isPass = false,
      required this.hintText,
      required this.labelText,
      this.inputSize = 128,
      required this.textInputType,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      maxLength: inputSize,
      decoration: InputDecoration(
        counterText: "",
        labelText: labelText,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
