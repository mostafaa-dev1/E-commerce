import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newww/core/theming/fonts.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset('lib/assets/json/success.json',
              height: 300, repeat: false),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Payment Successful',
            style: AppFonts.style20B,
          )
        ]),
      ),
    );
  }
}
