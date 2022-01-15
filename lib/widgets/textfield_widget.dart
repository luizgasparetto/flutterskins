import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final TextEditingController controller;

  // ignore: use_key_in_widget_constructors
  const TextFieldWidget({
    required this.hintText,
    required this.prefixIconData,
    this.suffixIconData,
    required this.obscureText,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blueAccent),
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Colors.blueAccent,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(104, 105, 119, 0.2),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(
          suffixIconData,
          size: 18,
          color: Colors.blueAccent,
        ),
        labelStyle: const TextStyle(color: Colors.blueAccent),
        focusColor: Colors.blueAccent,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Plese enter your $hintText';
        } else if (value.length < 6) {
          return 'Plese enter a $hintText with more than 6 characters';
        } else {
          return null;
        }
      },
    );
  }
}
