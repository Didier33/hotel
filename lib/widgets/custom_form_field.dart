// widgets/custom_form_field.dart
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;

  const CustomFormField({
    super.key,
    required this.label,
    this.validator,
    this.onSaved,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      validator: validator,
      onSaved: onSaved,
      obscureText: isPassword,
      keyboardType: keyboardType,
    );
  }
}
