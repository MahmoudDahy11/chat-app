import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  CustomTextFromField({
    super.key,
    required this.hintText,
    this.onChange,
    this.obscureText = false,
  });
  final String hintText;
  Function(String)? onChange;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'value is required';
        }
        return null;
      },
      onChanged: onChange,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.black),
        ),
        hint: Text(hintText, style: TextStyle(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
