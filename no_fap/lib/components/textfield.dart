import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final dynamic controller;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.brown.shade300,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.brown.shade300),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
