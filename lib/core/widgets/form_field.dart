import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFromField extends StatelessWidget {
  const AppFromField(
      {super.key,
      required this.controller,
      this.validator,
      required this.lapelText,
      required this.keyboardType});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String lapelText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey[400]!,
                )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: lapelText,
            labelStyle: TextStyle(color: Colors.grey[500], fontSize: 15)),
      ),
    );
  }
}
