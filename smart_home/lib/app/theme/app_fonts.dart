import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle get textStyle => GoogleFonts.inter(color: Colors.white);

  static TextStyle get heading => GoogleFonts.inter(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get subtitle => GoogleFonts.inter(
    color: const Color(0xFF9E9E9E),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
