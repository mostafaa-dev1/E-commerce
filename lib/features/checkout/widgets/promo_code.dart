import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/widgets/custom_button.dart';
import 'package:newww/core/widgets/form_field_2.dart';

class PromoCode extends StatelessWidget {
  const PromoCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!,
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Promotional code',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Use promotional code to get discounts',
            style: TextStyle(
                fontSize: 15, fontFamily: 'font3', color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextForm(
                  width: MediaQuery.sizeOf(context).width / 1.7,
                  labelText: 'code',
                  controller: TextEditingController()),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                text: 'Apply',
                width: 100,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
