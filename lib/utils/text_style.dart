import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get headingStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(fontWeight: FontWeight.bold),
    color: Colors.white,
  );
}

TextStyle get headingStyle2 {
  return GoogleFonts.poppins(
    textStyle: TextStyle(fontWeight: FontWeight.w600),
    color: Colors.white,
  );
}

TextStyle get subTitleTextStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(fontWeight: FontWeight.w400),
    fontSize: 14,
  );
}