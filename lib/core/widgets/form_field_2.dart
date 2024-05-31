import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key,
      required this.labelText,
      required this.controller,
      this.onFieldSubmitted,
      required this.width});
  final String labelText;
  final double width;
  final TextEditingController controller;
  final String? Function(String?)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: 'font2',
              fontSize: 15,
              color: Colors.grey[500],
            ),
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[400]!, width: 1)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}
