import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

lightStyle({@required double fontSize, @required Color color}) {
  return GoogleFonts.montserrat(
      fontSize: fontSize, color: color, fontWeight: FontWeight.w200);
}

regularStyle({@required double fontSize, @required Color color}) {
  return GoogleFonts.montserrat(color: color,fontSize: fontSize,fontWeight: FontWeight.w400);

}

boldStyle({@required double fontSize, @required Color color}) {
  return GoogleFonts.montserrat(
      fontSize: fontSize, color: color, fontWeight: FontWeight.w800);
}
