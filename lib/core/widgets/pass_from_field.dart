import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newww/features/register_screen/logic/register_cubit.dart';

class PassFormField extends StatelessWidget {
  final TextEditingController controller;

  const PassFormField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ('password is too short');
          }
        },
        obscureText: ShopRegisterCubit.get(context).isVisiable,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey[400]!,
                )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
            suffixIcon: IconButton(
              onPressed: () {
                ShopRegisterCubit.get(context).IsSufixPressed();
              },
              icon: Icon(
                ShopRegisterCubit.get(context).suffix,
              ),
            )),
      ),
    );
  }
}
