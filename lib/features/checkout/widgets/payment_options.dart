import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newww/core/payment/paybal/keys/keys.dart';
import 'package:newww/core/payment/paybal/models/amount_model/amount_model.dart';
import 'package:newww/core/payment/paybal/models/amount_model/details.dart';
import 'package:newww/core/payment/paybal/models/items_model/item.dart';
import 'package:newww/core/payment/paybal/models/items_model/items_model.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/success_pay.dart';

class PaymentOptions extends StatefulWidget {
  final double total;
  const PaymentOptions({super.key, required this.total});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  @override
  bool clicked = false;
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              spreadRadius: 1,
              blurRadius: 7,
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      clicked = !clicked;
                    });
                  },
                  icon: Icon(
                    clicked ? Icons.check_circle : Icons.circle_outlined,
                    color: clicked ? AppColors.primaryColor : Colors.black,
                    size: 27,
                  )),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cash on Delivery',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    'Pay by cash on delivery',
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'font3', color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: MediaQuery.sizeOf(context).width / 7,
                color: Colors.grey[400],
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Or pay with',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'font3', color: Colors.grey),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 1,
                width: MediaQuery.sizeOf(context).width / 7,
                color: Colors.grey[400],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  var amount = AmountModel(
                      total: widget.total.toString(),
                      currency: 'USD',
                      details: Details(
                        subtotal: widget.total.toString(),
                        shipping: '0',
                        shippingDiscount: 0,
                      ));

                  List<Item> orderItems = [
                    Item(
                      name: 'Apple',
                      quantity: 1,
                      price: (widget.total / 2).toString(),
                      currency: 'USD',
                    ),
                    Item(
                      name: 'Apple',
                      quantity: 1,
                      price: (widget.total / 2).toString(),
                      currency: 'USD',
                    )
                  ];
                  var itemList = ItemsModel(
                    items: orderItems,
                  );
                  paypalPayment(context, amount, itemList);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10)),
                    child: SvgPicture.asset(
                      height: 70,
                      'lib/assets/svg/paypal.svg',
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(
                    height: 70,
                    'lib/assets/svg/card.svg',
                  )),
            ],
          )
        ],
      ),
    );
  }
}

void paypalPayment(
    BuildContext context, AmountModel amount, ItemsModel itemList) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context) => PaypalCheckoutView(
      sandboxMode: true,
      clientId: PaypalKeys.clientId,
      secretKey: PaypalKeys.secretKey,
      transactions: [
        {
          "amount": amount.toAmountModel(),
          "description": "The payment transaction description.",
          "item_list": itemList.toItemsModel(),
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        log("onSuccess: $params");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SuccessPayment();
        }));
      },
      onError: (error) {
        log("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        print('cancelled:');
        Navigator.pop(context);
      },
    ),
  ));
}
