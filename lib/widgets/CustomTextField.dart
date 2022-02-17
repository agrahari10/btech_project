import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;

  CustomTextField(
      {required this.hintText,
        required this.obscureText,
        required this.onSaved,
        required this.regEx
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // keyboardType: ,
      onSaved: (_value) => onSaved(_value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      validator: (_value) {
        // return _value;
        return RegExp(regEx).hasMatch(_value!) ? null : 'Enter a valid Input';
      },
      decoration: InputDecoration(
        // fillColor: Colors.black,
          fillColor: Color.fromRGBO(3, 2, 7, 0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black)),
    );
  }
}