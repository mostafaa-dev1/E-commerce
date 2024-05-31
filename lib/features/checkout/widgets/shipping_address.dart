import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/core/theming/colors.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
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
            'Shipping Address',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'font2',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                IconBroken.Location,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'font2',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    'Egypt, Cairo',
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'font3', color: Colors.black),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      'Change',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
