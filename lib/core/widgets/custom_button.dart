import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.width,
      required this.color});
  final String text;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
          text,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
