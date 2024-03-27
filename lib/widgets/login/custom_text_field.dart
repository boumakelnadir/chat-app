import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.icon,
    this.keyboard,
    this.onChanged,
    this.obscureText = false,
  });
  final bool? obscureText;
  final String label;
  final IconData? icon;
  final TextInputType? keyboard;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        obscureText: false,
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required, please try again';
          } else {
            return null;
          }
        },
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        keyboardType: keyboard ?? TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          suffixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
