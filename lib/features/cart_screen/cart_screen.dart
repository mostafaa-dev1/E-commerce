import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/categories_model/categories_model.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

import '../../components/constance.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  int quantity = 1;
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var width = MediaQuery.of(context).size.width;

          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text('Cart',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'font',
                    ))),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = ShopCubit.get(context).cart[index];
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
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
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['name'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey[400],
                                                        fontFamily: 'font3'),
                                                  ),
                                                  Text(
                                                    data['quantity'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey[400],
                                                        fontFamily: 'font3'),
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       'Color: ',
                                              //       style: TextStyle(
                                              //           fontSize: 15,
                                              //           fontWeight: FontWeight
                                              //               .w500,
                                              //           color: Colors.grey[400],
                                              //           fontFamily: 'font3'
                                              //       ),
                                              //     ),
                                              //     Text(
                                              //       'Black',
                                              //       style: TextStyle(
                                              //           fontSize: 14,
                                              //           fontWeight: FontWeight
                                              //               .w500,
                                              //           color: Colors.grey[400],
                                              //           fontFamily: 'font3'
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '\$${data['price']}',
                                                    style: TextStyle(
                                                      color: color,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .grey[200]!,
                                                              blurRadius: 7,
                                                              spreadRadius: 1,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3))
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: StepperSwipe(
                                                        iconsColor:
                                                            Colors.black,
                                                        speedTransitionLimitCount:
                                                            3,
                                                        initialValue:
                                                            data['quantity'],
                                                        firstIncrementDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    250),
                                                        secondIncrementDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    100),
                                                        maxValue: 10,
                                                        minValue: 1,
                                                        dragButtonColor: color,
                                                        onChanged: (v) {
                                                          setState(() {
                                                            data['quantity'] =
                                                                v;
                                                            data[
                                                                'total'] = data[
                                                                    'price'] *
                                                                data[
                                                                    'quantity'];
                                                          });
                                                          ShopCubit.get(context)
                                                              .total();
                                                        },
                                                        stepperValue:
                                                            data['quantity']),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ShopCubit.get(context)
                                              .cart
                                              .remove(data);
                                          ShopCubit.get(context).total();
                                        });
                                      },
                                      icon: const Icon(
                                        IconBroken.Delete,
                                        size: 20,
                                      ),
                                      style: const ButtonStyle(
                                          overlayColor:
                                              MaterialStatePropertyAll(
                                                  Colors.transparent)),
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
                                          '\$${data['total']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: color,
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
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: ShopCubit.get(context).cart.length),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 7,
                        spreadRadius: 1,
                        offset: Offset(0, 3))
                  ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
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
                                  color: color,
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
                          // gradient:  LinearGradient(colors: [
                          //  color1,
                          //
                          // ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   stops: [0, 4.0],
                          //
                          // ),
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
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
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget CategoriesItems(CategoriesData Data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(Data.image!),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            Data.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.deepPurpleAccent,
          )
        ],
      ),
    );
  }
}
