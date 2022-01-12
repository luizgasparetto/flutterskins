import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text buildTitle(String text, {Color color = Colors.white, double size = 22}) =>
    Text(
      text,
      style: GoogleFonts.montserrat(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
      ),
    );
