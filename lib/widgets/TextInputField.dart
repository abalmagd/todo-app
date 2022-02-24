import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.value,
    required this.controller,
    this.inputType = TextInputType.text,
    this.validate = 'Field must not be empty!',
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String? value;
  final TextEditingController controller;
  final TextInputType inputType;
  final String validate;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      controller: controller,
      keyboardType: inputType,
      validator: (value) {
        if (value!.isEmpty) return validate;
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
