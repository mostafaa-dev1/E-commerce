import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newww/core/theming/colors.dart';

class AppFonts {
  static TextStyle style16 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle style16w500 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle style18 = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.primaryColor);
  static TextStyle style20 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle style13 = GoogleFonts.poppins(
    fontSize: 13,
    color: Colors.black,
    decoration: TextDecoration.lineThrough,
  );

  static TextStyle style14wB = GoogleFonts.poppins(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);

  static TextStyle style15 = GoogleFonts.poppins(
      color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15);

  static TextStyle style28B = GoogleFonts.poppins(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28);

  static TextStyle style20w600 = GoogleFonts.poppins(
      color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20);

  static TextStyle style20B = GoogleFonts.poppins(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
}
