import 'package:flutter/material.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/features/checkout/widgets/invoice.dart';
import 'package:newww/features/checkout/widgets/payment_options.dart';
import 'package:newww/features/checkout/widgets/promo_code.dart';
import 'package:newww/features/checkout/widgets/shipping_address.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;
  const CheckoutScreen({super.key, required this.total});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

bool clicked = false;

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: TextStyle(
              fontFamily: 'font1',
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ShippingAddress(),
              const SizedBox(
                height: 10,
              ),
              Invoice(
                total: widget.total,
              ),
              const SizedBox(
                height: 20,
              ),
              PromoCode(),
              const SizedBox(
                height: 20,
              ),
              PaymentOptions(total: widget.total + 50),
            ],
          ),
        ),
      ),
    );
  }
}
