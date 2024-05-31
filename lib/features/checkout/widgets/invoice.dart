import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newww/core/theming/colors.dart';

class Invoice extends StatelessWidget {
  const Invoice({super.key, required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!,
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: Column(
            children: [
              Text(
                'Invoice',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'font2',
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order id',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'font3')),
                  Text('#200114',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'font3')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Items',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'font3')),
                  Text('\$$total',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'font')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      )),
                  Text('\$50.00',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'font')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 1.1,
                height: 1,
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'font2')),
                  Text('\$${total + 50}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'font2')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(7),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(-5, 5))
            ],
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
          ),
          child: const Center(
            child: Text('PREMIUM',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'font1')),
          ),
        ),
      ],
    );
  }
}
