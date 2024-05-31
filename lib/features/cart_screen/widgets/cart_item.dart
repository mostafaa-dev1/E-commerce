import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

import '../../../core/theming/colors.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var data = ShopCubit.get(context).cart[index];
            return BuildCartItem(data, context, width);
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
          itemCount: ShopCubit.get(context).cart.length),
    );
  }

  Widget BuildCartItem(data, context, width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: const Offset(0, 3))
            ],
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(data['image']),
                    width: 150,
                    height: 110,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'font2'),
                          ),
                          Row(
                            children: [
                              Text(
                                'Quantity: ',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[400],
                                    fontFamily: 'font3'),
                              ),
                              Text(
                                data['quantity'].toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[400],
                                    fontFamily: 'font3'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${data['price']}',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200]!,
                                          blurRadius: 7,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 3))
                                    ],
                                    borderRadius: BorderRadius.circular(50)),
                                child: StepperSwipe(
                                    iconsColor: Colors.black,
                                    speedTransitionLimitCount: 3,
                                    initialValue: data['quantity'],
                                    firstIncrementDuration:
                                        const Duration(milliseconds: 250),
                                    secondIncrementDuration:
                                        const Duration(milliseconds: 100),
                                    maxValue: 10,
                                    minValue: 1,
                                    dragButtonColor: AppColors.primaryColor,
                                    onChanged: (v) {
                                      setState(() {
                                        data['quantity'] = v;
                                        data['total'] =
                                            data['price'] * data['quantity'];
                                      });
                                      ShopCubit.get(context).total();
                                    },
                                    stepperValue: data['quantity']),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: width / 1.1,
              height: 1,
              color: Colors.grey[200],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      ShopCubit.get(context).cart.remove(data);
                      ShopCubit.get(context).total();
                    });
                  },
                  icon: const Icon(
                    IconBroken.Delete,
                    size: 20,
                  ),
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey[200],
                ),
                Row(
                  children: [
                    const Text(
                      'Total: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'font3',
                          fontSize: 15),
                    ),
                    Text(
                      '\$${data['price'] * data['quantity']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.primaryColor,
                          fontFamily: 'font'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
