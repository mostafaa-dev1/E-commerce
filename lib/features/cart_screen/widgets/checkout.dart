import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/features/checkout/checkout.dart';

class CheckOutButton extends StatefulWidget {
  const CheckOutButton({super.key});

  @override
  State<CheckOutButton> createState() => _CheckOutButtonState();
}

class _CheckOutButtonState extends State<CheckOutButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: const Offset(0, 3))
            ]),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontFamily: 'font',
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      Text(
                        '\$${ShopCubit.get(context).totalPrice}',
                        style: TextStyle(
                            fontFamily: 'font',
                            color: AppColors.primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: width / 2,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (ShopCubit.get(context).cart.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                    total: ShopCubit.get(context).totalPrice!,
                                  )),
                        );
                      }
                    },
                    child: const Text(
                      'Check Out',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: const Text(
              'The total dosn\'t contain shipping price',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
            ),
          )
        ]);
      },
    );
  }
}
